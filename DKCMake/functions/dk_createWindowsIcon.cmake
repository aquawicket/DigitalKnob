#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
# dk_createWindowsIcon(inpath, outpath)
#
#	@inpath		- Full path of the image file to use (.png)
#	@outpath	- Full path of the output file to save to (.ico)
#
function(dk_createWindowsIcon)
	dk_debugFunc(2)
	
	set(inpath "${ARGV0}")
	set(outpath "${ARGV1}")
	
	dk_assertPath("${inpath}")
	dk_dirname("${inpath}")
	dk_mkdir("${dk_dirname}")
	
	dk_depend(imagemagick)
	dk_assertVar(magick_exe)
	dk_assertPath("${magick_exe}")
	dk_pathToNative("${magick_exe}" magick_exe_WIN)
	dk_pathToNative("${inpath}" inpath_WIN)
	dk_pathToNative("${outpath}" outpath_WIN)
	set(CONVERT_COMMAND "${magick_exe_WIN} ${inpath_WIN} -define icon:auto-resize=256,128,64,48,32,16 ${outpath_WIN}")
	dk_replaceAll("${CONVERT_COMMAND}" "/" "\\" CONVERT_COMMAND)
	dk_debug(${CONVERT_COMMAND})
	#execute_process(COMMAND ${CONVERT_COMMAND})
	dk_exec(${CONVERT_COMMAND})
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_validate(DKCPP_APPS_DIR "dk_DKBRANCH_DIR()")
	dk_createWindowsIcon("${DKCPP_APPS_DIR}/DKCore/icon.png" "${DKCPP_APPS_DIR}/DKCore/icon.ico")
endfunction()