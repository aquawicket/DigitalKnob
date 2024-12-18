#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### android-sources ######
# https://github.com/AndroidSDKSources
# https://androidsdkoffline.blogspot.com/p/android-sdk-sources-download.html


dk_depend(android-sdk)
dk_makeDirectory(${ANDROID_SDK}/sources)
dk_validate		(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParam	(${DKIMPORTS_DIR}/android-sources/dkconfig.txt ANDROID_SOURCES_DL)
dk_getFileParam	(${DKIMPORTS_DIR}/android-sources/dkconfig.txt ANDROID_SOURCES_VERSION)
dk_import(${ANDROID_SOURCES_DL} PATH ${ANDROID_SDK}/sources/android-${ANDROID_SOURCES_VERSION})

#dk_import(https://dl.google.com/android/repository/sources-27_r01.zip PATH ${ANDROID_SDK}/sources/android-27)
#dk_import(https://dl.google.com/android/repository/sources-28_r01.zip PATH ${ANDROID_SDK}/sources/android-28)
#dk_import(https://dl.google.com/android/repository/sources-29_r01.zip PATH ${ANDROID_SDK}/sources/android-29)
#dk_import(https://dl.google.com/android/repository/sources-30_r01.zip PATH ${ANDROID_SDK}/sources/android-30)
#dk_import(https://dl.google.com/android/repository/sources-31_r01.zip PATH ${ANDROID_SDK}/sources/android-31)
#dk_import(https://dl.google.com/android/repository/sources-32_r01.zip PATH ${ANDROID_SDK}/sources/android-32)
#dk_import(https://dl.google.com/android/repository/sources-33_r01.zip PATH ${ANDROID_SDK}/sources/android-33)
