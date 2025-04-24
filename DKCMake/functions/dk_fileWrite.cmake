#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

##################################################################################
# dk_fileWrite(filepath, string)
#
#
function(dk_fileWrite filepath str) 
<<<<<<< HEAD
	dk_debugFunc()
	if(NOT ${ARGC} EQUAL 2)
		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGC}:${ARGV}): incorrect number of arguments")
	endif()
	
	file(WRITE ${filepath} "${str}")
=======
	#dk_debugFunc(2)
	
	file(WRITE "${filepath}" "${str}")
>>>>>>> Development
endfunction()




<<<<<<< HEAD
function(DKTEST) ########################################################################
	dk_debugFunc()
=======



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
>>>>>>> Development
	
	#dk_fileWrite("dk_fileWrite_TEST.txt" "string written by dk_fileWrite")
	
	dk_set(DESKTOP_FILE
<<<<<<< HEAD
			"[Desktop Entry]\n"
			"Encoding=UTF-8\n"
			"Version=1.0\n"
			"Type=Application\n"
			"Terminal=true\n"
			"Name=\${APP_NAME}\n"
			"Exec=\${DK_PROJECT_DIR}/\${triple}/Debug/\${APP_NAME}\n"
			"Icon=\${DK_PROJECT_DIR}/icons/icon.png\n")
		list(JOIN DESKTOP_FILE "" DESKTOP_FILE)
		dk_fileWrite("APP_NAME.desktop" "${DESKTOP_FILE}")
=======
		"[Desktop Entry]\n"
		"Encoding=UTF-8\n"
		"Version=1.0\n"
		"Type=Application\n"
		"Terminal=true\n"
		"Name=\${APP_NAME}\n"
		"Exec=\${DK_Project_Dir}/\${target_triple}/Debug/\${APP_NAME}\n"
		"Icon=\${DK_Project_Dir}/icons/icon.png\n")

	list(JOIN DESKTOP_FILE "" DESKTOP_FILE)
	dk_fileWrite("APP_NAME.desktop" "${DESKTOP_FILE}")
>>>>>>> Development
endfunction()
