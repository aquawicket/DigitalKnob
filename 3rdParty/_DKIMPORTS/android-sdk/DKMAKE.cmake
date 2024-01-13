### android-sdk ###
# https://androidsdkoffline.blogspot.com/

if(NOT ANDROID)
	dk_undepend(android-sdk)
	dk_return()
endif()


dk_set(ANDROID-SDK ${3RDPARTY}/android-sdk)
dk_depend(openjdk)
dk_depend(openjdk-8u41)
dk_depend(android-cmdline-tools)


if(NOT EXISTS ${ANDROID-SDK})
	dk_info("Installing android-sdk")
	dk_set(ANDROID-SDK ${3RDPARTY}/android-sdk)
	dk_makeDirectory(${ANDROID-SDK})
	dk_patch(android-sdk ${ANDROID-SDK})
	dk_setEnv("ANDROID_HOME" ${ANDROID-SDK})
	dk_setEnv("VS_AndroidHome" ${ANDROID-SDK})

	### SignLicenses ###
	dk_killProcess(java.exe NOASSERT)
	dk_killProcess(adb.exe NOASSERT)
	WIN_HOST_dk_executeProcess(call "${OPENJDK-8U41}/registerJDK.cmd")
	WIN_HOST_dk_executeProcess("${SDKMANAGER_BAT} --licenses")
	#WIN_HOST_dk_executeProcess(call "${OPENJDK}/registerJDK.cmd")
	WIN_HOST_dk_executeProcess(call ${ANDROID-SDK}/SignLicenses.cmd)
	WIN_HOST_dk_executeProcess(call "${OPENJDK-11}/registerJDK.cmd")
endif()

### SignLicenses ###
if(NOT EXISTS ${ANDROID-SDK}/SignLicenses.cmd)
	dk_copy(${DKIMPORTS}/android-sdk/SignLicenses.cmd ${ANDROID-SDK}/SignLicenses.cmd OVERWRITE)
	WIN_HOST_dk_executeProcess(call ${ANDROID-SDK}/SignLicenses.cmd)
endif()

if(NOT EXISTS ${ANDROID-SDK}/SignLicenses.sh)
	dk_copy(${DKIMPORTS}/android-sdk/SignLicenses.sh ${ANDROID-SDK}/SignLicenses.sh OVERWRITE)
	UNIX_HOST_dk_executeProcess(chmod 777 ${ANDROID-SDK}/SignLicenses.sh)
	UNIX_HOST_dk_executeProcess(${ANDROID-SDK}/SignLicenses.sh)
endif()

UNIX_HOST_dk_executeProcess(chmod 777 ${ANDROID-SDK}/SignLicenses.sh)
UNIX_HOST_dk_executeProcess(${ANDROID-SDK}/SignLicenses.sh)
