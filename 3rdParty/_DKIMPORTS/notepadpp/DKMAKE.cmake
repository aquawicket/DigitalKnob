include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_validate(host_triple "dk_getHostTriple()")
# https://notepad-plus-plus.org/
# https://github.com/notepad-plus-plus.git



	
### BINARY DISTRIBUTIONS (PORTABLE) ###
WIN_ARM64_HOST_dk_set	(NOTEPADPP_DL https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.arm64.zip)
WIN_X86_HOST_dk_set		(NOTEPADPP_DL https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.zip)
WIN_X86_64_HOST_dk_set	(NOTEPADPP_DL https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.x64.zip)

## Get NOTEPADPP_DL_FILE, NOTEPADPP_FOLDER
if(NOT NOTEPADPP_DL)
	return()
endif()

dk_basename(${NOTEPADPP_DL} NOTEPADPP_DL_FILE)
dk_removeExtension(${NOTEPADPP_DL_FILE} NOTEPADPP_FOLDER)
dk_convertToCIdentifier(${NOTEPADPP_FOLDER} NOTEPADPP_FOLDER)


### IMPORT ###
dk_validate(DKTOOLS_DIR "dk_getDKPaths()")
dk_set(NOTEPADPP ${DKTOOLS_DIR}/${NOTEPADPP_FOLDER})
dk_import(${NOTEPADPP_DL} PATH ${NOTEPADPP})
dk_set(NOTEPADPP_EXE "${NOTEPADPP}/notepad++.exe")
dk_getNativePath(${NOTEPADPP_EXE} NOTEPADPP_EXE_WINPATH)


### dark mode ###
dk_copy(${DKIMPORTS_DIR}/notepadpp/dark_config.xml ${NOTEPADPP}/config.xml OVERWRITE)


### dk_installNotepadppContextMenu.cmd ###
dk_command(${DKIMPORTS_DIR}/notepadpp/dk_installNotepadppContextMenu.cmd)


### dk_installNotepadppFileAssociations.cmd ###
dk_command(${DKIMPORTS_DIR}/notepadpp/dk_installNotepadppFileAssociations.cmd)
