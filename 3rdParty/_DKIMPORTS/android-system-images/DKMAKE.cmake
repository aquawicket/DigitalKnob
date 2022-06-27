# https://dl.google.com/android/repository/sys-img/android/armeabi-v7a-24_r07.zip
# https://dl.google.com/android/repository/sys-img/android/arm64-v8a-24_r07.zip
# https://dl.google.com/android/repository/sys-img/android/x86-24_r08.zip
# https://dl.google.com/android/repository/sys-img/android/x86_64-24_r08.zip
if(NOT WIN_HOST)
	return()
endif()


#dk_import(https://dl.google.com/android/repository/sys-img/android/armeabi-v7a-24_r07.zip)
#dk_import(https://dl.google.com/android/repository/sys-img/android/arm64-v8a-24_r07.zip)
#dk_import(https://dl.google.com/android/repository/sys-img/android/x86-24_r08.zip)
#dk_import(https://dl.google.com/android/repository/sys-img/android/x86_64-24_r08.zip)


dk_set(ANDROID-SYSTEM-IMAGES_VERSION 24)
dk_set(ANDROID-SYSTEM-IMAGES ${ANDROIDSDK}/system-images/${ANDROID-SYSTEM-IMAGES_VERSION})
dk_makeDirectory(${ANDROIDSDK}/system-images)
dk_install(https://dl.google.com/android/repository/sys-img/android/armeabi-v7a-24_r07.zip ${ANDROID-SYSTEM-IMAGES})
dk_install(https://dl.google.com/android/repository/sys-img/android/arm64-v8a-24_r07.zip ${ANDROID-SYSTEM-IMAGES})
dk_install(https://dl.google.com/android/repository/sys-img/android/x86-24_r08.zip ${ANDROID-SYSTEM-IMAGES})
dk_install(https://dl.google.com/android/repository/sys-img/android/x86_64-24_r08.zip ${ANDROID-SYSTEM-IMAGES})
