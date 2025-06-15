#/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### Batch-Script-Collection ######
# https://github.com/happy05dz/Batch-Script-Collection/archive/refs/heads/master.zip

### UnINSTALL ###
dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_importVariables	(${BATCH-SCRIPT-COLLECTION_IMPORT} NAME Batch-Script-Collection)
dk_delete			("${BATCH-SCRIPT-COLLECTION}")
