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
	dk_debugFunc()
	dk_assertPath(inpath)
	
	dk_load(${DKIMPORTS_DIR}/imagemagick/DKMAKE.cmake)
	if(NOT EXISTS ${IMAGEMAGICK_CONVERT_EXE})
		dk_fatal("IMAGEMAGICK_CONVERT_EXE is invalid!")
	endif()
	dk_dirname(${outpath} dirname)
	dk_makeDirectory(${dirname})
	
	file(TO_NATIVE_PATH "${IMAGEMAGICK_CONVERT_EXE}" IMAGEMAGICK_CONVERT_EXE_WIN)
	file(TO_NATIVE_PATH "${inpath}" inpath_WIN)
	file(TO_NATIVE_PATH "${outpath}" outpath_WIN)
	execute_process(COMMAND ${IMAGEMAGICK_CONVERT_EXE_WIN} ${inpath_WIN} -define icon:auto-resize=256,128,64,48,32,16 ${outpath_WIN})
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_validate(DKAPPS_DIR "dk_DKBRANCH_DIR()")
	dk_createWindowsIcon(${DKAPPS_DIR}/DKCore/icons/icon.png ${DKAPPS_DIR}/DKCore/icons/icon.ico)
endfunction()