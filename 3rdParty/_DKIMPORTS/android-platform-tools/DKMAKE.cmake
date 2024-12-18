#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### android-platform-tools ######
# https://androidsdkoffline.blogspot.com/p/android-sdk-platform-tools.html
# https://mirrors.cloud.tencent.com/AndroidSDK/
# https://github.com/lzhiyong/android-sdk-tools

dk_depend(android-sdk)

# 31.0.3
#WIN_HOST_dk_import(https://dl.google.com/android/repository/platform-tools_r31.0.3-windows.zip PATH ${ANDROID_SDK}/platform-tools)
#MAC_HOST_dk_import(https://dl.google.com/android/repository/platform-tools_r31.0.3-darwin.zip PATH ${ANDROID_SDK}/platform-tools)
#LINUX_HOST_dk_import(https://dl.google.com/android/repository/platform-tools_r31.0.3-linux.zip PATH ${ANDROID_SDK}/platform-tools)

# 33.0.2
#WIN_HOST_dk_import(https://dl.google.com/android/repository/platform-tools_r33.0.2-windows.zip PATH ${ANDROID_SDK}/platform-tools)
#MAC_HOST_dk_import(https://dl.google.com/android/repository/platform-tools_r33.0.2-darwin.zip PATH ${ANDROID_SDK}/platform-tools)
#LINUX_HOST_dk_import(https://dl.google.com/android/repository/platform-tools_r33.0.2-linux.zip PATH ${ANDROID_SDK}/platform-tools)

# 33.0.3
if(WIN_HOST)
	dk_getFileParam(${DKIMPORTS_DIR}/android-platform-tools/dkconfig.txt ANDROID_PLATFORM_TOOLS_WIN_DL)
	dk_import(${ANDROID_PLATFORM_TOOLS_WIN_DL} PATH ${ANDROID_SDK}/platform-tools)
elseif(MAC_HOST)
	dk_getFileParam(${DKIMPORTS_DIR}/android-platform-tools/dkconfig.txt ANDROID_PLATFORM_TOOLS_MAC_DL)
	dk_import(${ANDROID_PLATFORM_TOOLS_MAC_DL} PATH ${ANDROID_SDK}/platform-tools)
elseif(ANDROID_HOST)
	dk_getFileParam(${DKIMPORTS_DIR}/android-platform-tools/dkconfig.txt ANDROID_PLATFORM_TOOLS_ANDROID_DL)
	dk_import(${ANDROID_PLATFORM_TOOLS_ANDROID_DL} PATH ${ANDROID_SDK}/termux)
	dk_copy(${ANDROID_SDK}/termux/build-tools ${ANDROID_SDK}/build-tools/30.0.3 OVERWRITE)		# copy termux/build-tools to android-sdk
	dk_copy(${ANDROID_SDK}/termux/platform-tools ${ANDROID_SDK}/platform-tools OVERWRITE)		# copy termux/platform-tools to android-sdk
	
	###### Fix for Android aapt2 (Termux) #######
	# https://github.com/Hax4us/flutter_in_termux/issues/1#issuecomment-1245508442
	# cd ~/.gradle
	# cd caches/modules-2/files-2.1/com.android.tools.build/aapt2/7.0.3-7396180/942684a205d274f6b23f6d066cafcc12a17ce9ff
	# unzip aapt2-7.0.3-7396180-linux.jar
	# rm aapt2
	# cp /data/data/com.termux/files/home/digitalknob/Development/3rdParty/android-sdk/build-tools/30.0.3/aapt2 .
	# rm aapt2-7.0.3-7396180-linux.jar
	# zip aapt2-7.0.3-7396180-linux.jar *     #Zip everything back
	# rm -rf META-INF NOTICE aapt2

	## Repackage Gradle's aapt2.jar with termux version of aapt2
	dk_set(GRADLE_USER_HOME ${DIGITALKNOB_DIR}/.gradle) #TODO: move this into _DKIMPORTS as its own dependency
	dk_set(AAPT2 ${GRADLE_USER_HOME}/caches/modules-2/files-2.1/com.android.tools.build/aapt2/7.0.3-7396180/942684a205d274f6b23f6d066cafcc12a17ce9ff)
	if(EXISTS ${AAPT2}/aapt2-7.0.3-7396180-linux.jar)
		dk_info("Patching Gradle aapt2 .......")
		dk_executeProcess(unzip -o aapt2-7.0.3-7396180-linux.jar WORKING_DIRECTORY ${AAPT2})
		dk_executeProcess(rm aapt2 WORKING_DIRECTORY ${AAPT2})
		dk_executeProcess(cp ${ANDROID_SDK}/build-tools/30.0.3/aapt2 . WORKING_DIRECTORY ${AAPT2})
		dk_executeProcess(rm aapt2-7.0.3-7396180-linux.jar WORKING_DIRECTORY ${AAPT2})
		#dk_executeProcess(zip -r aapt2-7.0.3-7396180-linux.jar * WORKING_DIRECTORY ${AAPT2})
		dk_executeProcess(jar cvf aapt2-7.0.3-7396180-linux.jar . WORKING_DIRECTORY ${AAPT2})
		dk_executeProcess(rm -rf META-INF NOTICE aapt2 WORKING_DIRECTORY ${AAPT2})
	endif()
elseif(LINUX_HOST)
	dk_getFileParam(${DKIMPORTS_DIR}/android-platform-tools/dkconfig.txt ANDROID_PLATFORM_TOOLS_LINUX_DL)
	dk_import(${ANDROID_PLATFORM_TOOLS_LINUX_DL} PATH ${ANDROID_SDK}/platform-tools)
endif()

# 34.0.3
#WIN_HOST_dk_import(https://dl.google.com/android/repository/platform-tools_r34.0.3-windows.zip PATH ${ANDROID_SDK}/platform-tools)
#MAC_HOST_dk_import(https://mirrors.cloud.tencent.com/AndroidSDK/platform-tools_r34.0.3-darwin.zip PATH ${ANDROID_SDK}/platform-tools)
#if(NOT ANDROID_HOST)
#	LINUX_HOST_dk_import(https://dl.google.com/android/repository/platform-tools_r34.0.3-linux.zip PATH ${ANDROID_SDK}/platform-tools)
#else()
	#ANDROID_HOST_dk_import(https://github.com/lzhiyong/android-sdk-tools/releases/download/34.0.3/android-sdk-tools-static-aarch64.zip PATH ${ANDROID_SDK}/termux)
	#dk_copy(${ANDROID_SDK}/termux/build-tools ${ANDROID_SDK}/build-tools/30.0.3)	# move termux/build-tools to android-sdk
	#dk_copy(${ANDROID_SDK}/termux/platform-tools ${ANDROID_SDK}/platform-tools)	# move termux/platform-tools to android-sdk
#endif()

