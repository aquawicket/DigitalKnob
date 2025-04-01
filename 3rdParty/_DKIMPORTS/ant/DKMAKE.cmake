#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### ant ######
# https://github.com/apache/ant.git

dk_validate		(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParam	($ENV{DKIMPORTS_DIR}/ant/dkconfig.txt ANT_DL)
dk_import		(${ANT_DL})

dk_setEnv("ANT_HOME" ${ANT})
dk_setEnv("VS_AntHome" ${ANT})
