#!/usr/bin/cmake -P
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
		"Name=\${APP_NAME}\n"
		"Exec=\${DK_Project_Dir}/\${Target_Tuple}/Debug/\${APP_NAME}\n"
		"Icon=\${DK_Project_Dir}/icons/icon.png\n")

	list(JOIN DESKTOP_FILE "" DESKTOP_FILE)
	dk_fileWrite("APP_NAME.desktop" "${DESKTOP_FILE}")
endfunction()
