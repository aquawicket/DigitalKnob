# https://github.com/AndroidSDKSources
# https://dl.google.com/android/repository/sources-24_r01.zip
# https://dl.google.com/android/repository/sources-26_r01.zip
if(NOT WIN_HOST)
#	return()
endif()

dk_depend(android-sdk)

dk_import(https://dl.google.com/android/repository/sources-26_r01.zip ${ANDROID-SDK}/sources/android-26)
