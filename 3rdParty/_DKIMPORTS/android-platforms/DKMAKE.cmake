#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### android-platforms ######
# https://dl.google.com/android/repository/platform-26_r02.zip

dk_depend(android-sdk)
dk_makeDirectory(${ANDROID_SDK}/platforms)

dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParam(${DKIMPORTS_DIR}/android-platforms/dkconfig.txt ANDROID_PLATFORMS_DL)
dk_getFileParam(${DKIMPORTS_DIR}/android-platforms/dkconfig.txt ANDROID_PLATFORMS_FOLDER)
dk_import(${ANDROID_PLATFORMS_DL} PATH ${ANDROID_SDK}/platforms/${ANDROID_PLATFORMS_FOLDER})
