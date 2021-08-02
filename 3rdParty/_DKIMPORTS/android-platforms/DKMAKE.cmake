# https://dl.google.com/android/repository/platform-24_r02.zip
# https://dl.google.com/android/repository/platform-26_r02.zip

### VERSION ###
DKSET(ANDROIDPLATFORMS_FOLDER android-26)
DKSET(ANDROIDPLATFORMS_VERSION 26_r02)
DKSET(ANDROIDPLATFORMS_SHA1 ???)
DKSET(ANDROIDPLATFORMS ${ANDROIDSDK}/platforms/${ANDROIDPLATFORMS_FOLDER})
DKSET(ANDROIDPLATFORMS_DL https://dl.google.com/android/repository/platform-${ANDROIDPLATFORMS_VERSION}.zip)


### INSTALL ###
#file(MAKE_DIRECTORY ${ANDROIDSDK}/platforms)
DKINSTALL(${ANDROIDPLATFORMS_DL} android-platforms ${ANDROIDPLATFORMS})
