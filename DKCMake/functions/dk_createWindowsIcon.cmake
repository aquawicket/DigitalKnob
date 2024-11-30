#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_createWindowsIcon(inpath, outpath)
#
#	@inpath		- Full path of the image file to use (.png)
#	@outpath	- Full path of the output file to save to (.ico)
#
function(dk_createWindowsIcon)
	dk_debugFunc(2)
	
	dk_assertPath("${ARGV0}")
	dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
	dk_load("${DKIMPORTS_DIR}/imagemagick/DKMAKE.cmake")
	if(NOT EXISTS "${IMAGEMAGICK_CONVERT_EXE}")
		dk_fatal("IMAGEMAGICK_CONVERT_EXE is invalid!")
	endif()
	dk_dirname("${ARGV1}" dirname)
	dk_makeDirectory("${dirname}")
	
	dk_getNativePath("${IMAGEMAGICK_CONVERT_EXE}" IMAGEMAGICK_CONVERT_EXE_WIN)
	dk_getNativePath("${ARGV0}" inpath_WIN)
	dk_getNativePath("${ARGV1}" outpath_WIN)
	set(CONVERT_COMMAND ${IMAGEMAGICK_CONVERT_EXE_WIN} ${inpath_WIN} -define icon:auto-resize=256,128,64,48,32,16 ${outpath_WIN})
	dk_replaceAll("${CONVERT_COMMAND}" "/" "\\" CONVERT_COMMAND)
	execute_process(COMMAND ${CONVERT_COMMAND})
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_validate(DKAPPS_DIR "dk_DKAPPS_DIR()")
	dk_createWindowsIcon("${DKAPPS_DIR}/DKCore/icons/icon.png" "${DKAPPS_DIR}/DKCore/icons/icon.ico")
endfunction()