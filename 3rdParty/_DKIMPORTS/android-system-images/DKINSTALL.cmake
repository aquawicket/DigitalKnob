#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### android-system-images ######
# https://androidsdkoffline.blogspot.com/p/android-sysimg-arm-v7a-direct-download.html
# https://androidsdkoffline.blogspot.com/p/android-sysimg-arm-v8a-direct-download.html


dk_depend(android-sdk)
dk_mkdir(${ANDROID_SDK}/system-images)

# 24
#dk_import(https://dl.google.com/android/repository/sys-img/android/armeabi-v7a-24_r07.zip PATH ${ANDROID_SDK}/system-images/24)
#dk_import(https://dl.google.com/android/repository/sys-img/android/arm64-v8a-24_r07.zip PATH ${ANDROID_SDK}/system-images/24)
#dk_import(https://dl.google.com/android/repository/sys-img/android/x86-24_r08.zip PATH ${ANDROID_SDK}/system-images/24)
#dk_import(https://dl.google.com/android/repository/sys-img/android/x86_64-24_r08.zip PATH ${ANDROID_SDK}/system-images/24)

# 25
#dk_import(https://dl.google.com/android/repository/sys-img/android/arm64-v8a-25_r02.zip PATH ${ANDROID_SDK}/system-images/25)
#dk_import(https://dl.google.com/android/repository/sys-img/android/x86-25_r01.zip PATH ${ANDROID_SDK}/system-images/25)
#dk_import(https://dl.google.com/android/repository/sys-img/android/x86_64-25_r01.zip PATH ${ANDROID_SDK}/system-images/25)

# 26
#dk_import(https://dl.google.com/android/repository/sys-img/android/arm64-v8a-26_r01.zip PATH ${ANDROID_SDK}/system-images/26)
#dk_import(https://dl.google.com/android/repository/sys-img/android/x86-26_r01.zip PATH ${ANDROID_SDK}/system-images/26)
#dk_import(https://dl.google.com/android/repository/sys-img/android/x86_64-26_r01.zip PATH ${ANDROID_SDK}/system-images/26)

# 27
#dk_import(https://dl.google.com/android/repository/sys-img/android/arm64-v8a-27_r01.zip PATH ${ANDROID_SDK}/system-images/27)
#dk_import(https://dl.google.com/android/repository/sys-img/android/x86-27_r01.zip PATH ${ANDROID_SDK}/system-images/27)
#dk_import(https://dl.google.com/android/repository/sys-img/android/x86_64-27_r01.zip PATH ${ANDROID_SDK}/system-images/27)

# 28
#dk_import(https://dl.google.com/android/repository/sys-img/android/arm64-v8a-28_r01.zip PATH ${ANDROID_SDK}/system-images/28)
#dk_import(https://dl.google.com/android/repository/sys-img/android/x86-28_r04.zip PATH ${ANDROID_SDK}/system-images/28)
#dk_import(https://dl.google.com/android/repository/sys-img/android/x86_64-28_r04.zip PATH ${ANDROID_SDK}/system-images/28)


dk_validate		(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_import		("https://dl.google.com/android/repository/sys-img/android/armeabi-v7a-24_r07.zip")

#dk_getFileParam($ENV{DKIMPORTS_DIR}/android-system-images/dkconfig.txt ANDROID_SYSTEM_IMAGES_DL)
#dk_import		(${ANDROID_SYSTEM_IMAGES_DL} PATH ${ANDROID_SDK}/system-images/${ANDROID_SYSTEM_IMAGES_VERSION})
