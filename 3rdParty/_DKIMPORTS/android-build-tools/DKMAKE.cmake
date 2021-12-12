# Installed Build Tools revision NN.N.N is corrupted" https://stackoverflow.com/a/68430992/688352

if(NOT CMAKE_HOST_WIN32)
	return()
endif()
# Information
# https://developer.android.com/studio/releases/build-tools
# https://androidsdkoffline.blogspot.com/p/android-sdk-build-tools.html
#
# Source
# https://dl.google.com/android/repository/91936d4ee3ccc839f0addd53c9ebf087b1e39251.build-tools_r30.0.3-windows.zip


### VERSION ###
DKSET(ANDROIDBUILDTOOLS_VERSION 30.0.3)
#DKSET(ANDROIDBUILDTOOLS_VERSION 32.0.0-rc1)
WIN_HOST_DKSET(ANDROIDBUILDTOOLS_DL https://dl.google.com/android/repository/91936d4ee3ccc839f0addd53c9ebf087b1e39251.build-tools_r${ANDROIDBUILDTOOLS_VERSION}-windows.zip)
MAC_HOST_DKSET(ANDROIDBUILDTOOLS_DL https://dl.google.com/android/repository/build-tools_r${ANDROIDBUILDTOOLS_VERSION}-darwin.zip)
LINUX_HOST_DKSET(ANDROIDBUILDTOOLS_DL https://dl.google.com/android/repository/cc6bd534c6c37604205171784ac5621.build-tools_r${ANDROIDBUILDTOOLS_VERSION}-linux.zip)
DKSET(ANDROIDBUILDTOOLS ${ANDROIDSDK}/build-tools/${ANDROIDBUILDTOOLS_VERSION})

### INSTALL ###
file(MAKE_DIRECTORY ${ANDROIDSDK}/build-tools)
DKINSTALL(${ANDROIDBUILDTOOLS_DL} android-build-tools ${ANDROIDBUILDTOOLS})
