# android-sdk

dk_depend(openjdk-8u41)
dk_depend(android-cmdline-tools)

dk_set(ANDROID-SDK ${3RDPARTY}/android-sdk)
dk_patch(android-sdk ${ANDROID-SDK})

if(WIN_HOST)
	dk_setEnv("ANDROID_HOME" ${ANDROID-SDK})
	dk_setEnv("VS_AndroidHome" ${ANDROID-SDK})
	
	#### SignLicenses.cmd) ###
	dk_killProcess(java.exe NOASSERT)
	dk_killProcess(adb.exe NOASSERT)
	dk_executeProcess(call "${OPENJDK-8U41}/registerJDK.cmd")
	dk_executeProcess("${SDKMANAGER_BAT} --licenses")
	#::echo y | %SDKMANAGER% --licenses
	dk_executeProcess(call "${OPENJDK}/registerJDK.cmd")

endif()
