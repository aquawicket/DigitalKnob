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
	
	#sdkmanager --install build-tools;30.0.3 --sdk_root=C:\Users\aquawicket\digitalknob\DK\3rdParty\android-sdk
	#sdkmanager --install platforms;android-31 --sdk_root=C:\Users\aquawicket\digitalknob\DK\3rdParty\android-sdk
	#sdkmanager --install ndk;22.1.7171670 --sdk_root=C:\Users\aquawicket\digitalknob\DK\3rdParty\android-sdk
	#sdkmanager --install sources;android-30 --sdk_root=C:\Users\aquawicket\digitalknob\DK\3rdParty\android-sdk
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
