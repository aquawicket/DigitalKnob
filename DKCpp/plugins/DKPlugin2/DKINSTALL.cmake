#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


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
