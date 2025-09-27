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


###### Folder-locker ######
# https://github.com/Albert-W/Folder-locker
# https://github.com/Albert-W/Folder-locker/archive/refs/heads/master.zip

### INSTALL ###
dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_import			(${folder_locker_Import})
dk_set(folderLocker.exe "${FOLDER-LOCKER}/BIN/folderLocker.exe")
if(EXISTS ${folderLocker.exe})
	dk_debug("folderLocker.exe already installed")
	return()
endif()

dk_depend(7z)
message("${7za_exe} x \"${FOLDER-LOCKER}/FolderLocker-1.3.0.msi\" -o${FOLDER-LOCKER}/TEMP")
execute_process(COMMAND ${7za_exe} x "${FOLDER-LOCKER}/FolderLocker-1.3.0.msi" -o${FOLDER-LOCKER}/BIN)
dk_debug("folderLocker.exe = ${folderLocker.exe}")