# https://dl.google.com/android/repository/platform-tools_r31.0.3-windows.zip
# https://dl.google.com/android/repository/platform-tools_r31.0.3-darwin.zip
# https://dl.google.com/android/repository/platform-tools_r31.0.3-linux.zip


### VERSION ###
DKSET(ANDROIDPLATFORMTOOLS_VERSION 31.0.3)
WIN_DKSET(ANDROIDPLATFORMTOOLS_DL https://dl.google.com/android/repository/platform-tools_r${ANDROIDPLATFORMTOOLS_VERSION}-windows.zip)
MAC_DKSET(ANDROIDPLATFORMTOOLS_DL https://dl.google.com/android/repository/platform-tools_r${ANDROIDPLATFORMTOOLS_VERSION}-darwin.zip)
LINUX_DKSET(ANDROIDPLATFORMTOOLS_DL https://dl.google.com/android/repository/platform-tools_r${ANDROIDPLATFORMTOOLS_VERSION}-linux.zip)
DKSET(ANDROIDPLATFORMTOOLS ${ANDROIDSDK}/platform-tools/${ANDROIDPLATFORMTOOLS_VERSION})


### INSTALL ###
file(MAKE_DIRECTORY ${ANDROIDSDK}/platform-tools)
DKINSTALL(${ANDROIDPLATFORMTOOLS_DL} android-platform-tools ${ANDROIDPLATFORMTOOLS})
