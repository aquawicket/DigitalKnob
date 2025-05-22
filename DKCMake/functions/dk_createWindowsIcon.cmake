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
# dk_createWindowsIcon(inpath, outpath)
#
#	@inpath		- Full path of the image file to use (.png)
#	@outpath	- Full path of the output file to save to (.ico)
#
function(dk_createWindowsIcon)
	dk_debugFunc(2)
	
	dk_assertPath("${ARGV0}")
	dk_depend(imagemagick)
	
	dk_dirname("${ARGV1}" dirname)
	dk_mkdir("${dirname}")
	
	dk_assertPath(IMAGEMAGICK_CONVERT_EXE)
	dk_nativePath("${IMAGEMAGICK_CONVERT_EXE}" IMAGEMAGICK_CONVERT_EXE_WIN)
	dk_nativePath("${ARGV0}" inpath_WIN)
	dk_nativePath("${ARGV1}" outpath_WIN)
	set(CONVERT_COMMAND "${IMAGEMAGICK_CONVERT_EXE_WIN} ${inpath_WIN} -define icon:auto-resize=256,128,64,48,32,16 ${outpath_WIN}")
	dk_replaceAll("${CONVERT_COMMAND}" "/" "\\" CONVERT_COMMAND)
	dk_debug(${CONVERT_COMMAND})
	#execute_process(COMMAND ${CONVERT_COMMAND})
	dk_command(${CONVERT_COMMAND})
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_validate(DKCPP_APPS_DIR "dk_DKBRANCH_DIR()")
	dk_createWindowsIcon("$ENV{DKCPP_APPS_DIR}/DKCore/icons/icon.png" "$ENV{DKCPP_APPS_DIR}/DKCore/icons/icon.ico")
endfunction()