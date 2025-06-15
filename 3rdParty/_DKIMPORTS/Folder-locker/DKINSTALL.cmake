#/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")




###### Folder-locker ######
# https://github.com/Albert-W/Folder-locker
# https://github.com/Albert-W/Folder-locker/archive/refs/heads/master.zip

### INSTALL ###
dk_validate			(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_import			(${FOLDER-LOCKER_IMPORT} NAME Folder-locker)
dk_set(folderLocker.exe "${FOLDER-LOCKER}/BIN/folderLocker.exe")
if(EXISTS ${folderLocker.exe})
	dk_debug("folderLocker.exe already installed")
	return()
endif()

dk_depend(7z)
message("${7ZA_EXE} x \"${FOLDER-LOCKER}/FolderLocker-1.3.0.msi\" -o${FOLDER-LOCKER}/TEMP")
execute_process(COMMAND ${7ZA_EXE} x "${FOLDER-LOCKER}/FolderLocker-1.3.0.msi" -o${FOLDER-LOCKER}/BIN)
dk_debug("folderLocker.exe = ${folderLocker.exe}")