if(NOT ANDROID)
	return()
endif()


### VERSION ###
DKSET(ANDROIDTOOLS_VERSION win-7302050_latest)


### INSTALL ###
if(CMAKE_HOST_WIN32)
	## https://dl.google.com/android/repository/commandlinetools-win-7302050_latest.zip
	DKINSTALL(https://dl.google.com/android/repository/commandlinetools-${ANDROIDTOOLS_VERSION}.zip android-cmdline-tools ${ANDROIDTOOLS_NAME})
	DKSET(ANDROIDTOOLS ${3RDPARTY}/${ANDROIDTOOLS_NAME})
endif()

if(CMAKE_HOST_APPLE)
	## https://dl.google.com/android/repository/commandlinetools-win-7302050_latest.zip
	DKINSTALL(https://dl.google.com/android/repository/commandlinetools-${ANDROIDTOOLS_VERSION}.zip android-cmdline-tools ${ANDROIDTOOLS_NAME})
	DKSET(ANDROIDTOOLS ${3RDPARTY}/${ANDROIDTOOLS_NAME})
endif()

if(CMAKE_HOST_LINUX)
	## https://dl.google.com/android/repository/commandlinetools-win-7302050_latest.zip
	DKINSTALL(https://dl.google.com/android/repository/commandlinetools-${ANDROIDTOOLS_VERSION}.zip android-cmdline-tools ${ANDROIDTOOLS_NAME})
	DKSET(ANDROIDTOOLS ${3RDPARTY}/${ANDROIDTOOLS_NAME})
endif()
