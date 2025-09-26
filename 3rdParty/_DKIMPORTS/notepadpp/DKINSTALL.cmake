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
set(notepadpp_Import "${NotepadPP_${Host_Tuple}_Import}")
dk_assertVar(notepadpp_Import)

dk_importVariables(${notepadpp_Import})

### IMPORT ###
dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
dk_set(notepadpp $ENV{DKTOOLS_DIR}/${notepadpp_Folder})
dk_import(${notepadpp_Import} _PATH_ ${notepadpp})
dk_set(notepadpp_exe "${notepadpp}/notepad++.exe")
#dk_nativePath(${notepadpp_exe} notepadpp_exe_WINPATH)


### dark mode ###
dk_copy($ENV{DKIMPORTS_DIR}/notepadpp/dark_config.xml ${notepadpp}/config.xml OVERWRITE)


### dk_installNotepadppContextMenu.cmd ###
dk_exec($ENV{DKIMPORTS_DIR}/notepadpp/dk_installNotepadppContextMenu.cmd)


### dk_installNotepadppFileAssociations.cmd ###
dk_exec($ENV{DKIMPORTS_DIR}/notepadpp/dk_installNotepadppFileAssociations.cmd)
