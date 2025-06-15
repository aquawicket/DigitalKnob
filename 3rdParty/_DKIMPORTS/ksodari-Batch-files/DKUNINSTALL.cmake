#/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### ksodari-Batch-files ######
# https://github.com/ksodari/Batch-files/archive/refs/heads/master.zip

### UnINSTALL ###
dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_importVariables	(${KSODARI-BATCH-FILES_IMPORT} NAME ksodari-Batch-files)
dk_delete			("${KSODARI-BATCH-FILES}")
