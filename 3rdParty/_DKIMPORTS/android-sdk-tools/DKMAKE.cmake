# https://developer.android.com/studio/releases/sdk-tools
#
# https://dl.google.com/android/repository/sdk-tools-windows-4333796.zip
# https://dl.google.com/android/repository/sdk-tools-darwin-4333796.zip
# https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
if(NOT WIN_HOST)
	return()
endif()


### DEPENDS ###
#dk_depend(JDK)


#WIN_HOST_dk_install(https://dl.google.com/android/repository/sdk-tools-windows-4333796.zip ${ANDROID-SDK}/tools PATCH)
#MAC_HOST_dk_install(https://dl.google.com/android/repository/sdk-tools-darwin-4333796.zip ${ANDROID-SDK}/tools PATCH)
#LINUX_HOST_dk_install(https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip ${ANDROID-SDK}/tools PATCH)
WIN_HOST_dk_import	(https://dl.google.com/android/repository/sdk-tools-windows-4333796.zip ${ANDROID-SDK}/tools PATCH)
MAC_HOST_dk_import	(https://dl.google.com/android/repository/sdk-tools-darwin-4333796.zip ${ANDROID-SDK}/tools PATCH)
LINUX_HOST_dk_import(https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip ${ANDROID-SDK}/tools PATCH)



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