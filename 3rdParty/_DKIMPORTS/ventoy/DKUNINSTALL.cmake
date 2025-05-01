#/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### ventoy ######
# https://www.ventoy.net
# https://sourceforge.net/projects/ventoy/files/v1.1.05/ventoy-1.1.05-windows.zip

### UnINSTALL ###
dk_validate			(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams	("$ENV{DKIMPORTS_DIR}/ventoy/dkconfig.txt")
dk_importVariables	(${VENTOY_IMPORT} NAME ventoy)
dk_delete			("${VENTOY}")
