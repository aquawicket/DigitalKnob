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


###### core-temp ######
# https://www.alcpu.com/CoreTemp
# https://www.alcpu.com/CoreTemp/Core-Temp-setup-v1.18.1.0.exe
# https://www.alcpu.com/CoreTemp/CoreTemp32.zip
# https://www.alcpu.com/CoreTemp/CoreTemp64.zip

dk_import()
dk_set(Core_Temp_exe "${core-temp}/Core Temp.exe")




