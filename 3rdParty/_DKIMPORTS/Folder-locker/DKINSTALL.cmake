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


###### Folder-locker ######
# https://github.com/Albert-W/Folder-locker
# https://github.com/Albert-W/Folder-locker/archive/refs/heads/master.zip

dk_import	(${Folder-locker_Import})
dk_set		(folderLocker.exe "${Folder-locker}/BIN/folderLocker.exe")
if(EXISTS ${folderLocker.exe})
	dk_debug("folderLocker.exe already installed")
	return()
endif()

dk_validate(7z "dk_depend(7z)")
message("${7za_exe} x \"${Folder-locker}/FolderLocker-1.3.0.msi\" -o${Folder-locker}/TEMP")
execute_process(COMMAND ${7za_exe} x "${Folder-locker}/FolderLocker-1.3.0.msi" -o${Folder-locker}/BIN)
dk_debug("folderLocker.exe = ${folderLocker.exe}")