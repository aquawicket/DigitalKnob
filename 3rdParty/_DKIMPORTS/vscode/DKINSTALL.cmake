#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ vscode ############
# https://code.visualstudio.com/docs/editor/portable
# https://fossies.org/windows/misc/VSCode-win32-x64-1.87.1.zip

if(EXISTS ${VSCODE_EXE})
	dk_debug("VSCODE_EXE already set to: ${VSCODE_EXE}")
	return()
endif()

dk_validate(host_triple "dk_host_triple()")
dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
### DOWNLOAD ###
MAC_HOST_dk_set				(VSCODE_DL https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/VSCode-darwin-universal.zip)
LINUX_ARM32_HOST_dk_set	    (VSCODE_DL https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/code-stable-armhf-1709684464.tar.gz)
LINUX_ARM64_HOST_dk_set   	(VSCODE_DL https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/code-stable-arm64-1709684476.tar.gz)
LINUX_X86_64_HOST_dk_set	(VSCODE_DL https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/code-stable-x64-1709684476.tar.gz)
WIN_ARM64_HOST_dk_set		(VSCODE_DL https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/VSCode-win32-arm64-1.87.1.zip)
#WIN_X86_64_HOST_dk_set		(VSCODE_DL https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/VSCode-win32-x64-1.87.1.zip)
WIN_X86_64_HOST_dk_set		(VSCODE_DL https://vscode.download.prss.microsoft.com/dbazure/download/stable/5437499feb04f7a586f677b155b039bc2b3669eb/VSCode-win32-x64-1.90.2.zip)

dk_assertVar(VSCODE_DL)

dk_basename(${VSCODE_DL} VSCODE_DL_FILE)
dk_removeExtension(${VSCODE_DL_FILE} VSCODE_FOLDER)
dk_convertToCIdentifier(${VSCODE_FOLDER} VSCODE_FOLDER)
dk_toLower(${VSCODE_FOLDER} VSCODE_FOLDER)

dk_set(VSCODE $ENV{DKTOOLS_DIR}/${VSCODE_FOLDER})
if(WIN_HOST)
	dk_set(VSCODE_EXE ${VSCODE}/Code.exe)
else()
	dk_set(VSCODE_EXE ${VSCODE}/code)
endif()



### IMPORT ###
if(NOT EXISTS ${VSCODE_EXE})
	dk_mkdir	($ENV{DKTOOLS_DIR})
	dk_import			(${VSCODE_DL} PATH ${VSCODE})
	dk_mkdir	(${VSCODE}/data)
endif()

#dk_printVar(VSCODE_EXE)