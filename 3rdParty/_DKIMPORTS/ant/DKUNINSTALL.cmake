#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### ant ######
# https://github.com/apache/ant.git
#
dk_validate			(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParams	("$ENV{DKIMPORTS_DIR}/ant/dkconfig.txt")
dk_importVariables	(${ANT_IMPORT} NAME ant)
dk_delete			("${ANT}")
