# https://dl.google.com/android/repository/platform-26_r02.zip
if(NOT ANDROID)
	return()
endif()


### VERSION ###
DKSET(ANDROIDPLATFORMS_VERSION 26_r02)
DKSET(ANDROIDPLATFORMS_SHA1 ???)
DKSET(ANDROIDPLATFORMS ${ANDROIDSDK}/platforms/${ANDROIDPLATFORMS_VERSION})
DKSET(ANDROIDPLATFORMS_DL https://dl.google.com/android/repository/platform-26_r02.zip)


### INSTALL ###
DKINSTALL(ANDROIDPLATFORMS_DL android-platforms android-sdk/platforms/${ANDROIDPLATFORMS_VERSION})
