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
dk_validate		(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_import		(${ANDROID_SOURCES_DL} PATH ${ANDROID_SDK}/sources/android-${ANDROID_SOURCES_VERSION})

#dk_import(https://dl.google.com/android/repository/sources-27_r01.zip PATH ${ANDROID_SDK}/sources/android-27)
#dk_import(https://dl.google.com/android/repository/sources-28_r01.zip PATH ${ANDROID_SDK}/sources/android-28)
#dk_import(https://dl.google.com/android/repository/sources-29_r01.zip PATH ${ANDROID_SDK}/sources/android-29)
#dk_import(https://dl.google.com/android/repository/sources-30_r01.zip PATH ${ANDROID_SDK}/sources/android-30)
#dk_import(https://dl.google.com/android/repository/sources-31_r01.zip PATH ${ANDROID_SDK}/sources/android-31)
#dk_import(https://dl.google.com/android/repository/sources-32_r01.zip PATH ${ANDROID_SDK}/sources/android-32)
#dk_import(https://dl.google.com/android/repository/sources-33_r01.zip PATH ${ANDROID_SDK}/sources/android-33)
