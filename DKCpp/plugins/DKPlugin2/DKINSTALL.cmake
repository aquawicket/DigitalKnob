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


dk_importVariables(IMPORT_PATH "${CMAKE_CURRENT_LIST_DIR}" INSTALL_PATH "${CMAKE_CURRENT_LIST_DIR}")

############ DKPlugin2 ############
dk_depend(DK)
dk_dll(DKPlugin2)
dk_assets(DKPlugin2)

if(Windows_X86)
	dk_copy(${DKCPP_PLUGINS_DIR}/DKPlugin2/Windows_X86/Release/DKPlugin2.dll ${Target_App_Dir}/assets/Development/DKPlugin2 OVERWRITE)
endif()

if(Windows_X86_64)
	dk_copy(${DKCPP_PLUGINS_DIR}/DKPlugin2/Windows_X86_64/Release/DKPlugin2.dll ${Target_App_Dir}/assets/Development/DKPlugin2 OVERWRITE)
endif()
