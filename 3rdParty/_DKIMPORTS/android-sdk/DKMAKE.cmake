# android-sdk

dk_set(ANDROID-SDK ${3RDPARTY}/android-sdk)

if(WIN_HOST)
	dk_setEnv("ANDROID_HOME" ${ANDROID-SDK})
	dk_setEnv("VS_AndroidHome" ${ANDROID-SDK})

	if(NOT EXISTS ${ANDROID-SDK}/SignLicenses.cmd)
		dk_copy(${DKIMPORTS}/android-sdk/SignLicenses.cmd ${ANDROID-SDK}/SignLicenses.cmd OVERWRITE)
		dk_command(${ANDROID-SDK}/SignLicenses.cmd)
	endif()
endif()
