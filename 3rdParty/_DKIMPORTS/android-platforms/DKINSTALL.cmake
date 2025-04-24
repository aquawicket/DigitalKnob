#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### android-platforms ######
# https://dl.google.com/android/repository/platform-26_r02.zip

dk_depend(android-sdk)
dk_mkdir(${ANDROID_SDK}/platforms)

dk_validate(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParam($ENV{DKIMPORTS_DIR}/android-platforms/dkconfig.txt ANDROID_PLATFORMS_DL)
dk_getFileParam($ENV{DKIMPORTS_DIR}/android-platforms/dkconfig.txt ANDROID_PLATFORMS_FOLDER)
dk_import(${ANDROID_PLATFORMS_DL} PATH ${ANDROID_SDK}/platforms/${ANDROID_PLATFORMS_FOLDER})
