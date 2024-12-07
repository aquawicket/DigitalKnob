#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ gradle ############
# https://gradle.org

###### set ${bat} variable for windows ######
dk_validate(host_triple "dk_host_triple()")
if(WIN_HOST)
	dk_set(bat ".bat")
endif()

###### set GRADLE_USER_HOME environment variable ######
dk_validate(DKCACHE_DIR "dk_DKCACHE_DIR()")
dk_set(GRADLE_USER_HOME ${DKCACHE_DIR}/.gradle)