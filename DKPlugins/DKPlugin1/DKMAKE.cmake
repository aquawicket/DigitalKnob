#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ DKPlugin1 ############
dk_depend(DK)
dk_dll(DKPlugin1)
dk_assets(DKPlugin1)

if(WIN_X86)
	dk_copy(${DKPLUGINS_DIR}/DKPlugin1/win_x86/Release/DKPlugin1.dll ${DK_Project_Dir}/assets/DKPlugin1 OVERWRITE)
endif()

if(WIN_X86_64)
	dk_copy(${DKPLUGINS_DIR}/DKPlugin1/win_x86_64/Release/DKPlugin1.dll ${DK_Project_Dir}/assets/DKPlugin1 OVERWRITE)
endif()
