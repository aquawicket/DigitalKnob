# https://github.com/AndroidSDKSources
# https://androidsdkoffline.blogspot.com/p/android-sdk-sources-download.html

if(NOT ANDROID)
	dk_undepend(android-sources)
	dk_return()
endif()


dk_depend(android-sdk)

dk_makeDirectory(${ANDROID_SDK}/sources)


dk_import(https://dl.google.com/android/repository/sources-26_r01.zip PATH ${ANDROID_SDK}/sources/android-26)
#dk_import(https://dl.google.com/android/repository/sources-27_r01.zip PATH ${ANDROID_SDK}/sources/android-27)
#dk_import(https://dl.google.com/android/repository/sources-28_r01.zip PATH ${ANDROID_SDK}/sources/android-28)
#dk_import(https://dl.google.com/android/repository/sources-29_r01.zip PATH ${ANDROID_SDK}/sources/android-29)
#dk_import(https://dl.google.com/android/repository/sources-30_r01.zip PATH ${ANDROID_SDK}/sources/android-30)
#dk_import(https://dl.google.com/android/repository/sources-31_r01.zip PATH ${ANDROID_SDK}/sources/android-31)
#dk_import(https://dl.google.com/android/repository/sources-32_r01.zip PATH ${ANDROID_SDK}/sources/android-32)
#dk_import(https://dl.google.com/android/repository/sources-33_r01.zip PATH ${ANDROID_SDK}/sources/android-33)
