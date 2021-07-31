# https://dl.google.com/android/repository/platform-24_r02.zip
if(NOT ANDROID)
	return()
endif()


### VERSION ###
DKSET(ANDROIDPLATFORMS_FOLDER android-24)
DKSET(ANDROIDPLATFORMS_VERSION 24_r02)
DKSET(ANDROIDPLATFORMS_SHA1 ???)
DKSET(ANDROIDPLATFORMS ${ANDROIDSDK}/platforms/${ANDROIDPLATFORMS_FOLDER})
DKSET(ANDROIDPLATFORMS_DL https://dl.google.com/android/repository/platform-${ANDROIDPLATFORMS_VERSION}.zip)


### INSTALL ###
file(MAKE_DIRECTORY ${3RDPARTY}/android-sdk/platforms)
DKINSTALL(${ANDROIDPLATFORMS_DL} android-platforms android-sdk/platforms/${ANDROIDPLATFORMS_FOLDER})
