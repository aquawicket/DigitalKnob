#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ gradle ############
# https://gradle.org

dk_validate(host_triple "dk_host_triple()")
if(WIN_HOST)
	dk_set(bat ".bat")
endif()
dk_set(GRADLE_USER_HOME ${DIGITALKNOB_DIR}/.gradle)