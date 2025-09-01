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


dk_importVariables(IMPORT_PATH "${CMAKE_CURRENT_LIST_DIR}" INSTALL_PATH "${CMAKE_CURRENT_LIST_DIR}")

############ DKPlugin1 ############
dk_depend(DK)
dk_dll(DKPlugin1)
dk_assets(DKPlugin1)

if(Windows_X86)
	dk_copy(${DKCPP_PLUGINS_DIR}/DKPlugin1/Windows_X86/Release/DKPlugin1.dll ${Target_App_Dir}/assets/DKPlugin1 OVERWRITE)
endif()

if(Windows_X86_64)
	dk_copy(${DKCPP_PLUGINS_DIR}/DKPlugin1/Windows_X86_64/Release/DKPlugin1.dll ${Target_App_Dir}/assets/DKPlugin1 OVERWRITE)
endif()
