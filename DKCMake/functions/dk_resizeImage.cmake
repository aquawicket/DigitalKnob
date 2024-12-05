#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_resizeImage(inpath width height outpath)
#
#	@inpath		- Full path of the image file to resize
#	@width		- The number of pixels in with to resize to 
#	@height		- The number of pixels in height to resize to
#	@outpath	- Full path of the output file to save to
#
function(dk_resizeImage inpath width height outpath)
	dk_debugFunc(4)
	
	dk_dirname(${outpath} outdir)
	dk_assertVar(outdir)
	dk_makeDirectory(${outdir})

	if(MAC_HOST)
		dk_executeProcess(sips -z ${width} ${height} ${inpath} --out ${outpath})
	else()
		dk_depend(imagemagick)
		dk_assertPath(IMAGEMAGICK_CONVERT_EXE)
		dk_executeProcess(${IMAGEMAGICK_CONVERT_EXE} ${inpath} -resize ${width}x${height} ${outpath})
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()