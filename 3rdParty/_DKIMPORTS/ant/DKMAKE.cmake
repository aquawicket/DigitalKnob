#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### ant ######
# https://github.com/apache/ant.git

dk_validate		(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParam	(${DKIMPORTS_DIR}/ant/dkconfig.txt ANT_DL)
dk_import		(${ANT_DL})

dk_setEnv("ANT_HOME" ${ANT})
dk_setEnv("VS_AntHome" ${ANT})
