#/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### batch-file-examples ######
# https://github.com/Archive-projects/Batch-File-examples/archive/refs/heads/master.zip

### UnINSTALL ###
dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_importVariables	(${BATCH-FILE-EXAMPLES_IMPORT} NAME batch-file-examples)
dk_delete			("${BATCH-FILE-EXAMPLES}")
