if(NOT ANDROID)
	return()
endif()


### VERSION ###
DKSET(ANDROIDSDK_VERSION win-7302050_latest)
DKSET(ANDROIDSDK_NAME android-sdk)


### INSTALL ###
if(CMAKE_HOST_WIN32)
	## https://dl.google.com/android/repository/commandlinetools-win-7302050_latest.zip
	DKINSTALL(https://dl.google.com/android/repository/commandlinetools-${ANDROIDSDK_VERSION}.zip android-sdk ${ANDROIDSDK_NAME})
	DKSET(ANDROIDSDK ${3RDPARTY}/${ANDROIDSDK_NAME})
	
	ANDROID_PATH(${ANDROIDSDK}/bin)
	DKSET(ANDROID_BUILDTOOLS "build-tools\\;30.0.3")
	if(NOT EXISTS ${ANDROIDSDK}/build-tools/30.0.3)
		DKSET(QUEUE_BUILD ON)
		ANDROID_COMMAND("${ANDROIDSDK}/bin/sdkmanager ${ANDROID_BUILDTOOLS} --sdk_root=${ANDROIDSDK}")
	endif()
	if(NOT EXISTS ${ANDROIDSDK}/platforms/android-26)	
		DKSET(QUEUE_BUILD ON)
		ANDROID_COMMAND("${ANDROIDSDK}/bin/sdkmanager --install platforms;android-26 --sdk_root=${ANDROIDSDK}")
	endif()
	if(NOT EXISTS ${ANDROIDSDK}/ndk/22.1.7171670)
		DKSET(QUEUE_BUILD ON)
		ANDROID_COMMAND("${ANDROIDSDK}/bin/sdkmanager --install ndk;22.1.7171670 --sdk_root=${ANDROIDSDK}")
	endif()
	##if(NOT EXISTS ${ANDROIDSDK}/???)
		#DKSET(QUEUE_BUILD ON)
		#ANDROID_COMMAND("${ANDROIDSDK}/bin/sdkmanager --install sources;android-30 --sdk_root=${ANDROIDSDK}")
	##endif()
endif()

if(CMAKE_HOST_APPLE)
	## https://dl.google.com/android/repository/commandlinetools-win-7302050_latest.zip
	DKINSTALL(https://dl.google.com/android/repository/commandlinetools-${ANDROIDSDK_VERSION}.zip android-sdk ${ANDROIDSDK_NAME})
	DKSET(ANDROIDSDK ${3RDPARTY}/${ANDROIDSDK_NAME})
endif()

if(CMAKE_HOST_LINUX)
	## https://dl.google.com/android/repository/commandlinetools-win-7302050_latest.zip
	DKINSTALL(https://dl.google.com/android/repository/commandlinetools-${ANDROIDSDK_VERSION}.zip android-sdk ${ANDROIDSDK_NAME})
	DKSET(ANDROIDSDK ${3RDPARTY}/${ANDROIDSDK_NAME})
endif()
