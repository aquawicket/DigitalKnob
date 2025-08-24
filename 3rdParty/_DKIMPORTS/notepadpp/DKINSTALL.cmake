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


############ notepadpp ############
# https://notepad-plus-plus.org/
# https://github.com/notepad-plus-plus.git

dk_validate(Target_Config  "dk_Target_Config()")

dk_validate(Host_Tuple "dk_Host_Tuple()")
set(NOTEPADPP_IMPORT "${NotepadPP_${Host_Tuple}_Import}")
dk_assertVar(NOTEPADPP_IMPORT)

dk_importVariables(${NOTEPADPP_IMPORT})

### IMPORT ###
dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
dk_set(NOTEPADPP $ENV{DKTOOLS_DIR}/${NOTEPADPP_FOLDER})
dk_import(${NOTEPADPP_IMPORT} _PATH_ ${NOTEPADPP})
dk_set(NOTEPADPP_EXE "${NOTEPADPP}/notepad++.exe")
#dk_nativePath(${NOTEPADPP_EXE} NOTEPADPP_EXE_WINPATH)


### dark mode ###
dk_copy($ENV{DKIMPORTS_DIR}/notepadpp/dark_config.xml ${NOTEPADPP}/config.xml OVERWRITE)


### dk_installNotepadppContextMenu.cmd ###
dk_exec($ENV{DKIMPORTS_DIR}/notepadpp/dk_installNotepadppContextMenu.cmd)


### dk_installNotepadppFileAssociations.cmd ###
dk_exec($ENV{DKIMPORTS_DIR}/notepadpp/dk_installNotepadppFileAssociations.cmd)
