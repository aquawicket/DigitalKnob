#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### android-sdk-tools ######
# https://developer.android.com/studio/releases/sdk-tools
# https://androidsdkoffline.blogspot.com/p/android-sdk-tools.html

dk_depend(android-sdk)
dk_validate(host_triple "dk_host_triple()")
if(WIN_HOST)
	dk_getFileParam	(${DKIMPORTS_DIR}/android-sdk-tools/dkconfig.txt ANDROID_SDK_TOOLS_WIN_DL)
	dk_import		(${ANDROID_SDK_TOOLS_WIN_DL} PATH ${ANDROID_SDK}/tools PATCH)
elseif(MAC_HOST)
	dk_getFileParam	(${DKIMPORTS_DIR}/android-sdk-tools/dkconfig.txt ANDROID_SDK_TOOLS_MAC_DL)
	dk_import		(${ANDROID_SDK_TOOLS_MAC_DL} PATH ${ANDROID_SDK}/tools PATCH)
elseif(LINUX_HOST)
	dk_getFileParam	(${DKIMPORTS_DIR}/android-sdk-tools/dkconfig.txt ANDROID_SDK_TOOLS_LINUX_DL)
	dk_import		(${ANDROID_SDK_TOOLS_LINUX_DL} PATH ${ANDROID_SDK}/tools PATCH)
endif()

# TODO
#In tools/bin/sdkmanager.bat
#replace this ...
#%DEFAULT_JVM_OPTS%
#with this
#%DEFAULT_JVM_OPTS% --add-modules java.xml.bind %JAVA_OPTS%
