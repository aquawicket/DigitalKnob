if(NOT WIN_HOST)
	return()
endif()

# https://dl.google.com/android/repository/platform-26_r02.zip

### VERSION ###
DKSET(ANDROIDPLATFORMS_FOLDER android-26)
DKSET(ANDROIDPLATFORMS_VERSION 26_r02)
DKSET(ANDROIDPLATFORMS_DL https://dl.google.com/android/repository/platform-${ANDROIDPLATFORMS_VERSION}.zip)
DKSET(ANDROIDPLATFORMS ${ANDROIDSDK}/platforms/${ANDROIDPLATFORMS_FOLDER})


### INSTALL ###
file(MAKE_DIRECTORY ${ANDROIDSDK}/platforms)
DKINSTALL(${ANDROIDPLATFORMS_DL} android-platforms ${ANDROIDPLATFORMS})
