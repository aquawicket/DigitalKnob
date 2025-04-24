#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_createWindowsIcon()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_createWindowsIcon(inpath, outpath)
>>>>>>> Development
#
#	@inpath		- Full path of the image file to use (.png)
#	@outpath	- Full path of the output file to save to (.ico)
#
<<<<<<< HEAD
function(dk_createWindowsIcon inpath outpath)
	dk_debugFunc()
	dk_assertPath(inpath)
	
	dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
	dk_load(${DKIMPORTS_DIR}/imagemagick/DKMAKE.cmake)
	if(NOT EXISTS ${IMAGEMAGICK_CONVERT_EXE})
		dk_fatal("IMAGEMAGICK_CONVERT_EXE is invalid!")
	endif()
	dk_dirname(${outpath} dirname)
	dk_makeDirectory(${dirname})
	
	file(TO_NATIVE_PATH "${IMAGEMAGICK_CONVERT_EXE}" IMAGEMAGICK_CONVERT_EXE_WIN)
	file(TO_NATIVE_PATH "${inpath}" inpath_WIN)
	file(TO_NATIVE_PATH "${outpath}" outpath_WIN)
	set(CONVERT_COMMAND ${IMAGEMAGICK_CONVERT_EXE_WIN} ${inpath_WIN} -define icon:auto-resize=256,128,64,48,32,16 ${outpath_WIN})
	dk_replaceAll("${CONVERT_COMMAND}" "/" "\\" CONVERT_COMMAND)
	execute_process(COMMAND ${CONVERT_COMMAND})
=======
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
>>>>>>> Development
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_validate(DKAPPS_DIR "dk_DKBRANCH_DIR()")
	dk_createWindowsIcon(${DKAPPS_DIR}/DKCore/icons/icon.png ${DKAPPS_DIR}/DKCore/icons/icon.ico)
=======
	dk_debugFunc(0)
	
	dk_validate(DKCPP_APPS_DIR "dk_DKBRANCH_DIR()")
	dk_createWindowsIcon("$ENV{DKCPP_APPS_DIR}/DKCore/icons/icon.png" "$ENV{DKCPP_APPS_DIR}/DKCore/icons/icon.ico")
>>>>>>> Development
endfunction()