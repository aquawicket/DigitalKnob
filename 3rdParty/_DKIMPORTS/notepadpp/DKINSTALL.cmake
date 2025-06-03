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
