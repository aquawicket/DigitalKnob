#/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")

dk_depend(7z)


###### Folder-locker ######
# https://github.com/Albert-W/Folder-locker/archive/refs/heads/master.zip

### INSTALL ###
dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams	("$ENV{DKIMPORTS_DIR}/Folder-locker/dkconfig.txt")
dk_import			(${FOLDER-LOCKER_IMPORT} NAME Folder-locker)
message("${7ZA_EXE} x "${FOLDER-LOCKER}/FolderLocker-1.3.0.msi" -o${FOLDER-LOCKER}/TEMP")
execute_process(COMMAND ${7ZA_EXE} x "${FOLDER-LOCKER}/FolderLocker-1.3.0.msi" -o${FOLDER-LOCKER}/BIN)