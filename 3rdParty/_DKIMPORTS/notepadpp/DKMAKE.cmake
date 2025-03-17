#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ notepadpp ############
# https://notepad-plus-plus.org/
# https://github.com/notepad-plus-plus.git
dk_load(dk_builder)

dk_validate(host_triple "dk_host_triple()")
### BINARY DISTRIBUTIONS (PORTABLE) ###
WIN_ARM64_HOST_dk_set	(NOTEPADPP_DL https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.arm64.zip)
WIN_X86_HOST_dk_set		(NOTEPADPP_DL https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.zip)
WIN_X86_64_HOST_dk_set	(NOTEPADPP_DL https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.x64.zip)
dk_importVariables(${NOTEPADPP_DL})

### IMPORT ###
dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
dk_set(NOTEPADPP_DIR $ENV{DKTOOLS_DIR}/${NOTEPADPP_FOLDER})
dk_import(${NOTEPADPP_DL} PATH ${NOTEPADPP_DIR})
dk_set(NOTEPADPP_EXE "${NOTEPADPP_DIR}/notepad++.exe")
#dk_nativePath(${NOTEPADPP_EXE} NOTEPADPP_EXE_WINPATH)


### dark mode ###
dk_copy(${DKIMPORTS_DIR}/notepadpp/dark_config.xml ${NOTEPADPP_DIR}/config.xml OVERWRITE)


### dk_installNotepadppContextMenu.cmd ###
dk_command(${DKIMPORTS_DIR}/notepadpp/dk_installNotepadppContextMenu.cmd)


### dk_installNotepadppFileAssociations.cmd ###
dk_command(${DKIMPORTS_DIR}/notepadpp/dk_installNotepadppFileAssociations.cmd)
