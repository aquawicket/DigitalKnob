#/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### Batch-Script-Collection ######
# https://github.com/happy05dz/Batch-Script-Collection/archive/refs/heads/master.zip

### UnINSTALL ###
dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams	("$ENV{DKIMPORTS_DIR}/Batch-Script-Collection/dkconfig.txt")
dk_importVariables	(${BATCH-SCRIPT-COLLECTION_IMPORT} NAME Batch-Script-Collection)
dk_delete			("${BATCH-SCRIPT-COLLECTION}")
