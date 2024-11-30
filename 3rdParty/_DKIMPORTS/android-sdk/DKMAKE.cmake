#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


##### android-sdk ######
# https://androidsdkoffline.blogspot.com/

#NOTE: it's actually building android gui apps that depend on java. So we can push these further up the dependencies list. 
#dk_depend(openjdk)
#dk_depend(openjdk-8u41)
#dk_depend(android-cmdline-tools)

#dk_load(dk_builder)
dk_validate(host_triple "dk_host_triple()")

if(ANDROID_HOST)
	dk_set(ANDROID_SDK "$ENV{HOME}/digitalknob/3rdParty/android-sdk")
	dk_set(ANDROID_SDK_DIR "$ENV{HOME}/digitalknob/3rdParty/android-sdk")
else()
	dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
	dk_set(ANDROID_SDK "${DK3RDPARTY_DIR}/android-sdk")
	dk_set(ANDROID_SDK_DIR "${DK3RDPARTY_DIR}/android-sdk")
endif()
if(NOT EXISTS ${ANDROID_SDK_DIR})
	dk_info("Installing android-sdk")
	dk_makeDirectory("${ANDROID_SDK_DIR}")
	dk_patch(android-sdk "${ANDROID_SDK_DIR}")
endif()

# https://developer.android.com/tools/variables
###### ANDROID_HOME ######
if(NOT DEFINED ENV{ANDROID_HOME})
	set(ENV{ANDROID_HOME} "${ANDROID_SDK_DIR}")
	if(WIN_HOST)
		dk_replaceAll("$ENV{ANDROID_HOME}" "/" "\\" ENV{ANDROID_HOME})
		execute_process(COMMAND cmd /c setx ANDROID_HOME "$ENV{ANDROID_HOME}")
	endif()
	dk_printVar(ENV{ANDROID_HOME})
endif()	
	
###### ANDROID_USER_HOME ######
if(NOT DEFINED ENV{ANDROID_USER_HOME})
	set(ENV{ANDROID_USER_HOME} "${DKCACHE_DIR}/.android")
	if(WIN_HOST)
		dk_replaceAll("$ENV{ANDROID_USER_HOME}" "/" "\\" ENV{ANDROID_USER_HOME})
		execute_process(COMMAND cmd /c setx ANDROID_USER_HOME "$ENV{ANDROID_USER_HOME}")
	endif()
	dk_printVar(ENV{ANDROID_USER_HOME})
endif()
	
###### ANDROID_SDK_HOME ######
#if(NOT DEFINED ENV{ANDROID_SDK_HOME})
#	set(ENV{ANDROID_SDK_HOME} "${DKCACHE_DIR}")
#	if(WIN_HOST)
#		dk_replaceAll("$ENV{ANDROID_SDK_HOME}" "/" "\\" ENV{ANDROID_SDK_HOME})
#		execute_process(COMMAND cmd /c setx ANDROID_SDK_HOME "$ENV{ANDROID_SDK_HOME}")
#	endif()
#	dk_printVar(ENV{ANDROID_SDK_HOME})
#endif()

###### VS_AndroidHome ######
if(NOT DEFINED ENV{VS_AndroidHome})
	set(ENV{VS_AndroidHome} "${ANDROID_SDK_DIR}")
	if(WIN_HOST)
		dk_replaceAll("$ENV{VS_AndroidHome}" "/" "\\" ENV{VS_AndroidHome})
		execute_process(COMMAND cmd /c setx VS_AndroidHome "$ENV{VS_AndroidHome}")
	endif()
	dk_printVar(ENV{VS_AndroidHome})
endif()


###### SignLicenses ######
if(NOT EXISTS "${ANDROID_SDK_DIR}/licenses")
	# FIXME:  more work to be done on killing tasks
	#if(WIN_HOST)
	#	dk_killProcess(java.exe NO_HALT)
	#	dk_killProcess(adb.exe NO_HALT)
	#endif()
	
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
