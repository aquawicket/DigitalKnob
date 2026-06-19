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


############ mingw-win32-application ############
# https://www.transmissionzero.co.uk/computing/win32-apps-with-mingw
# https://github.com/TransmissionZero/MinGW-Win32-Application
# https://github.com/TransmissionZero/MinGW-Win32-Application.git
# https://github.com/TransmissionZero/MinGW-Win32-Application/archive/refs/heads/master.zip

dk_import()
