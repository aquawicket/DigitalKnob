# https://dl.google.com/android/repository/platform-26_r02.zip

if(NOT ANDROID)
	dk_undepend(android-platforms)
	dk_return()
endif()

dk_depend(android-sdk)

dk_makeDirectory(${ANDROID-SDK}/platforms)
dk_import(https://dl.google.com/android/repository/platform-26_r02.zip PATH ${ANDROID-SDK}/platforms/android-26)
