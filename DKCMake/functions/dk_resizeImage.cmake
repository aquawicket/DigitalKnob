#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
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
	dk_mkdir(${outdir})
	dk_assertPath(${outdir})
	
	if(Android_Host)
		dk_installPackage(imagemagick)

		###### BASH ######
		execute_process(COMMAND bash -c "command -v 'bash'" OUTPUT_VARIABLE BASH_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
		if(EXISTS "${BASH_EXE}")
			execute_process(COMMAND bash -c "command -v 'bash'" OUTPUT_VARIABLE BASH_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
			execute_process(COMMAND ${BASH_EXE} -c "command -v 'convert'" OUTPUT_VARIABLE IMAGEMAGICK_CONVERT_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)	
			dk_assertPath(IMAGEMAGICK_CONVERT_EXE)
			#message("${cmnd}")
			set(cmnd ${BASH_EXE} -c "${IMAGEMAGICK_CONVERT_EXE} ${inpath} -resize ${width}x${height} ${outpath}")
		endif()

	elseif(Mac_Host)
		dk_exec(sips -z ${width} ${height} ${inpath} --out ${outpath})

	else()
		dk_depend(imagemagick)
		dk_findProgram(IMAGEMAGICK_CONVERT_EXE convert ${IMAGEMAGICK})
		dk_assertPath(IMAGEMAGICK_CONVERT_EXE)
		dk_exec(${IMAGEMAGICK_CONVERT_EXE} ${inpath} -resize ${width}x${height} ${outpath})
	
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	set(inpath "C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKCore/icons/icon.png")
	set(width 36)
	set(height 36)
	set(outpath "C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKCore/icons/icon_36x36.png")
	dk_resizeImage(${inpath} ${width} ${height} ${outpath})
endfunction()