#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_createFavIcon()
#
#	@inpath		- Full path of the image file to use (.png)
#	@outpath	- Full path of the output file to save to (.ico)
#
function(dk_createFavIcon inpath outpath)
	dk_debugFunc()
	
	dk_load(${DKIMPORTS_DIR}/imagemagick/DKMAKE.cmake)
	if(IMAGEMAGICK_CONVERT_EXE)
		dk_executeProcess(${IMAGEMAGICK_CONVERT_EXE} ${inpath} -define icon:auto-resize=16 ${outpath})
	else()
		dk_fatal("IMAGEMAGICK_CONVERT_EXE is invalid!")
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()