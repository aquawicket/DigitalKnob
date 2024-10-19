#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### ant ######
# https://github.com/apache/ant.git
# https://mirror.cogentco.com/pub/apache/ant/binaries/apache-ant-1.9.15-bin.zip
# https://github.com/apache/ant/archive/0db467a379916a3d1fcf6956a0fedaf94cc25be3.zip

dk_validate		(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
dk_getFileParam	(${DKIMPORTS_DIR}/ant/ant.txt ANT_IMPORT)
dk_import		(${ANT_IMPORT})

dk_setEnv("ANT_HOME" ${ANT})
dk_setEnv("VS_AntHome" ${ANT})
