#/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### webview2_runtime ######
# https://go.microsoft.com/fwlink/?linkid=2124701

### UnINSTALL ###
dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams	("$ENV{DKIMPORTS_DIR}/webview2_runtime/dkconfig.txt")
dk_importVariables	(${WEBVIEW2_RUNTIME_IMPORT} NAME webview2_runtime)
dk_delete			("${WEBVIEW2_RUNTIME}")
