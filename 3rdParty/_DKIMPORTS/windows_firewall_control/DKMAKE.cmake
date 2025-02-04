#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ windows_firewall_control ############
# https://www.binisoft.org/wfc

dk_findProgram(WFC_EXE 	"wfcUI.exe"	"${ProgramFiles}/Malwarebytes/Windows Firewall Control")
dk_printVar(WFC_EXE)