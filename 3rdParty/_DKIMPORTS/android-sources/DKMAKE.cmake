# https://dl.google.com/android/repository/sources-30_r01.zip
if(NOT ANDROID)
	return()
endif()


### VERSION ###
DKSET(ANDROIDSOURCES_VERSION 26_r02)
DKSET(ANDROIDSOURCES_SHA1 ???)
DKSET(ANDROIDSOURCES ${ANDROIDSDK}/sources/${ANDROIDSOURCES_VERSION})
DKSET(ANDROIDSOURCES_DL https://dl.google.com/android/repository/sources-30_r01.zip)


### INSTALL ###
DKINSTALL(ANDROIDSOURCES_DL android-sources android-sdk/sources/${ANDROIDSOURCES_VERSION})
