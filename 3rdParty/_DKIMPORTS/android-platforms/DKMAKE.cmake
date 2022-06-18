if(NOT WIN_HOST)
	return()
endif()

# https://dl.google.com/android/repository/platform-26_r02.zip


#dk_import(https://dl.google.com/android/repository/platform-26_r02.zip)

dk_set(ANDROIDPLATFORMS_FOLDER android-26)
dk_set(ANDROIDPLATFORMS_VERSION 26_r02)
dk_set(ANDROIDPLATFORMS_DL https://dl.google.com/android/repository/platform-${ANDROIDPLATFORMS_VERSION}.zip)
dk_set(ANDROIDPLATFORMS ${ANDROIDSDK}/platforms/${ANDROIDPLATFORMS_FOLDER})
dk_makeDirectory(${ANDROIDSDK}/platforms)
DKINSTALL(${ANDROIDPLATFORMS_DL} android-platforms ${ANDROIDPLATFORMS})
