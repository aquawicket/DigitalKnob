if(NOT WIN_HOST)
	return()
endif()

# https://dl.google.com/android/repository/platform-26_r02.zip


#DKIMPORT(https://dl.google.com/android/repository/platform-26_r02.zip)

DKSET(ANDROIDPLATFORMS_FOLDER android-26)
DKSET(ANDROIDPLATFORMS_VERSION 26_r02)
DKSET(ANDROIDPLATFORMS_DL https://dl.google.com/android/repository/platform-${ANDROIDPLATFORMS_VERSION}.zip)
DKSET(ANDROIDPLATFORMS ${ANDROIDSDK}/platforms/${ANDROIDPLATFORMS_FOLDER})
dk_makeDirectory(${ANDROIDSDK}/platforms)
DKINSTALL(${ANDROIDPLATFORMS_DL} android-platforms ${ANDROIDPLATFORMS})
