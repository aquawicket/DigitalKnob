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
	if(NOT EXISTS ${ANDROIDSDK}/build-tools/30.0.3)
		DKSET(QUEUE_BUILD ON)
		set(ARGUMNTS "${ANDROIDSDK}/bin/sdkmanager --install build-tools\\;30.0.3 --sdk_root=${ANDROIDSDK}")
		separate_arguments(ARGUMNTS)
		execute_process(COMMAND cmd /c ${ARGUMNTS} WORKING_DIRECTORY ${ANDROIDSDK}/bin)
	endif()
	if(NOT EXISTS ${ANDROIDSDK}/platforms/android-26)	
		DKSET(QUEUE_BUILD ON)
		set(ARGUMNTS "${ANDROIDSDK}/bin/sdkmanager --install platforms\\;android-31 --sdk_root=${ANDROIDSDK}")
		separate_arguments(ARGUMNTS)
		execute_process(COMMAND cmd /c ${ARGUMNTS} WORKING_DIRECTORY ${ANDROIDSDK}/bin)
	endif()
	if(NOT EXISTS ${ANDROIDSDK}/ndk/22.1.7171670)
		DKSET(QUEUE_BUILD ON)
		set(ARGUMNTS "${ANDROIDSDK}/bin/sdkmanager --install ndk\\;22.1.7171670 --sdk_root=${ANDROIDSDK}")
		separate_arguments(ARGUMNTS)
		execute_process(COMMAND cmd /c ${ARGUMNTS} WORKING_DIRECTORY ${ANDROIDSDK}/bin)
	endif()
	##if(NOT EXISTS ${ANDROIDSDK}/???)
		DKSET(QUEUE_BUILD ON)
		set(ARGUMNTS "${ANDROIDSDK}/bin/sdkmanager --install sources\\;android-30 --sdk_root=${ANDROIDSDK}")
		separate_arguments(ARGUMNTS)
		execute_process(COMMAND cmd /c ${ARGUMNTS} WORKING_DIRECTORY ${ANDROIDSDK}/bin)
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
