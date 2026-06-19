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


############ notepadpp ############
# https://notepad-plus-plus.org
# https://github.com/notepad-plus-plus.git
# https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.arm64.zip
# https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.zip
# https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.x64.zip

dk_import()
dk_set(notepadpp_exe "${notepadpp}/notepad++.exe")
#dk_pathToNative(${notepadpp_exe} notepadpp_exe_WINPATH)


### dark mode ###
dk_copy(${DKIMPORTS_DIR}/notepadpp/config.xml ${notepadpp}/config.xml OVERWRITE)


### dk_installNotepadppContextMenu.cmd ###
dk_exec(${DKIMPORTS_DIR}/notepadpp/dk_installNotepadppContextMenu.cmd)


### dk_installNotepadppFileAssociations.cmd ###
dk_exec(${DKIMPORTS_DIR}/notepadpp/dk_installNotepadppFileAssociations.cmd)
