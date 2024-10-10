#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_createWindowsIcon()
#
#	@inpath		- Full path of the image file to use (.png)
#	@outpath	- Full path of the output file to save to (.ico)
#
function(dk_createWindowsIcon inpath outpath)
	dk_debugFunc("\${ARGV}")
	dk_assertPath(inpath)
	
	dk_load(${DKIMPORTS_DIR}/imagemagick/DKMAKE.cmake)
	if(NOT EXISTS ${IMAGEMAGICK_CONVERT_EXE})
		dk_fatal("IMAGEMAGICK_CONVERT_EXE is invalid!")
	endif()
	dk_dirname(${outpath} dirname)
	dk_makeDirectory(${dirname})
	execute_process(COMMAND ${IMAGEMAGICK_CONVERT_EXE} ${inpath} -define icon:auto-resize=256,128,64,48,32,16 ${outpath})
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_validate(DKAPPS_DIR "dk_DKBRANCH_DIR()")
	dk_createWindowsIcon(${DKAPPS_DIR}/DKCore/icons/icon.png ${DKAPPS_DIR}/DKCore/icons/icon.ico)
endfunction()