#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


##### android-sdk ######
#NOTE: it's actually building android gui apps that depend on java. So we can push these further up the dependencies list. 
#dk_validate(openjdk "dk_depend(openjdk)")
#dk_validate(openjdk-8 "dk_depend(openjdk-8)")
#dk_validate(android-cmdline-tools "dk_depend(android-cmdline-tools)")

dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
dk_set(android-sdk "${DK3RDPARTY_DIR}/android-sdk")

dk_set(android-sdk_Import_Name "android-sdk")
dk_set(android-sdk_Install_Path "${android-sdk}")

### INSTALL ###
if(NOT EXISTS ${android-sdk})
	dk_info("Installing android-sdk")
	dk_mkdir("${android-sdk}")
	dk_patch(android-sdk "${android-sdk}")
endif()

# https://developer.android.com/tools/variables
###### ANDROID_SDK ######
if(NOT DEFINED ENV{ANDROID_SDK})
	#set(ENV{ANDROID_SDK} "${android-sdk}")
	dk_set(ANDROID_SDK "${android-sdk}")
	if(Windows_Host)
		dk_replaceAll("$ENV{ANDROID_SDK}" "/" "\\" ENV{ANDROID_SDK})
		#dk_validate(cmd.exe "dk_depend(cmd.exe)")
		#dk_exec(${cmd.exe} /c setx ANDROID_SDK "$ENV{ANDROID_SDK}")
	endif()
	dk_debug("ANDROID_SDK = ${ANDROID_SDK}")
endif()

###### ANDROID_HOME ######
if(NOT DEFINED ENV{ANDROID_HOME})
	#set(ENV{ANDROID_HOME} "${android-sdk}")
	dk_set(ANDROID_HOME "${android-sdk}")
	if(Windows_Host)
		dk_replaceAll("$ENV{ANDROID_HOME}" "/" "\\" ENV{ANDROID_HOME})
		#dk_validate(cmd.exe "dk_depend(cmd.exe)")
		#dk_exec(${cmd.exe} /c setx ANDROID_HOME "$ENV{ANDROID_HOME}")
	endif()
	dk_debug("ANDROID_HOME = ${ANDROID_HOME}")
endif()	
	
###### ANDROID_USER_HOME ######
if(NOT DEFINED ENV{ANDROID_USER_HOME})
	dk_validate(DKCACHE_DIR "dk_DKCACHE_DIR()")
	#set(ENV{ANDROID_USER_HOME} "${DKCACHE_DIR}/.android")
	dk_set(ANDROID_USER_HOME "${DKCACHE_DIR}/.android")
	if(Windows_Host)
		dk_replaceAll("$ENV{ANDROID_USER_HOME}" "/" "\\" ENV{ANDROID_USER_HOME})
		#dk_validate(cmd.exe "dk_depend(cmd.exe)")
		#dk_exec(${cmd.exe} /c setx ANDROID_USER_HOME "$ENV{ANDROID_USER_HOME}")
	endif()
	dk_debug("ANDROID_USER_HOME = ${ANDROID_USER_HOME}")
endif()
	
###### VS_AndroidHome ######
if(NOT DEFINED ENV{VS_AndroidHome})
	#set(ENV{VS_AndroidHome} "${android-sdk}")
	dk_set(VS_AndroidHome "${android-sdk}")
	if(Windows_Host)
		dk_replaceAll("$ENV{VS_AndroidHome}" "/" "\\" ENV{VS_AndroidHome})
		#dk_validate(cmd.exe "dk_depend(cmd.exe)")
		#dk_exec(${cmd.exe} /c setx VS_AndroidHome "$ENV{VS_AndroidHome}")
	endif()
	dk_debug("VS_AndroidHome = ${VS_AndroidHome}")
endif()

###### ANDROID_SDK_HOME ######
#if(NOT DEFINED ENV{ANDROID_SDK_HOME})
#	#set(ENV{ANDROID_SDK_HOME} "${DKCACHE_DIR}")
#	dk_set(ANDROID_SDK_HOME "${DKCACHE_DIR}")
#	if(Windows_Host)
#		dk_replaceAll("$ENV{ANDROID_SDK_HOME}" "/" "\\" ENV{ANDROID_SDK_HOME})
#		#dk_validate(cmd.exe "dk_depend(cmd.exe)")
#		#execute_process(COMMAND ${cmd.exe} /c setx ANDROID_SDK_HOME "$ENV{ANDROID_SDK_HOME}")
#	endif()
#	dk_debug("ANDROID_SDK_HOME = ${ANDROID_SDK_HOME}")
#endif()







### FIXME - temporarily disabled
###### SignLicenses ######
#if(NOT EXISTS "${android-sdk}/licenses")
if(0)
	# FIXME:  more work to be done on killing tasks
	#if(Windows_Host)
	#	dk_killProcess(java.exe NO_HALT)
	#	dk_killProcess(adb.exe NO_HALT)
	#endif()
	
	if(Windows_Host)
		if(EXISTS "${DKIMPORTS_DIR}/openjdk-8/registerJDK.cmd")
			dk_exec(call "${DKIMPORTS_DIR}/openjdk-8/registerJDK.cmd")
		endif()

		if(EXISTS "${SDKMANAGER_BAT}")
			dk_exec("${SDKMANAGER_BAT} --licenses")
		endif()
		
		if(EXISTS "${DKIMPORTS_DIR}/android-sdk/SignLicenses.cmd")
			dk_exec(call "${DKIMPORTS_DIR}/android-sdk/SignLicenses.cmd")
		endif()
		
		if(EXISTS "${DKIMPORTS_DIR}/openjdk/registerJDK.cmd")
			dk_exec(call "${DKIMPORTS_DIR}/openjdk/registerJDK.cmd")
		endif()
	endif()
	
	if(UNIX_HOST)
		if(EXISTS "${DKIMPORTS_DIR}/android-sdk/SignLicenses.sh")
			dk_exec(chmod 777 "${DKIMPORTS_DIR}/android-sdk/SignLicenses.sh")
			dk_exec("${DKIMPORTS_DIR}/android-sdk/SignLicenses.sh")
		endif()
	endif()
endif()
