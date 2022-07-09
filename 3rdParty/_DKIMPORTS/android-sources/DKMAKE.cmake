# https://github.com/AndroidSDKSources
# https://dl.google.com/android/repository/sources-24_r01.zip
# https://dl.google.com/android/repository/sources-26_r01.zip


#dk_set(ANDROID-SDK ${3RDPARTY}/android-sdk)
#dk_makeDirectory(${ANDROID-SDK})
dk_depend(android-sdk)


dk_makeDirectory(${ANDROID-SDK}/sources)
dk_import(https://dl.google.com/android/repository/sources-26_r01.zip PATH ${ANDROID-SDK}/sources/android-26)
