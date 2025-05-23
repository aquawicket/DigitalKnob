#/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### Microsoft-Activation-Scripts ######
# https://github.com/massgravel/Microsoft-Activation-Scripts/archive/refs/heads/master.zip

### UnINSTALL ###
dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams	("$ENV{DKIMPORTS_DIR}/Microsoft-Activation-Scripts/dkconfig.txt")
dk_importVariables	(${MICROSOFT-ACTIVATION-SCRIPTS_IMPORT} NAME Microsoft-Activation-Scripts)
dk_delete			("${MICROSOFT-ACTIVATION-SCRIPTS}")
