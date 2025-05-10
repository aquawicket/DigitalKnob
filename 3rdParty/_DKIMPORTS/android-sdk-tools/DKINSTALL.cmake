#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### android-sdk-tools ######
# https://developer.android.com/studio/releases/sdk-tools
# https://androidsdkoffline.blogspot.com/p/android-sdk-tools.html

dk_depend(android-sdk)
dk_validate(Host_Tuple "dk_Host_Tuple()")
dk_getFileParams("$ENV{DKIMPORTS_DIR}/android-sdk-tools/dkconfig.txt")
if(WIN_HOST)
	dk_import		(${ANDROID_SDK_TOOLS_WIN_DL} PATH ${ANDROID_SDK}/tools PATCH)
elseif(MAC_HOST)
	dk_import		(${ANDROID_SDK_TOOLS_MAC_DL} PATH ${ANDROID_SDK}/tools PATCH)
elseif(LINUX_HOST)
	dk_import		(${ANDROID_SDK_TOOLS_LINUX_DL} PATH ${ANDROID_SDK}/tools PATCH)
endif()

# TODO
#In tools/bin/sdkmanager.bat
#replace this ...
#%DEFAULT_JVM_OPTS%
#with this
#%DEFAULT_JVM_OPTS% --add-modules java.xml.bind %JAVA_OPTS%
