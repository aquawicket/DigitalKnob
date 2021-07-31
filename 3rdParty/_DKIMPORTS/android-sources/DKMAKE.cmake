# https://dl.google.com/android/repository/sources-24_r01.zip
if(NOT ANDROID)
	return()
endif()


### VERSION ###
DKSET(ANDROIDSOURCES_FOLDER android-24)
DKSET(ANDROIDSOURCES_VERSION 24_r01)
DKSET(ANDROIDSOURCES_SHA1 ???)
DKSET(ANDROIDSOURCES ${ANDROIDSDK}/sources/${ANDROIDSOURCES_FOLDER})
DKSET(ANDROIDSOURCES_DL https://dl.google.com/android/repository/sources-${ANDROIDSOURCES_VERSION}.zip)


### INSTALL ###
file(MAKE_DIRECTORY ${3RDPARTY}/android-sdk/sources)
DKINSTALL(${ANDROIDSOURCES_DL} android-sources android-sdk/sources/${ANDROIDSOURCES_FOLDER})
