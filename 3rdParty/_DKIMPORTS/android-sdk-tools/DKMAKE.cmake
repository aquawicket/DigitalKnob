# https://developer.android.com/studio/releases/sdk-tools
# https://androidsdkoffline.blogspot.com/p/android-sdk-tools.html

if(NOT ANDROID)
	dk_undepend(android-sdk-tools)
	dk_return()
endif()


dk_depend(android-sdk)

# 4333796
WIN_HOST_dk_import	(https://dl.google.com/android/repository/sdk-tools-windows-4333796.zip PATH ${ANDROID_SDK}/tools PATCH)
MAC_HOST_dk_import	(https://dl.google.com/android/repository/sdk-tools-darwin-4333796.zip PATH ${ANDROID_SDK}/tools PATCH)
LINUX_HOST_dk_import(https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip PATH ${ANDROID_SDK}/tools PATCH)


# TODO
#In tools/bin/sdkmanager.bat
#replace this ...
#%DEFAULT_JVM_OPTS%
#with this
#%DEFAULT_JVM_OPTS% --add-modules java.xml.bind %JAVA_OPTS%


#license signing
#if(EXISTS ${ANDROID_SDK_TOOLS}/installed)
#dk_depend(java)
#dk_command(${ANDROID_SDK_TOOLS}/bin/sdkmanager.bat --licenses)
#endif()
