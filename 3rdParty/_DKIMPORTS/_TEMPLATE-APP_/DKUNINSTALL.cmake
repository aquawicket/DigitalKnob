#/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### ventoy ######
# https://www.<PACKAGE_NAME>.com

### UnINSTALL ###
dk_validate			(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams	("$ENV{DKIMPORTS_DIR}/<PACKAGE_NAME>/dkconfig.txt")
dk_importVariables	(${<PACKAGE_NAME>_IMPORT} NAME <package_name>)
dk_delete			("${<PACKAGE_NAME>}")
