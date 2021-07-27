if(NOT ANDROID)
	return()
endif()

DKDEPEND(jdk)

### VERSION ###
DKSET(ANDROIDTOOLS_VERSION win-7302050_latest)
DKSET(ANDROIDSDK_NAME android-sdk)
DKSET(ANDROIDSDK ${3RDPARTY}/${ANDROIDSDK_NAME})
DKSET(ANDROIDBUILDTOOLS_VERSION 30.0.3)
DKSET(ANDROIDPLATFORM_VERSION android-26)
DKSET(ANDROIDSOURCES_VERSION android-30)
DKSET(ANDROIDNDK_VERSION r22b)
DKSET(ANDROIDNDK_BUILD 22.1.7171670)
DKSET(ANDROIDNDK ${ANDROIDSDK}/ndk/${ANDROIDNDK_BUILD})

#for backwards compatability, phase these out
DKSET(NDK_VERSION ${ANDROIDNDK_VERSION})
DKSET(NDK_BUILD ${ANDROIDNDK_BUILD})
DKSET(NDK ${ANDROIDSDK}/ndk/${ANDROIDNDK_BUILD})



### INSTALL ###
if(CMAKE_HOST_WIN32)
	## https://dl.google.com/android/repository/commandlinetools-win-7302050_latest.zip
	DKINSTALL(https://dl.google.com/android/repository/commandlinetools-${ANDROIDTOOLS_VERSION}.zip android-sdk ${ANDROIDSDK_NAME})
	ANDROID_PATH(${ANDROIDSDK}/bin)
	if(NOT EXISTS ${ANDROIDSDK}/build-tools/${ANDROIDBUILDTOOLS_VERSION})
		message("Installing Android build-tools: ${ANDROIDBUILDTOOLS_VERSION} . . .")
		DKSET(QUEUE_BUILD ON)
		set(ARGUMNTS "${ANDROIDSDK}/bin/sdkmanager --install build-tools\\;${ANDROIDBUILDTOOLS_VERSION} --sdk_root=${ANDROIDSDK}")
		separate_arguments(ARGUMNTS)
		execute_process(COMMAND cmd /c ${ARGUMNTS} WORKING_DIRECTORY ${ANDROIDSDK}/bin)
		WaitForEnter()
	endif()
	if(NOT EXISTS ${ANDROIDSDK}/platforms/${ANDROIDPLATFORM_VERSION})
		message("Installing Android platform: ${ANDROIDPLATFORM_VERSION} . . .")
		DKSET(QUEUE_BUILD ON)
		set(ARGUMNTS "${ANDROIDSDK}/bin/sdkmanager --install platforms\\;${ANDROIDPLATFORM_VERSION} --sdk_root=${ANDROIDSDK}")
		separate_arguments(ARGUMNTS)
		execute_process(COMMAND cmd /c ${ARGUMNTS} WORKING_DIRECTORY ${ANDROIDSDK}/bin)
		WaitForEnter()
	endif()
	if(NOT EXISTS ${ANDROIDSDK}/ndk/${ANDROIDNDK_BUILD})
		message("Installing Android NDK: ${ANDROIDNDK_BUILD} . . .")
		DKSET(QUEUE_BUILD ON)
		set(ARGUMNTS "${ANDROIDSDK}/bin/sdkmanager --install ndk\\;${ANDROIDNDK_BUILD} --sdk_root=${ANDROIDSDK}")
		separate_arguments(ARGUMNTS)
		execute_process(COMMAND cmd /c ${ARGUMNTS} WORKING_DIRECTORY ${ANDROIDSDK}/bin)
		#WaitForEnter()
	endif()
	#if(NOT EXISTS ${ANDROIDSDK}/Sources/${ANDROIDSOURCES_VERSION})
	#	message("Installing Android API Sources: ${ANDROIDSOURCES_VERSION}")
	#	DKSET(QUEUE_BUILD ON)
	#	set(ARGUMNTS "${ANDROIDSDK}/bin/sdkmanager --install sources\\;${ANDROIDSOURCES_VERSION} --sdk_root=${ANDROIDSDK}")
	#	separate_arguments(ARGUMNTS)
	#	execute_process(COMMAND cmd /c ${ARGUMNTS} WORKING_DIRECTORY ${ANDROIDSDK}/bin)
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
