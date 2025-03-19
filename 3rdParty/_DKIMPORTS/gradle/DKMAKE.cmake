#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ gradle ############
# https://gradle.org
# https://services.gradle.org/distributions/gradle-7.3-bin.zip

###### set ${bat} variable for windows ######
dk_validate(host_triple "dk_host_triple()")
if(WIN_HOST)
	dk_set(bat ".bat")
endif()

###### set GRADLE_USER_HOME environment variable ######
#dk_validate(ENV{DKCACHE_DIR{ "dk_DKCACHE_DIR()")
#dk_set(GRADLE_USER_HOME $ENV{DKCACHE_DIR}/.gradle)
dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
dk_set(GRADLE_USER_HOME $ENV{DKDOWNLOAD_DIR}/.gradle)