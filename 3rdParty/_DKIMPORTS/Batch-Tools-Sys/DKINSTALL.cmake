#/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### Batch-Tools-Sys ######
# https://github.com/Kerbalnut/Batch-Tools-SysAdmin/archive/refs/heads/master.zip

### INSTALL ###
dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams	("$ENV{DKIMPORTS_DIR}/Batch-Tools-Sys/dkconfig.txt")
dk_import			(${BATCH-TOOLS-SYS_IMPORT} NAME Batch-Tools-Sys)
