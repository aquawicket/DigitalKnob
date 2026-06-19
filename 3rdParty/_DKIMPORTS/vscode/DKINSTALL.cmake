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


############ vscode ############
# https://code.visualstudio.com/docs/editor/portable
# https://fossies.org/windows/misc/VSCode-win32-x64-1.87.1.zip
# https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/code-stable-armhf-1709684464.tar.gz
# https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/code-stable-arm64-1709684476.tar.gz
# https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/code-stable-x64-1709684476.tar.gz
# https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/vscode-darwin-universal.zip
# https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/vscode-win32-arm64-1.87.1.zip
# https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/vscode-win32-x64-1.87.1.zip

#dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
#set(vscode_Import "${VSCode_${Host_Tuple}_Import}")
#dk_assertVar(vscode_Import)
#dk_basename(${vscode_Import} vscode_Import_Basename)
#dk_removeExtension(${vscode_Import_Basename} vscode_Install_Name)
#dk_convertToCIdentifier(${vscode_Install_Name} vscode_Install_Name)
#dk_toLower(${vscode_Install_Name} vscode_Install_Name)
#dk_set(vscode ${DKTOOLS_DIR}/${vscode_Install_Name})

dk_import()

if(Windows_Host)
	dk_set(vscode_exe ${vscode}/Code.exe)
else()
	dk_set(vscode_exe ${vscode}/code)
endif()

if(EXISTS ${vscode_exe})
	dk_debug("vscode_exe already set to: ${vscode_exe}")
	return()
endif()


#dk_mkdir	(${DKTOOLS_DIR})
#dk_import	(${vscode_Import} _PATH_ ${vscode})
dk_mkdir	(${vscode}/data)


dk_debug("vscode_exe = ${vscode_exe}")