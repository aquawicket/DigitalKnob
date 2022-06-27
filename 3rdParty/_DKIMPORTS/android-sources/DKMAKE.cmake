# https://github.com/AndroidSDKSources
# https://dl.google.com/android/repository/sources-24_r01.zip
# https://dl.google.com/android/repository/sources-26_r01.zip
if(NOT WIN_HOST)
	return()
endif()


dk_set(ANDROIDSOURCES_FOLDER android-26)
dk_set(ANDROIDSOURCES_VERSION 26_r01)
dk_set(ANDROIDSOURCES_DL https://dl.google.com/android/repository/sources-${ANDROIDSOURCES_VERSION}.zip)
dk_set(ANDROIDSOURCES ${ANDROIDSDK}/sources/${ANDROIDSOURCES_FOLDER})
dk_makeDirectory(${ANDROIDSDK}/sources)
dk_install(${ANDROIDSOURCES_DL} ${ANDROIDSOURCES})
#dk_import(https://dl.google.com/android/repository/sources-26_r01.zip)