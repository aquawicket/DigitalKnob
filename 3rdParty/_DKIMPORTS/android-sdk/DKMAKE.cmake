#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
### android-sdk ###
# https://androidsdkoffline.blogspot.com/

#if(NOT ANDROID)
#	dk_undepend(android-sdk)
#	dk_return()
#endif()

#NOTE: it's actually building android gui apps that depend on java. So we can push these further up the dependencies list. 
#dk_depend(openjdk)
#dk_depend(openjdk-8u41)
#dk_depend(android-cmdline-tools)

dk_validate(DK3RDPARTY_DIR "dk_DKBRANCH_DIR()")
dk_set(ANDROID_SDK "${DK3RDPARTY_DIR}/android-sdk")			#TODO: phase out
dk_set(ANDROID_SDK_DIR "${DK3RDPARTY_DIR}/android-sdk")
if(NOT EXISTS ${ANDROID_SDK_DIR})
	dk_info("Installing android-sdk")
	dk_makeDirectory("${ANDROID_SDK_DIR}")
	dk_patch(android-sdk "${ANDROID_SDK_DIR}")
	
	# https://developer.android.com/tools/variables#envar
	dk_setEnv("ANDROID_HOME" "${ANDROID_SDK_DIR}")
	execute_process(COMMAND cmd /c setx ANDROID_HOME "${ANDROID_SDK_DIR}")
	
	dk_setEnv("ANDROID_USER_HOME" "${DIGITALKNOB_DIR}/.android")
	execute_process(COMMAND cmd /c setx ANDROID_USER_HOME "${DIGITALKNOB_DIR}/.android")
	
	dk_setEnv("ANDROID_SDK_HOME" "${DIGITALKNOB_DIR}")
	execute_process(COMMAND cmd /c setx ANDROID_SDK_HOME "${DIGITALKNOB_DIR}")
	
	dk_setEnv("VS_AndroidHome" "${ANDROID_SDK_DIR}")
	execute_process(COMMAND cmd /c setx VS_AndroidHome "${ANDROID_SDK_DIR}")
endif()


if(NOT EXISTS "${ANDROID_SDK_DIR}/licenses")
	# FIXME:  more work to be done on killing tasks
	#if(WIN_HOST)
	#	dk_killProcess(java.exe NO_HALT)
	#	dk_killProcess(adb.exe NO_HALT)
	#endif()
	
	
	### SignLicenses ###
	if(EXISTS "${DKIMPORTS_DIR}/openjdk_8u41/registerJDK.cmd")
		WIN_HOST_dk_executeProcess(call "${DKIMPORTS_DIR}/openjdk_8u41/registerJDK.cmd")
	endif()
	
	
	
	if(EXISTS "${SDKMANAGER_BAT}")
		WIN_HOST_dk_executeProcess("${SDKMANAGER_BAT} --licenses")
	endif()
	WIN_HOST_dk_executeProcess(call "${DKIMPORTS_DIR}/android-sdk/SignLicenses.cmd")
	UNIX_HOST_dk_executeProcess(chmod 777 "${DKIMPORTS_DIR}/android-sdk/SignLicenses.sh")
	UNIX_HOST_dk_executeProcess("${DKIMPORTS_DIR}/android-sdk/SignLicenses.sh")
	
	
	
	if(EXISTS "${DKIMPORTS_DIR}/openjdk/registerJDK.cmd")
		WIN_HOST_dk_executeProcess(call "${DKIMPORTS_DIR}/openjdk/registerJDK.cmd")
	endif()
endif()
