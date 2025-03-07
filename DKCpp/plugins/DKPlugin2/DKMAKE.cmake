#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKPlugin2 ############
dk_depend(DK)
dk_dll(DKPlugin2)
dk_assets(DKPlugin2)

if(WIN_X86)
	dk_copy(${DKCPP_PLUGINS_DIR}/DKPlugin2/win_x86/Release/DKPlugin2.dll ${DK_Project_Dir}/assets/Development/DKPlugin2 OVERWRITE)
endif()

if(WIN_X86_64)
	dk_copy(${DKCPP_PLUGINS_DIR}/DKPlugin2/win_x86_64/Release/DKPlugin2.dll ${DK_Project_Dir}/assets/Development/DKPlugin2 OVERWRITE)
endif()
