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


############ vscode ############
# https://code.visualstudio.com/docs/editor/portable
# https://fossies.org/windows/misc/VSCode-win32-x64-1.87.1.zip

if(EXISTS ${VSCODE_EXE})
	dk_debug("VSCODE_EXE already set to: ${VSCODE_EXE}")
	return()
endif()

#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_validate(Host_Tuple "dk_Host_Tuple()")
dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
### DOWNLOAD ###
set(VSCODE_Import "${VSCode_${Host_Tuple}_Import}")


dk_assertVar(VSCODE_Import)

dk_basename(${VSCODE_Import} VSCODE_Import_FILE)
dk_removeExtension(${VSCODE_Import_FILE} VSCODE_Install_Name)
dk_convertToCIdentifier(${VSCODE_Install_Name} VSCODE_Install_Name)
dk_toLower(${VSCODE_Install_Name} VSCODE_Install_Name)

dk_set(VSCODE $ENV{DKTOOLS_DIR}/${VSCODE_Install_Name})
if(Windows_Host)
	dk_set(VSCODE_EXE ${VSCODE}/Code.exe)
else()
	dk_set(VSCODE_EXE ${VSCODE}/code)
endif()



### IMPORT ###
if(NOT EXISTS ${VSCODE_EXE})
	dk_mkdir	($ENV{DKTOOLS_DIR})
	dk_import	(${VSCODE_Import} _PATH_ ${VSCODE})
	dk_mkdir	(${VSCODE}/data)
endif()

#dk_printVar(VSCODE_EXE)