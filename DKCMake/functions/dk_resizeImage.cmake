#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

###############################################################################
# dk_resizeImage(inpath width height outpath)
#
#	@inpath		- Full path of the image file to resize
#	@width		- The number of pixels in with to resize to 
#	@height		- The number of pixels in height to resize to
#	@outpath	- Full path of the output file to save to
#
function(dk_resizeImage)
	dk_debugFunc(4)
	set(inpath ${ARGV0})
	set(width ${ARGV1})
	set(height ${ARGV2})
	set(outpath ${ARGV3})
	
	dk_dirname(${outpath} outdir)
	dk_assertVar(outdir)
	dk_makeDirectory(${outdir})
	dk_assertPath(${outdir})
	
	if(ANDROID_HOST)
		dk_installPackage(imagemagick)
		execute_process(COMMAND command -v convert OUTPUT_VARIABLE IMAGEMAGICK_CONVERT_EXE)
		dk_assertPath(IMAGEMAGICK_CONVERT_EXE)
		dk_executeProcess(${IMAGEMAGICK_CONVERT_EXE} ${inpath} -resize ${width}x${height} ${outpath})
	if(MAC_HOST)
		dk_executeProcess(sips -z ${width} ${height} ${inpath} --out ${outpath})
	else()
		dk_depend(imagemagick)
		dk_findProgram(IMAGEMAGICK_CONVERT_EXE convert ${IMAGEMAGICK})
		dk_assertPath(IMAGEMAGICK_CONVERT_EXE)
		dk_executeProcess(${IMAGEMAGICK_CONVERT_EXE} ${inpath} -resize ${width}x${height} ${outpath})
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	set(inpath "C:/Users/Administrator/digitalknob/Development/DKApps/DKCore/icons/icon.png")
	set(width 36)
	set(height 36)
	set(outpath "C:/Users/Administrator/digitalknob/Development/DKApps/DKCore/icons/icon_36x36.png")
	dk_resizeImage(${inpath} ${width} ${height} ${outpath})
endfunction()