#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ notepadpp ############
# https://notepad-plus-plus.org/
# https://github.com/notepad-plus-plus.git
dk_load(dk_builder)

dk_validate(Host_Tuple "dk_Host_Tuple()")
### BINARY DISTRIBUTIONS (PORTABLE) ###
Windows_Arm64_Host_dk_set	(NOTEPADPP_IMPORT https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.arm64.zip)
Windows_X86_Host_dk_set		(NOTEPADPP_IMPORT https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.zip)
Windows_X86_64_Host_dk_set	(NOTEPADPP_IMPORT https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.x64.zip)
dk_importVariables(${NOTEPADPP_IMPORT})

### IMPORT ###
dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
dk_set(NOTEPADPP_DIR $ENV{DKTOOLS_DIR}/${NOTEPADPP_FOLDER})
dk_import(${NOTEPADPP_IMPORT} PATH ${NOTEPADPP_DIR})
dk_set(NOTEPADPP_EXE "${NOTEPADPP_DIR}/notepad++.exe")
#dk_nativePath(${NOTEPADPP_EXE} NOTEPADPP_EXE_WINPATH)


### dark mode ###
dk_copy($ENV{DKIMPORTS_DIR}/notepadpp/dark_config.xml ${NOTEPADPP_DIR}/config.xml OVERWRITE)


### dk_installNotepadppContextMenu.cmd ###
dk_command($ENV{DKIMPORTS_DIR}/notepadpp/dk_installNotepadppContextMenu.cmd)


### dk_installNotepadppFileAssociations.cmd ###
dk_command($ENV{DKIMPORTS_DIR}/notepadpp/dk_installNotepadppFileAssociations.cmd)
