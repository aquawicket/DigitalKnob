# https://dl.google.com/android/repository/sys-img/android/armeabi-v7a-24_r07.zip
# https://dl.google.com/android/repository/sys-img/android/arm64-v8a-24_r07.zip
# https://dl.google.com/android/repository/sys-img/android/x86-24_r08.zip
# https://dl.google.com/android/repository/sys-img/android/x86_64-24_r08.zip
if(NOT WIN_HOST)
#	return()
endif()

dk_depend(android-sdk)

dk_import(https://dl.google.com/android/repository/sys-img/android/armeabi-v7a-24_r07.zip ${ANDROID-SDK}/system-images/24)
dk_import(https://dl.google.com/android/repository/sys-img/android/arm64-v8a-24_r07.zip ${ANDROID-SDK}/system-images/24)
dk_import(https://dl.google.com/android/repository/sys-img/android/x86-24_r08.zip ${ANDROID-SDK}/system-images/24)
dk_import(https://dl.google.com/android/repository/sys-img/android/x86_64-24_r08.zip ${ANDROID-SDK}/system-images/24)