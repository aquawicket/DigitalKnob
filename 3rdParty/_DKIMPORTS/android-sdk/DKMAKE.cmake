### android-sdk ###
# https://androidsdkoffline.blogspot.com/

#if(NOT ANDROID)
#	dk_undepend(android-sdk)
#	dk_return()
#endif()


dk_set(ANDROID_SDK ${DK3RDPARTY_DIR}/android-sdk)

#NOTE: it's actually building android gui apps that depend
#	on java. So we can push these further up the dependencies list. 
#dk_depend(openjdk)
#dk_depend(openjdk-8u41)
#dk_depend(android-cmdline-tools)


if(NOT EXISTS ${ANDROID_SDK})
	dk_info("Installing android-sdk")
	dk_set(ANDROID_SDK ${DK3RDPARTY_DIR}/android-sdk)
	dk_makeDirectory(${ANDROID_SDK})
	dk_patch(android-sdk ${ANDROID_SDK})
	
	# https://developer.android.com/tools/variables#envar
	dk_setEnv("ANDROID_HOME" ${ANDROID_SDK})
	dk_setEnv("ANDROID_USER_HOME" ${DIGITALKNOB_DIR}/.android)
	dk_setEnv("ANDROID_SDK_HOME" ${DIGITALKNOB_DIR}/.android)
	dk_setEnv("VS_AndroidHome" ${ANDROID_SDK})

	# FIXME:  more work to be done on killing tasks
	#if(WIN_HOST)
	#	dk_killProcess(java.exe NOASSERT)
	#	dk_killProcess(adb.exe NOASSERT)
	#endif()
	
	### SignLicenses ###
	if(OPENJDK_8U41)
		WIN_HOST_dk_executeProcess(call "${OPENJDK_8U41}/registerJDK.cmd")
	endif()
	if(SDKMANAGER_BAT)
		WIN_HOST_dk_executeProcess("${SDKMANAGER_BAT} --licenses")
	endif()
	#WIN_HOST_dk_executeProcess(call "${OPENJDK}/registerJDK.cmd")
	
	dk_sleep(2) # wait 2 seconds for the file to become available
	WIN_HOST_dk_executeProcess(call ${ANDROID_SDK}/SignLicenses.cmd)
	if(OPENJDK_11)
		WIN_HOST_dk_executeProcess(call "${OPENJDK_11}/registerJDK.cmd")
	endif()
endif()

### SignLicenses ###
if(NOT EXISTS ${ANDROID_SDK}/licenses OR NOT EXISTS ${ANDROID_SDK}/SignLicenses.cmd)
	dk_copy(${DKIMPORTS_DIR}/android-sdk/SignLicenses.cmd ${ANDROID_SDK}/SignLicenses.cmd OVERWRITE)
	dk_sleep(2) # wait 2 seconds for the file to become available
	
	WIN_HOST_dk_executeProcess(call ${ANDROID_SDK}/SignLicenses.cmd)
endif()

if(NOT EXISTS ${ANDROID_SDK}/licenses OR NOT EXISTS ${ANDROID_SDK}/SignLicenses.sh)
	dk_copy(${DKIMPORTS_DIR}/android-sdk/SignLicenses.sh ${ANDROID_SDK}/SignLicenses.sh OVERWRITE)
	dk_sleep(2) # wait 2 seconds for the file to become available
	
	UNIX_HOST_dk_executeProcess(chmod 777 ${ANDROID_SDK}/SignLicenses.sh)
	UNIX_HOST_dk_executeProcess(${ANDROID_SDK}/SignLicenses.sh)
endif()
