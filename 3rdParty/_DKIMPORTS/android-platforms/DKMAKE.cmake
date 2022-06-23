# https://dl.google.com/android/repository/platform-26_r02.zip

if(NOT WIN_HOST)
	return()
endif()

dk_set(ANDROID-PLATFORMS_FOLDER android-26)
dk_set(ANDROID-PLATFORMS_VERSION 26_r02)
dk_set(ANDROID-PLATFORMS_DL https://dl.google.com/android/repository/platform-${ANDROID-PLATFORMS_VERSION}.zip)
dk_set(ANDROID-PLATFORMS ${ANDROIDSDK}/platforms/${ANDROID-PLATFORMS_FOLDER})
dk_makeDirectory(${ANDROIDSDK}/platforms)
dk_install(${ANDROID-PLATFORMS_DL} android-platforms ${ANDROID-PLATFORMS})
#dk_import(https://dl.google.com/android/repository/platform-26_r02.zip)

