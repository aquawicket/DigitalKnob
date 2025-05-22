#/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### useful_bat_files ######
# https://github.com/scottgriv/batch-useful_bat_files/archive/refs/heads/main.zip

### UnINSTALL ###
dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams	("$ENV{DKIMPORTS_DIR}/useful_bat_files/dkconfig.txt")
dk_importVariables	(${USEFUL_BAT_FILES_IMPORT} NAME useful_bat_files)
dk_delete			("${USEFUL_BAT_FILES}")
