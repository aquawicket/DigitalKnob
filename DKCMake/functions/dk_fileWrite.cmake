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

##################################################################################
# dk_fileWrite(filepath, string)
#
#
function(dk_fileWrite filepath str) 
	#dk_debugFunc(2)
	
	file(WRITE "${filepath}" "${str}")
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	#dk_fileWrite("dk_fileWrite_TEST.txt" "string written by dk_fileWrite")
	
	dk_set(DESKTOP_FILE
		"[Desktop Entry]\n"
		"Encoding=UTF-8\n"
		"Version=1.0\n"
		"Type=Application\n"
		"Terminal=true\n"
		"Name=\${Target_App}\n"
		"Exec=\${Target_App_Dir}/\${Target_Tuple}/Debug/\${Target_App}\n"
		"Icon=\${Target_App_Dir}/icons/icon.png\n")

	list(JOIN DESKTOP_FILE "" DESKTOP_FILE)
	dk_fileWrite("Target_App.desktop" "${DESKTOP_FILE}")
endfunction()
