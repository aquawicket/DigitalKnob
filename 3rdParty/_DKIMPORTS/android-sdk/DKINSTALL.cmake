#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


##### android-sdk ######
# https://androidsdkoffline.blogspot.com/

#NOTE: it's actually building android gui apps that depend on java. So we can push these further up the dependencies list. 
#dk_depend(openjdk)
#dk_depend(openjdk-8)
#dk_depend(android-cmdline-tools)

dk_validate(host_triple "dk_host_triple()")
#if(ANDROID_HOST)
#	dk_set(ANDROID_SDK "$ENV{HOME}/digitalknob/3rdParty/android-sdk")
#	dk_set(ANDROID_SDK_DIR "$ENV{HOME}/digitalknob/3rdParty/android-sdk")
#else()
	dk_validate(ENV{DK3RDPARTY_DIR} "dk_DK3RDPARTY_DIR()")
	dk_set(ANDROID_SDK "$ENV{DK3RDPARTY_DIR}/android-sdk")
	dk_set(ANDROID_SDK_DIR "$ENV{DK3RDPARTY_DIR}/android-sdk")
#endif()

### INSTALL ###
if(NOT EXISTS ${ANDROID_SDK_DIR})
	dk_info("Installing android-sdk")
	dk_mkdir("${ANDROID_SDK_DIR}")
	dk_patch(android-sdk "${ANDROID_SDK_DIR}")
endif()

# https://developer.android.com/tools/variables
###### ANDROID_HOME ######
if(NOT DEFINED ENV{ANDROID_HOME})
	set(ENV{ANDROID_HOME} "${ANDROID_SDK_DIR}")
	if(WIN_HOST)
		dk_replaceAll("$ENV{ANDROID_HOME}" "/" "\\" ENV{ANDROID_HOME})
		dk_validate(CMD_EXE "dk_CMD_EXE()")
		#execute_process(COMMAND ${CMD_EXE} /c setx ANDROID_HOME "$ENV{ANDROID_HOME}")
	endif()
	dk_printVar(ENV{ANDROID_HOME})
endif()	
	
###### ANDROID_USER_HOME ######
if(NOT DEFINED ENV{ANDROID_USER_HOME})
	dk_validate(ENV{DKCACHE_DIR} "dk_DKCACHE_DIR()")
	set(ENV{ANDROID_USER_HOME} "$ENV{DKCACHE_DIR}/.android")
	if(WIN_HOST)
		dk_replaceAll("$ENV{ANDROID_USER_HOME}" "/" "\\" ENV{ANDROID_USER_HOME})
		dk_validate(CMD_EXE "dk_CMD_EXE()")
		#execute_process(COMMAND ${CMD_EXE} /c setx ANDROID_USER_HOME "$ENV{ANDROID_USER_HOME}")
	endif()
	dk_printVar(ENV{ANDROID_USER_HOME})
endif()
	
###### ANDROID_SDK_HOME ######
#if(NOT DEFINED ENV{ANDROID_SDK_HOME})
#	set(ENV{ANDROID_SDK_HOME} "$ENV{DKCACHE_DIR}")
#	if(WIN_HOST)
#		dk_replaceAll("$ENV{ANDROID_SDK_HOME}" "/" "\\" ENV{ANDROID_SDK_HOME})
#		dk_validate(CMD_EXE "dk_CMD_EXE()")
#		execute_process(COMMAND ${CMD_EXE} /c setx ANDROID_SDK_HOME "$ENV{ANDROID_SDK_HOME}")
#	endif()
#	dk_printVar(ENV{ANDROID_SDK_HOME})
#endif()

###### VS_AndroidHome ######
if(NOT DEFINED ENV{VS_AndroidHome})
	set(ENV{VS_AndroidHome} "${ANDROID_SDK_DIR}")
	if(WIN_HOST)
		dk_replaceAll("$ENV{VS_AndroidHome}" "/" "\\" ENV{VS_AndroidHome})
		dk_validate(CMD_EXE "dk_CMD_EXE()")
		#execute_process(COMMAND ${CMD_EXE} /c setx VS_AndroidHome "$ENV{VS_AndroidHome}")
	endif()
	dk_printVar(ENV{VS_AndroidHome})
endif()

### FIXME - temporarily disabled
###### SignLicenses ######
#if(NOT EXISTS "${ANDROID_SDK_DIR}/licenses")
if(0)
	# FIXME:  more work to be done on killing tasks
	#if(WIN_HOST)
	#	dk_killProcess(java.exe NO_HALT)
	#	dk_killProcess(adb.exe NO_HALT)
	#endif()
	
	if(WIN_HOST)
		if(EXISTS "$ENV{DKIMPORTS_DIR}/openjdk-8/registerJDK.cmd")
			dk_exec(call "$ENV{DKIMPORTS_DIR}/openjdk-8/registerJDK.cmd")
		endif()

		if(EXISTS "${SDKMANAGER_BAT}")
			dk_exec("${SDKMANAGER_BAT} --licenses")
		endif()
		
		if(EXISTS "$ENV{DKIMPORTS_DIR}/android-sdk/SignLicenses.cmd")
			dk_exec(call "$ENV{DKIMPORTS_DIR}/android-sdk/SignLicenses.cmd")
		endif()
		
		if(EXISTS "$ENV{DKIMPORTS_DIR}/openjdk/registerJDK.cmd")
			dk_exec(call "$ENV{DKIMPORTS_DIR}/openjdk/registerJDK.cmd")
		endif()
	endif()
	
	if(UNIX_HOST)
		if(EXISTS "$ENV{DKIMPORTS_DIR}/android-sdk/SignLicenses.sh")
			dk_exec(chmod 777 "$ENV{DKIMPORTS_DIR}/android-sdk/SignLicenses.sh")
			dk_exec("$ENV{DKIMPORTS_DIR}/android-sdk/SignLicenses.sh")
		endif()
	endif()
endif()
