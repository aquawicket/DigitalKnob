#/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### batch-file-examples ######
# https://github.com/Archive-projects/Batch-File-examples/archive/refs/heads/master.zip

### INSTALL ###
dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams	("$ENV{DKIMPORTS_DIR}/batch-file-examples/dkconfig.txt")
dk_import			(${BATCH-FILE-EXAMPLES_IMPORT} NAME batch-file-examples)
