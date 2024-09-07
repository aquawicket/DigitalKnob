include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_fileWrite(filepath, string)
#
#
function(dk_fileWrite filepath str) 
	dk_debugFunc(${ARGV})
	if(NOT ${ARGC} EQUAL 2)
		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()
	
	file(WRITE ${filepath} "${str}")
endfunction()




function(DKTEST) ########################################################################
	dk_debugFunc(${ARGV})
	
	#dk_fileWrite("dk_fileWrite_TEST.txt" "string written by dk_fileWrite")
	
	dk_set(DESKTOP_FILE
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
endfunction()
