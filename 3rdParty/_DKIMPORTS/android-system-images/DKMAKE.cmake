# https://dl.google.com/android/repository/sys-img/android/armeabi-v7a-24_r07.zip
# https://dl.google.com/android/repository/sys-img/android/arm64-v8a-24_r07.zip
# https://dl.google.com/android/repository/sys-img/android/x86-24_r08.zip
# https://dl.google.com/android/repository/sys-img/android/x86_64-24_r08.zip
if(NOT WIN_HOST)
	return()
endif()



#DKIMPORT(https://dl.google.com/android/repository/sys-img/android/armeabi-v7a-24_r07.zip)
#DKIMPORT(https://dl.google.com/android/repository/sys-img/android/arm64-v8a-24_r07.zip)
#DKIMPORT(https://dl.google.com/android/repository/sys-img/android/x86-24_r08.zip)
#DKIMPORT(https://dl.google.com/android/repository/sys-img/android/x86_64-24_r08.zip)


DKSET(ANDROIDIMAGES_VERSION 24)
DKSET(ANDROIDIMAGES ${ANDROIDSDK}/system-images/${ANDROIDIMAGES_VERSION})
dk_makeDirectory(${ANDROIDSDK}/system-images)
DKINSTALL(https://dl.google.com/android/repository/sys-img/android/armeabi-v7a-24_r07.zip android-system-images ${ANDROIDIMAGES})
DKINSTALL(https://dl.google.com/android/repository/sys-img/android/arm64-v8a-24_r07.zip android-system-images ${ANDROIDIMAGES})
DKINSTALL(https://dl.google.com/android/repository/sys-img/android/x86-24_r08.zip android-system-images ${ANDROIDIMAGES})
DKINSTALL(https://dl.google.com/android/repository/sys-img/android/x86_64-24_r08.zip android-system-images ${ANDROIDIMAGES})
