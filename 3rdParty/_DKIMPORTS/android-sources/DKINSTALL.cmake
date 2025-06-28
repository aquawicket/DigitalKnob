#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


###### android-sources ######
# https://github.com/AndroidSDKSources
# https://androidsdkoffline.blogspot.com/p/android-sdk-sources-download.html


dk_depend		(android-sdk)
dk_mkdir		(${ANDROID_SDK}/sources)
#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_import		(${ANDROID_SOURCES_DL} _PATH_ ${ANDROID_SDK}/sources/android-${ANDROID_SOURCES_VERSION})


