#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_createFavIcon()
#
#	@inpath		- Full path of the image file to use (.png)
#	@outpath	- Full path of the output file to save to (.ico)
#
function(dk_createFavIcon inpath outpath)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_load(${DKIMPORTS_DIR}/imagemagick/DKMAKE.cmake)
	if(IMAGEMAGICK_CONVERT_EXE)
		dk_executeProcess(${IMAGEMAGICK_CONVERT_EXE} ${inpath} -define icon:auto-resize=16 ${outpath})
	else()
		dk_fatal("IMAGEMAGICK_CONVERT_EXE is invalid!")
	endif()
=======
	dk_debugFunc(2)
	
	dk_depend(imagemagick)
	dk_assertPath(IMAGEMAGICK_CONVERT_EXE)
	dk_exec(${IMAGEMAGICK_CONVERT_EXE} ${inpath} -define icon:auto-resize=16 ${outpath})
>>>>>>> Development
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_todo()
=======
	dk_debugFunc(0)
	
	dk_createFavIcon(todo)
>>>>>>> Development
endfunction()