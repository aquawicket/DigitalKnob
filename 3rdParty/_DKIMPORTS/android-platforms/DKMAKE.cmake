# https://dl.google.com/android/repository/platform-26_r02.zip
if(NOT WIN_HOST)
#	return()
endif()

dk_depend(android-sdk)

dk_import(https://dl.google.com/android/repository/platform-26_r02.zip ${ANDROID-SDK}/platforms/android-26)
