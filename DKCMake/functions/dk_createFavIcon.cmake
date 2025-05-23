#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_createFavIcon()
#
#	@inpath		- Full path of the image file to use (.png)
#	@outpath	- Full path of the output file to save to (.ico)
#
function(dk_createFavIcon inpath outpath)
	dk_debugFunc(2)
	
	dk_depend(imagemagick)
	dk_assertPath(IMAGEMAGICK_CONVERT_EXE)
	dk_exec(${IMAGEMAGICK_CONVERT_EXE} ${inpath} -define icon:auto-resize=16 ${outpath})
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_createFavIcon(todo)
endfunction()