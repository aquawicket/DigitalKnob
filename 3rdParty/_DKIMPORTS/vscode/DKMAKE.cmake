# https://code.visualstudio.com/docs/editor/portable
# https://fossies.org/windows/misc/VSCode-win32-x64-1.87.1.zip



if(EXISTS ${VSCODE_EXE})
	dk_debug("VSCODE_EXE already set to: ${VSCODE_EXE}")
	return()
endif()


### DOWNLOAD ###
LINUX_X86_64_HOST_dk_set	(VSCODE_DL https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/code-stable-x64-1709684476.tar.gz)
#WIN_ARM64_HOST_dk_set		(VSCODE_DL VSCode-win32-arm64-1.87.1.zip)
WIN_X86_64_HOST_dk_set		(VSCODE_DL https://fossies.org/windows/misc/VSCode-win32-x64-1.87.1.zip)
if(VSCODE_DL)
	get_filename_component(VSCODE_DL_FILE ${VSCODE_DL} NAME)
	dk_removeExtension(${VSCODE_DL_FILE} VSCODE_FOLDER)
	string(MAKE_C_IDENTIFIER ${VSCODE_FOLDER} VSCODE_FOLDER)
	string(TOLOWER ${VSCODE_FOLDER} VSCODE_FOLDER)
endif()

dk_set(VSCODE ${DKTOOLS_DIR}/${VSCODE_FOLDER})
if(WIN_HOST)
	dk_set(VSCODE_EXE ${VSCODE}/Code.exe)
else()
	dk_set(VSCODE_EXE ${VSCODE}/Code)
endif()


### IMPORT ###
if(NOT EXISTS ${VSCODE_EXE})
	dk_import		(${VSCODE_DL} PATH ${VSCODE})
	
	#dk_download		(${VSCODE_DL} ${DKDOWNLOAD_DIR})
	#dk_info("Extracting ${VSCODE_DL_FILE}")
	#dk_remove(${DKDOWNLOAD_DIR}/UNZIPPED NOERROR)
	#dk_extract(${DKDOWNLOAD_DIR}/${VSCODE_DL_FILE} ${DKDOWNLOAD_DIR}/UNZIPPED)
	#dk_rename(${DKDOWNLOAD_DIR}/UNZIPPED/VSCode-linux-x64 ${VSCODE} OVERWRITE)
	## FIXME: the base must already exist to rename.  If DKTools doesn't exist, this will fail. 
endif()



### validate VSCODE variables ###
if(NOT VSCODE_EXE)
	dk_error("VSCODE_EXE:${VSCODE_EXE} is empty" NOASSERT)
endif()
if(NOT EXISTS ${VSCODE_EXE})
	dk_error("VSCODE_EXE:${VSCODE_EXE} does not exist" NOASSERT)
endif()


dk_set(VSCODE_EXE ${VSCODE_EXE}) # make the variable persistent

### print GIT info ###
dk_debug(VSCODE_EXE		PRINTVAR)