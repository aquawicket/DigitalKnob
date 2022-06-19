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


#WIN_HOST_DKIMPORT	(ANDROIDSDKTOOLS_DL https://dl.google.com/android/repository/sdk-tools-windows-4333796.zip)
#MAC_HOST_DKIMPORT	(ANDROIDSDKTOOLS_DL https://dl.google.com/android/repository/sdk-tools-darwin-4333796.zip)
#LINUX_HOST_DKIMPORT	(ANDROIDSDKTOOLS_DL https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip)


dk_set(ANDROIDSDKTOOLS_VERSION 26.2.0) #revision
dk_set(ANDROIDSDKTOOLS_BUILD 4333796)
WIN_HOST_dk_set(ANDROIDSDKTOOLS_DL https://dl.google.com/android/repository/sdk-tools-windows-${ANDROIDSDKTOOLS_BUILD}.zip)
MAC_HOST_dk_set(ANDROIDSDKTOOLS_DL https://dl.google.com/android/repository/sdk-tools-darwin-${ANDROIDSDKTOOLS_BUILD}.zip)
LINUX_HOST_dk_set(ANDROIDSDKTOOLS_DL https://dl.google.com/android/repository/sdk-tools-linux-${ANDROIDSDKTOOLS_BUILD}.zip)
dk_set(ANDROIDSDKTOOLS ${ANDROIDSDK}/tools)
dk_makeDirectory(${ANDROIDSDKTOOLS})
dk_install(${ANDROIDSDKTOOLS_DL} android-sdk-tools ${ANDROIDSDKTOOLS} PATCH)


# TODO
#In tools/bin/sdkmanager.bat
#replace this ...
#%DEFAULT_JVM_OPTS%
#with this
#%DEFAULT_JVM_OPTS% --add-modules java.xml.bind %JAVA_OPTS%


#license signing
#if(EXISTS ${ANDROIDSDKTOOLS}/installed)
#dk_depend(java)
#dk_command(${ANDROIDSDKTOOLS}/bin/sdkmanager.bat --licenses)
#endif()