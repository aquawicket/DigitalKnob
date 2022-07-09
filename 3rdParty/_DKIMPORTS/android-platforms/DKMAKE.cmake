# https://dl.google.com/android/repository/platform-26_r02.zip


#dk_set(ANDROID-SDK ${3RDPARTY}/android-sdk)
#dk_makeDirectory(${ANDROID-SDK})
dk_depend(android-sdk)

dk_makeDirectory(${ANDROID-SDK}/platforms)
dk_import(https://dl.google.com/android/repository/platform-26_r02.zip PATH ${ANDROID-SDK}/platforms/android-26)
