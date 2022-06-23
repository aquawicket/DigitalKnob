if(NOT WIN_HOST)
	return()
endif()

# https://developer.android.com/studio/releases/sdk-tools
#
# https://dl.google.com/android/repository/sdk-tools-windows-4333796.zip
# https://dl.google.com/android/repository/sdk-tools-darwin-4333796.zip
# https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip

### DEPENDS ###
#dk_depend(JDK)


#WIN_HOST_DKIMPORT	(ANDROID-SDK-TOOLS_DL https://dl.google.com/android/repository/sdk-tools-windows-4333796.zip)
#MAC_HOST_DKIMPORT	(ANDROID-SDK-TOOLS_DL https://dl.google.com/android/repository/sdk-tools-darwin-4333796.zip)
#LINUX_HOST_DKIMPORT	(ANDROID-SDK-TOOLS_DL https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip)


dk_set(ANDROID-SDK-TOOLS_VERSION 26.2.0) #revision
dk_set(ANDROID-SDK-TOOLS_BUILD 4333796)
WIN_HOST_dk_set(ANDROID-SDK-TOOLS_DL https://dl.google.com/android/repository/sdk-tools-windows-${ANDROID-SDK-TOOLS_BUILD}.zip)
MAC_HOST_dk_set(ANDROID-SDK-TOOLS_DL https://dl.google.com/android/repository/sdk-tools-darwin-${ANDROID-SDK-TOOLS_BUILD}.zip)
LINUX_HOST_dk_set(ANDROID-SDK-TOOLS_DL https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID-SDK-TOOLS_BUILD}.zip)
dk_set(ANDROID-SDK-TOOLS ${ANDROIDSDK}/tools)
dk_makeDirectory(${ANDROID-SDK-TOOLS})
dk_install(${ANDROID-SDK-TOOLS_DL} android-sdk-tools ${ANDROID-SDK-TOOLS} PATCH)


# TODO
#In tools/bin/sdkmanager.bat
#replace this ...
#%DEFAULT_JVM_OPTS%
#with this
#%DEFAULT_JVM_OPTS% --add-modules java.xml.bind %JAVA_OPTS%


#license signing
#if(EXISTS ${ANDROID-SDK-TOOLS}/installed)
#dk_depend(java)
#dk_command(${ANDROID-SDK-TOOLS}/bin/sdkmanager.bat --licenses)
#endif()