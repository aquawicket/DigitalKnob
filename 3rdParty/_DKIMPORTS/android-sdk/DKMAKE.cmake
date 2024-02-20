### android-sdk ###
# https://androidsdkoffline.blogspot.com/

#if(NOT ANDROID)
#	dk_undepend(android-sdk)
#	dk_return()
#endif()


dk_set(ANDROID_SDK ${3RDPARTY}/android-sdk)

#NOTE: it's actually building android gui apps that depend
#	on java. So we can push these further up the dependencies list. 
#dk_depend(openjdk)
#dk_depend(openjdk-8u41)

dk_depend(android-cmdline-tools)


if(NOT EXISTS ${ANDROID_SDK})
	dk_info("Installing android-sdk")
	dk_set(ANDROID_SDK ${3RDPARTY}/android-sdk)
	dk_makeDirectory(${ANDROID_SDK})
	dk_patch(android-sdk ${ANDROID_SDK})
	dk_setEnv("ANDROID_HOME" ${ANDROID_SDK})
	dk_setEnv("VS_AndroidHome" ${ANDROID_SDK})

	### SignLicenses ###
	dk_killProcess(java.exe NOASSERT)
	dk_killProcess(adb.exe NOASSERT)
	WIN_HOST_dk_executeProcess(call "${OPENJDK_8U41}/registerJDK.cmd")
	WIN_HOST_dk_executeProcess("${SDKMANAGER_BAT} --licenses")
	#WIN_HOST_dk_executeProcess(call "${OPENJDK}/registerJDK.cmd")
	WIN_HOST_dk_executeProcess(call ${ANDROID_SDK}/SignLicenses.cmd)
	WIN_HOST_dk_executeProcess(call "${OPENJDK_11}/registerJDK.cmd")
endif()

### SignLicenses ###
if(NOT EXISTS ${ANDROID_SDK}/SignLicenses.cmd)
	dk_copy(${DKIMPORTS}/android-sdk/SignLicenses.cmd ${ANDROID_SDK}/SignLicenses.cmd OVERWRITE)
	execute_process(COMMAND ${CMAKE_COMMAND} -E sleep 2) # wait 2 seconds for the file to become available
	
	WIN_HOST_dk_executeProcess(call ${ANDROID_SDK}/SignLicenses.cmd)
endif()

if(NOT EXISTS ${ANDROID_SDK}/SignLicenses.sh)
	dk_copy(${DKIMPORTS}/android-sdk/SignLicenses.sh ${ANDROID_SDK}/SignLicenses.sh OVERWRITE)
	execute_process(COMMAND ${CMAKE_COMMAND} -E sleep 2) # wait 2 seconds for the file to become available
	
	UNIX_HOST_dk_executeProcess(chmod 777 ${ANDROID_SDK}/SignLicenses.sh)
	UNIX_HOST_dk_executeProcess(${ANDROID_SDK}/SignLicenses.sh)
endif()
