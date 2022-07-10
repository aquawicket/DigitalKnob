### android-sdk ###

dk_set(ANDROID-SDK ${3RDPARTY}/android-sdk)
dk_depend(openjdk)
dk_depend(openjdk-8u41)
dk_depend(android-cmdline-tools)


if(NOT EXISTS ${3RDPARTY}/android-sdk)
dk_set(ANDROID-SDK ${3RDPARTY}/android-sdk)
dk_makeDirectory(${ANDROID-SDK})
dk_patch(android-sdk ${ANDROID-SDK})
dk_setEnv("ANDROID_HOME" ${ANDROID-SDK})
dk_setEnv("VS_AndroidHome" ${ANDROID-SDK})


### SignLicenses ###
dk_killProcess(java.exe NOASSERT)
dk_killProcess(adb.exe NOASSERT)
dk_executeProcess(call "${OPENJDK-8U41}/registerJDK.cmd")
dk_executeProcess("${SDKMANAGER_BAT} --licenses")
dk_executeProcess(call "${OPENJDK}/registerJDK.cmd")
endif()