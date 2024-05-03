# https://code.visualstudio.com/docs/editor/portable
# https://fossies.org/windows/misc/VSCode-win32-x64-1.87.1.zip

dk_validate(HOST "dk_getHostTriple()")
dk_validate(DKTOOLS_DIR "dk_getDKPaths()")

if(EXISTS ${VSCODE_EXE})
	dk_debug("VSCODE_EXE already set to: ${VSCODE_EXE}")
	return()
endif()


### DOWNLOAD ###
MAC_HOST_dk_set				(VSCODE_DL https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/VSCode-darwin-universal.zip)
#LINUX_ARM32_HOST_dk_set	(VSCODE_DL https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/code-stable-armhf-1709684464.tar.gz)
#LINUX_ARM64_HOST_dk_set	(VSCODE_DL https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/code-stable-arm64-1709684476.tar.gz)
LINUX_X86_64_HOST_dk_set	(VSCODE_DL https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/code-stable-x64-1709684476.tar.gz)
#WIN_ARM64_HOST_dk_set		(VSCODE_DL https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/VSCode-win32-arm64-1.87.1.zip)
WIN_X86_64_HOST_dk_set		(VSCODE_DL https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/VSCode-win32-x64-1.87.1.zip)

DK_ASSERT(VSCODE_DL)

get_filename_component(VSCODE_DL_FILE ${VSCODE_DL} NAME)
dk_removeExtension(${VSCODE_DL_FILE} VSCODE_FOLDER)
string(MAKE_C_IDENTIFIER ${VSCODE_FOLDER} VSCODE_FOLDER)
string(TOLOWER ${VSCODE_FOLDER} VSCODE_FOLDER)

dk_set(VSCODE ${DKTOOLS_DIR}/${VSCODE_FOLDER})
if(WIN_HOST)
	dk_set(VSCODE_EXE ${VSCODE}/Code.exe)
else()
	dk_set(VSCODE_EXE ${VSCODE}/code)
endif()



### IMPORT ###
if(NOT EXISTS ${VSCODE_EXE})
	dk_makeDirectory	(${DKTOOLS_DIR})
	dk_import			(${VSCODE_DL} PATH ${VSCODE})
	dk_makeDirectory	(${VSCODE}/data)
endif()


dk_set(VSCODE_EXE ${VSCODE_EXE}) # make the variable persistent

dk_debug(VSCODE_EXE)