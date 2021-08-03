# https://dl.google.com/android/repository/sources-24_r01.zip
# https://dl.google.com/android/repository/sources-26_r01.zip


### VERSION ###
DKSET(ANDROIDSOURCES_FOLDER android-26)
DKSET(ANDROIDSOURCES_VERSION 26_r01)
DKSET(ANDROIDSOURCES_DL https://dl.google.com/android/repository/sources-${ANDROIDSOURCES_VERSION}.zip)
DKSET(ANDROIDSOURCES ${ANDROIDSDK}/sources/${ANDROIDSOURCES_FOLDER})


### INSTALL ###
file(MAKE_DIRECTORY ${ANDROIDSDK}/sources)
DKINSTALL(${ANDROIDSOURCES_DL} android-sources ${ANDROIDSOURCES})
