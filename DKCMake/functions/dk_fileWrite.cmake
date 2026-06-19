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
# dk_fileWrite(filepath, string)
#
#
function(dk_fileWrite filepath) 
	#dk_debugFunc(2)
	
	list(JOIN ARGN "\n" str)
	file(WRITE "${filepath}" "${str}\n")
endfunction()




function(dkmessage)
	list(JOIN ARGV "\n" str)
	message("\n########################")
	message(${str})
	message("########################")
endfunction(dkmessage)

###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	#dk_fileWrite("dk_fileWrite_TEST.txt" "string written by dk_fileWrite")
	
	dk_fileWrite("Target_App.desktop" "
[Desktop Entry]
Encoding=UTF-8

Version=1.0
Type=Application
Terminal=true
Name=\${Target_App}
Exec=\${Target_App_Dir}/\${Target_Tuple}/Debug/\${Target_App}
Icon=\${Target_App_Dir}/icons/icon.png
	")
endfunction()
