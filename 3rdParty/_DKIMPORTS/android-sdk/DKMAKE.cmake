#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
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
	
	###### ANDROID_HOME ######
	dk_getNativePath("${ANDROID_SDK_DIR}" ANDROID_HOME)
	dk_set(ANDROID_HOME ${ANDROID_HOME})
	set(ENV{ANDROID_HOME} ${ANDROID_HOME})
	execute_process(COMMAND cmd /c setx ANDROID_HOME "${ANDROID_HOME}")
	
	###### ANDROID_USER_HOME ######
	dk_getNativePath("${DKCACHE_DIR}/.android" ANDROID_USER_HOME)
	dk_set(ANDROID_USER_HOME ${ANDROID_USER_HOME})
	set(ENV{ANDROID_USER_HOME} ${ANDROID_USER_HOME})
	execute_process(COMMAND cmd /c setx ANDROID_USER_HOME "${ANDROID_USER_HOME}")
	
	###### ANDROID_SDK_HOME ######
	dk_getNativePath("${DIGITALKNOB_DIR}" ANDROID_SDK_HOME)
	dk_set(ANDROID_SDK_HOME ${ANDROID_SDK_HOME})
	set(ENV{ANDROID_SDK_HOME} ${ANDROID_SDK_HOME})
	execute_process(COMMAND cmd /c setx ANDROID_SDK_HOME "${ANDROID_SDK_HOME}")
	
	###### VS_AndroidHome ######
	dk_getNativePath("${ANDROID_SDK_DIR}" VS_AndroidHome)
	dk_set(VS_AndroidHome ${VS_AndroidHome})
	set(ENV{VS_AndroidHome} ${VS_AndroidHome})
	execute_process(COMMAND cmd /c setx VS_AndroidHome "${VS_AndroidHome}")
endif()


if(NOT EXISTS "${ANDROID_SDK_DIR}/licenses")
	# FIXME:  more work to be done on killing tasks
	#if(WIN_HOST)
	#	dk_killProcess(java.exe NO_HALT)
	#	dk_killProcess(adb.exe NO_HALT)
	#endif()
	
	### SignLicenses ###
	if(WIN_HOST)
		if(EXISTS "${DKIMPORTS_DIR}/openjdk_8u41/registerJDK.cmd")
			dk_executeProcess(call "${DKIMPORTS_DIR}/openjdk_8u41/registerJDK.cmd")
		endif()

		if(EXISTS "${SDKMANAGER_BAT}")
			dk_executeProcess("${SDKMANAGER_BAT} --licenses")
		endif()
		
		if(EXISTS "${DKIMPORTS_DIR}/android-sdk/SignLicenses.cmd")
			dk_executeProcess(call "${DKIMPORTS_DIR}/android-sdk/SignLicenses.cmd")
		endif()
		
		if(EXISTS "${DKIMPORTS_DIR}/openjdk/registerJDK.cmd")
			dk_executeProcess(call "${DKIMPORTS_DIR}/openjdk/registerJDK.cmd")
		endif()
	endif()
	
	if(UNIX_HOST)
		if(EXISTS "${DKIMPORTS_DIR}/android-sdk/SignLicenses.sh")
			dk_executeProcess(chmod 777 "${DKIMPORTS_DIR}/android-sdk/SignLicenses.sh")
			dk_executeProcess("${DKIMPORTS_DIR}/android-sdk/SignLicenses.sh")
		endif()
	endif()
endif()
