#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ gradle ############
# https://gradle.org
# https://services.gradle.org/distributions/gradle-7.3-bin.zip

###### set ${bat} variable for windows ######
if(Windows_Host)
	dk_set(bat ".bat")
endif()

###### set GRADLE_USER_HOME environment variable ######
#dk_validate(ENV{DKCACHE_DIR{ "dk_DKCACHE_DIR()")
#dk_set(GRADLE_USER_HOME ${DKCACHE_DIR}/.gradle)
dk_validate(DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR()")
dk_set(GRADLE_USER_HOME ${DKDOWNLOAD_DIR}/.gradle)