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


###### core-temp ######
# https://www.alcpu.com/CoreTemp
# https://www.alcpu.com/CoreTemp/Core-Temp-setup-v1.18.1.0.exe
# https://www.alcpu.com/CoreTemp/CoreTemp32.zip
# https://www.alcpu.com/CoreTemp/CoreTemp64.zip


### INSTALL ###
#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")

dk_validate(Host_Tuple "dk_Host_Tuple()")
if(Windows_X86_Host)
	dk_set	(core-temp_Import   ${core_temp_Windows_X86_Import})
elseif(Windows_X86_64_Host)
	dk_set	(core-temp_Import   ${core_temp_Windows_X86_64_Import})
else()
	dk_set	(core-temp_Import   ${core_temp_Setup_Import})
endif()

set(Core_Temp_exe "${core-temp}/Core Temp.exe")
dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
dk_import(${core-temp_Import} ROOT "${DKTOOLS_DIR}" PATCH)

set(Core_Temp_exe "${core-temp}/Core Temp.exe")




