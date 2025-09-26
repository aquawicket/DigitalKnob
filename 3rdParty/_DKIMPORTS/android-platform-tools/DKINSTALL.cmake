#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


###### android-platform-tools ######
# https://androidsdkoffline.blogspot.com/p/android-sdk-platform-tools.html
# https://mirrors.cloud.tencent.com/AndroidSDK/
# https://github.com/lzhiyong/android-sdk-tools

dk_depend(android-sdk)


dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")

if(Windows_Host)
	dk_import(${android-platform-tools_Windows_Import}	INSTALL_PATH 	${android-sdk}/platform-tools)
elseif(Mac_Host)
	dk_import(${android-platform-tools_Mac_Import}		INSTALL_PATH 	${android-sdk}/platform-tools)
elseif(Android_Host)
	dk_import(${android-platform-tools_Android_Import}	INSTALL_PATH	${android-sdk}/termux)
	dk_copy(${android-sdk}/termux/build-tools 				${android-sdk}/build-tools/30.0.3 OVERWRITE)	# copy termux/build-tools to android-sdk
	dk_copy(${android-sdk}/termux/platform-tools 			${android-sdk}/platform-tools OVERWRITE)		# copy termux/platform-tools to android-sdk
	
	###### Fix for Android aapt2 (Termux) #######
	# https://github.com/Hax4us/flutter_in_termux/issues/1#issuecomment-1245508442
	# cd ~/.gradle
	# cd caches/modules-2/files-2.1/com.android.tools.build/aapt2/7.0.3-7396180/942684a205d274f6b23f6d066cafcc12a17ce9ff
	# unzip aapt2-7.0.3-7396180-linux.jar
	# rm aapt2
	# cp /data/data/com.termux/files/home/DigitalKnob/Development/3rdParty/android-sdk/build-tools/30.0.3/aapt2 .
	# rm aapt2-7.0.3-7396180-linux.jar
	# zip aapt2-7.0.3-7396180-linux.jar *     #Zip everything back
	# rm -rf META-INF NOTICE aapt2

	## Repackage Gradle's aapt2.jar with termux version of aapt2
	if(NOT GRADLE_USER_HOME)
		dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
		dk_set(GRADLE_USER_HOME $ENV{DKDOWNLOAD_DIR}/.gradle) #TODO: move this into _DKIMPORTS as its own dependency
	endif()
	dk_set(AAPT2 ${GRADLE_USER_HOME}/caches/modules-2/files-2.1/com.android.tools.build/aapt2/7.0.3-7396180/942684a205d274f6b23f6d066cafcc12a17ce9ff)
	if(EXISTS ${AAPT2}/aapt2-7.0.3-7396180-linux.jar)
		dk_info("Patching Gradle aapt2 .......")
		dk_exec(unzip -o aapt2-7.0.3-7396180-linux.jar WORKING_DIRECTORY ${AAPT2})
		dk_exec(rm aapt2 WORKING_DIRECTORY ${AAPT2})
		dk_exec(cp ${android-sdk}/build-tools/30.0.3/aapt2 . WORKING_DIRECTORY ${AAPT2})
		dk_exec(rm aapt2-7.0.3-7396180-linux.jar WORKING_DIRECTORY ${AAPT2})
		#dk_exec(zip -r aapt2-7.0.3-7396180-linux.jar * WORKING_DIRECTORY ${AAPT2})
		dk_exec(jar cvf aapt2-7.0.3-7396180-linux.jar . WORKING_DIRECTORY ${AAPT2})
		dk_exec(rm -rf META-INF NOTICE aapt2 WORKING_DIRECTORY ${AAPT2})
	endif()
elseif(Linux_Host)
	dk_import(${android-platform-tools_Linux_Impot} INSTALL_PATH ${android-sdk}/platform-tools)
endif()


if(Windows_Host)
	dk_set(adb_exe "${android-sdk}/platform-tools/adb.exe")
	dk_assertPath(adb_exe)
endif()

# 34.0.3
#if(NOT Android_Host)
#	dk_import(${android-platform-tools_Linux_Impot} INSTALL_PATH ${android-sdk}/platform-tools)
#else()
	#android-platform-tools_Android_Import(https://github.com/lzhiyong/android-sdk-tools/releases/download/34.0.3/android-sdk-tools-static-aarch64.zip INSTALL_PATH ${android-sdk}/termux)
	#dk_copy(${android-sdk}/termux/build-tools ${android-sdk}/build-tools/30.0.3)	# move termux/build-tools to android-sdk
	#dk_copy(${android-sdk}/termux/platform-tools ${android-sdk}/platform-tools)	# move termux/platform-tools to android-sdk
#endif()