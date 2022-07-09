# android-sdk
dk_set(ANDROID-SDK ${3RDPARTY}/android-sdk)
dk_makeDirectory(${ANDROID-SDK})
dk_patch(android-sdk ${ANDROID-SDK})
dk_setEnv("ANDROID_HOME" ${ANDROID-SDK})
dk_setEnv("VS_AndroidHome" ${ANDROID-SDK})
	


#include(${DKIMPORTS}/android-build-tools/DKMAKE.cmake)
#include(${DKIMPORTS}/android-cmake/DKMAKE.cmake)



### SignLicenses ###
dk_depend(openjdk-8u41)
dk_depend(openjdk)
if(NOT HAVE_android-cmdline-tools)
	include(${DKIMPORTS}/android-cmdline-tools/DKMAKE.cmake)
endif()

dk_killProcess(java.exe NOASSERT)
dk_killProcess(adb.exe NOASSERT)
dk_executeProcess(call "${OPENJDK-8U41}/registerJDK.cmd")
dk_executeProcess("${SDKMANAGER_BAT} --licenses")
dk_executeProcess(call "${OPENJDK}/registerJDK.cmd")

