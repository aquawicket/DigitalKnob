# https://dl.google.com/android/repository/sys-img/android/armeabi-v7a-24_r07.zip
# https://dl.google.com/android/repository/sys-img/android/arm64-v8a-24_r07.zip
# https://dl.google.com/android/repository/sys-img/android/x86-24_r08.zip
# https://dl.google.com/android/repository/sys-img/android/x86_64-24_r08.zip


dk_depend(android-sdk)

dk_makeDirectory(${ANDROID-SDK}/system-images)
dk_import(https://dl.google.com/android/repository/sys-img/android/armeabi-v7a-24_r07.zip PATH ${ANDROID-SDK}/system-images/24)
dk_import(https://dl.google.com/android/repository/sys-img/android/arm64-v8a-24_r07.zip PATH ${ANDROID-SDK}/system-images/24)
dk_import(https://dl.google.com/android/repository/sys-img/android/x86-24_r08.zip PATH ${ANDROID-SDK}/system-images/24)
dk_import(https://dl.google.com/android/repository/sys-img/android/x86_64-24_r08.zip PATH ${ANDROID-SDK}/system-images/24)