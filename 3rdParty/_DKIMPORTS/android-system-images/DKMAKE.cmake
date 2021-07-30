# https://dl.google.com/android/repository/sys-img/android/armeabi-v7a-24_r07.zip
# https://dl.google.com/android/repository/sys-img/android/arm64-v8a-24_r07.zip
# https://dl.google.com/android/repository/sys-img/android/x86-24_r08.zip
# https://dl.google.com/android/repository/sys-img/android/x86_64-24_r08.zip
if(NOT ANDROID)
	return()
endif()


### VERSION ###
DKSET(ANDROIDIMAGES_VERSION 24)
DKSET(ANDROIDIMAGES_SHA1 ???)
DKSET(ANDROIDIMAGES ${ANDROIDSDK}/system-images/${ANDROIDIMAGES_VERSION})


### INSTALL ###
file(MAKE_DIRECTORY ${3RDPARTY}/android-sdk/system-images)
DKINSTALL(https://dl.google.com/android/repository/sys-img/android/armeabi-v7a-24_r07.zip android-system-images android-sdk/system-images/${ANDROIDIMAGES_VERSION})
DKINSTALL(https://dl.google.com/android/repository/sys-img/android/arm64-v8a-24_r07.zip android-system-images android-sdk/system-images/${ANDROIDIMAGES_VERSION})
DKINSTALL(https://dl.google.com/android/repository/sys-img/android/x86-24_r08.zip android-system-images android-sdk/system-images/${ANDROIDIMAGES_VERSION})
DKINSTALL(https://dl.google.com/android/repository/sys-img/android/x86_64-24_r08.zip android-system-images android-sdk/system-images/${ANDROIDIMAGES_VERSION})
