#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKPlugin1 ############
dk_depend(DK)
dk_dll(DKPlugin1)
dk_assets(DKPlugin1)

if(Windows_X86)
	dk_copy(${DKCPP_PLUGINS_DIR}/DKPlugin1/Windows_X86/Release/DKPlugin1.dll ${DK_Project_Dir}/assets/DKPlugin1 OVERWRITE)
endif()

if(Windows_X86_64)
	dk_copy(${DKCPP_PLUGINS_DIR}/DKPlugin1/Windows_X86_64/Release/DKPlugin1.dll ${DK_Project_Dir}/assets/DKPlugin1 OVERWRITE)
endif()
