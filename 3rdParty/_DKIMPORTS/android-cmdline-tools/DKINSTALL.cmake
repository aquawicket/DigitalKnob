#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ android-cmdline-tools ############
# Information
# https://androidsdkmanager.azurewebsites.net/
# https://developer.android.com/studio/releases/cmdline-tools
# https://developer.android.com/studio?hl=fr#command-tools
# https://androidsdkoffline.blogspot.com/p/android-sdk-cmdline-tools-offline.html

#if(NOT ANDROID)
#	dk_undepend(android-cmdline-tools)
#	dk_return()
#endif()

#dk_depend(openjdk-8)

dk_validate(ENV{DK3RDPARTY_DIR} "dk_DK3RDPARTY_DIR()")
dk_set(ANDROID_SDK $ENV{DK3RDPARTY_DIR}/android-sdk)
dk_mkdir(${ANDROID_SDK})
dk_mkdir(${ANDROID_SDK}/cmdline-tools)

# 7583922
if(WIN_HOST)
	dk_import(https://dl.google.com/android/repository/commandlinetools-win-7583922_latest.zip PATH ${ANDROID_SDK}/cmdline-tools/latest)
elseif(MAC_HOST)
	dk_import(https://dl.google.com/android/repository/commandlinetools-mac-7583922_latest.zip PATH ${ANDROID_SDK}/cmdline-tools/latest)
elseif(LINUX_HOST)
	dk_import(https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip PATH ${ANDROID_SDK}/cmdline-tools/latest)
endif()

# 8512546
#WIN_HOST_dk_import(https://dl.google.com/android/repository/commandlinetools-win-8512546_latest.zip PATH ${ANDROID_SDK}/cmdline-tools/latest)
#MAC_HOST_dk_import(https://dl.google.com/android/repository/commandlinetools-mac-8512546_latest.zip PATH ${ANDROID_SDK}/cmdline-tools/latest)
#LINUX_HOST_dk_import(https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip PATH ${ANDROID_SDK}/cmdline-tools/latest)


dk_set(SDKMANAGER_BAT ${ANDROID_CMDLINE_TOOLS}/bin/sdkmanager.bat)







## FIXME
dk_return()


if(WIN_HOST)
	dk_exec(sdkmanager --sdk_root=${ANDROID_SDK} WORKING_DIRECTORY ${ANDROID_CMDLINE_TOOLS}/bin)
	if(NOT EXISTS ${ANDROID_SDK}/build-tools/${ANDROID_BUILD_TOOLS_VERSION})
		dk_info("Installing Android build-tools: ${ANDROID_BUILD_TOOLS_VERSION} . . .")
		set(ARGUMNTS "${SDKMANAGER_BAT} --install build-tools\\;${ANDROID_BUILD_TOOLS_VERSION} --sdk_root=${ANDROID_SDK}")
		separate_arguments(ARGUMNTS)
		dk_exec(${ARGUMNTS})
	endif()
	if(NOT EXISTS ${ANDROID_SDK}/build-tools/${ANDROID_BUILD_TOOLS_VERSION})
		dk_fatal("Failed to install Android build-tools")
	endif()
	if(NOT EXISTS ${ANDROID_SDK}/platforms/${ANDROIDPLATFORM_VERSION})
		dk_info("Installing Android platform: ${ANDROIDPLATFORM_VERSION} . . .")
		set(ARGUMNTS "${SDKMANAGER_BAT} --install platforms\\;${ANDROIDPLATFORM_VERSION} --sdk_root=${ANDROID_SDK}")
		separate_arguments(ARGUMNTS)
		dk_exec(${ARGUMNTS} WORKING_DIRECTORY ${ANDROID_SDK}/bin)
	endif()
	if(NOT EXISTS ${ANDROID_SDK}/platforms/${ANDROIDPLATFORM_VERSION})
		dk_fatal("Failed to install Android platform")
	endif()
	if(NOT EXISTS ${ANDROID_SDK}/Sources/${ANDROIDSOURCES_VERSION})
		dk_info("Installing Android API sources: ${ANDROIDSOURCES_VERSION}")
		set(ARGUMNTS "${SDKMANAGER_BAT} --install sources\\;${ANDROIDSOURCES_VERSION} --sdk_root=${ANDROID_SDK}")
		separate_arguments(ARGUMNTS)
		dk_exec(${ARGUMNTS} WORKING_DIRECTORY ${ANDROID_SDK}/bin)
	endif()
	if(NOT EXISTS ${ANDROID_SDK}/Sources/${ANDROIDSOURCES_VERSION})
		dk_fatal("Failed to install Android sources")
	endif()
	if(NOT EXISTS ${ANDROID_SDK}/system-images/${ANDROID_SYSTEM_IMAGES_VERSION}/google_apis/armeabi-v7a)
		dk_info("Installing Android system image: ${ANDROID_SYSTEM_IMAGES_VERSION} armeabi-v7a")
		set(ARGUMNTS "${SDKMANAGER_BAT} --install system-images\\;${ANDROID_SYSTEM_IMAGES_VERSION}\\;google_apis\\;armeabi-v7a --sdk_root=${ANDROID_SDK}")
		separate_arguments(ARGUMNTS)
		dk_exec(${ARGUMNTS} WORKING_DIRECTORY ${ANDROID_SDK}/bin)
	endif()
	if(NOT EXISTS ${ANDROID_SDK}/system-images/${ANDROID_SYSTEM_IMAGES_VERSION}/google_apis/armeabi-v7a)
		dk_fatal("Failed to install Android Image armeabi-v7a")
	endif()
	if(NOT EXISTS ${ANDROID_SDK}/system-images/${ANDROID_SYSTEM_IMAGES_VERSION}/google_apis/arm64-v8a)
		dk_info("Installing Android API system image: ${ANDROID_SYSTEM_IMAGES_VERSION} arm64-v8a")
		set(ARGUMNTS "${SDKMANAGER_BAT} --install system-images\\;${ANDROID_SYSTEM_IMAGES_VERSION}\\;google_apis\\;arm64-v8a --sdk_root=${ANDROID_SDK}")
		separate_arguments(ARGUMNTS)
		dk_exec(${ARGUMNTS} WORKING_DIRECTORY ${ANDROID_SDK}/bin)
	endif()
	if(NOT EXISTS ${ANDROID_SDK}/system-images/${ANDROID_SYSTEM_IMAGES_VERSION}/google_apis/arm64-v8a)
		dk_fatal("Failed to install Android Image arm64-v8a")
	endif()
	if(NOT EXISTS ${ANDROID_SDK}/system-images/${ANDROID_SYSTEM_IMAGES_VERSION}/google_apis/x86)
		dk_info("Installing Android API system image: ${ANDROID_SYSTEM_IMAGES_VERSION} x86")
		set(ARGUMNTS "${SDKMANAGER_BAT} --install system-images\\;${ANDROID_SYSTEM_IMAGES_VERSION}\\;google_apis\\;x86 --sdk_root=${ANDROID_SDK}")
		separate_arguments(ARGUMNTS)
		dk_exec(${ARGUMNTS} WORKING_DIRECTORY ${ANDROID_SDK}/bin)
	endif()
	if(NOT EXISTS ${ANDROID_SDK}/system-images/${ANDROID_SYSTEM_IMAGES_VERSION}/google_apis/x86)
		dk_fatal("Failed to install Android Image x86")
	endif()
	if(NOT EXISTS ${ANDROID_SDK}/system-images/${ANDROID_SYSTEM_IMAGES_VERSION}/google_apis/x86_64)
		dk_info("Installing Android API system image: ${ANDROID_SYSTEM_IMAGES_VERSION} x86_64")
		set(ARGUMNTS "${SDKMANAGER_BAT} --install system-images\\;${ANDROID_SYSTEM_IMAGES_VERSION}\\;google_apis\\;x86_64 --sdk_root=${ANDROID_SDK}")
		separate_arguments(ARGUMNTS)
		dk_exec(${ARGUMNTS} WORKING_DIRECTORY ${ANDROID_SDK}/bin)
	endif()
	if(NOT EXISTS ${ANDROID_SDK}/system-images/${ANDROID_SYSTEM_IMAGES_VERSION}/google_apis/x86_64)
		dk_fatal("Failed to install Android Image x86_64")
	endif()
endif()


#if(MAC_HOST)
#	if(NOT EXISTS ${ANDROID_SDK}/build-tools/${ANDROID_BUILD_TOOLS_VERSION})
#		dk_info("Installing Android build-tools: ${ANDROID_BUILD_TOOLS_VERSION} . . .")
#		set(ARGUMNTS "${ANDROID_SDK}/bin/sdkmanager --install build-tools\\;${ANDROID_BUILD_TOOLS_VERSION} --sdk_root=${ANDROID_SDK}")
#		separate_arguments(ARGUMNTS)
#		dk_exec(COMMAND ${ARGUMNTS} WORKING_DIRECTORY ${ANDROID_SDK}/bin)
#	endif()
#	if(NOT EXISTS ${ANDROID_SDK}/platforms/${ANDROIDPLATFORM_VERSION})
#		dk_info("Installing Android platform: ${ANDROIDPLATFORM_VERSION} . . .")
#		set(ARGUMNTS "${ANDROID_SDK}/bin/sdkmanager --install platforms\\;${ANDROIDPLATFORM_VERSION} --sdk_root=${ANDROID_SDK}")
#		separate_arguments(ARGUMNTS)
#		dk_exec(COMMAND ${ARGUMNTS} WORKING_DIRECTORY ${ANDROID_SDK}/bin)
#	endif()
#endif()



#if(LINUX_HOST)
#	if(NOT EXISTS ${ANDROID_SDK}/build-tools/${ANDROID_BUILD_TOOLS_VERSION})
#		dk_info("Installing Android build-tools: ${ANDROID_BUILD_TOOLS_VERSION} . . .")
#		set(ARGUMNTS "${ANDROID_SDK}/bin/sdkmanager --install build-tools\\;${ANDROID_BUILD_TOOLS_VERSION} --sdk_root=${ANDROID_SDK}")
#		separate_arguments(ARGUMNTS)
#		dk_exec(COMMAND ${ARGUMNTS} WORKING_DIRECTORY ${ANDROID_SDK}/bin)
#	endif()
#	if(NOT EXISTS ${ANDROID_SDK}/platforms/${ANDROIDPLATFORM_VERSION})
#		dk_info("Installing Android platform: ${ANDROIDPLATFORM_VERSION} . . .")
#		set(ARGUMNTS "${ANDROID_SDK}/bin/sdkmanager --install platforms\\;${ANDROIDPLATFORM_VERSION} --sdk_root=${ANDROID_SDK}")
#		separate_arguments(ARGUMNTS)
#		dk_exec(COMMAND ${ARGUMNTS} WORKING_DIRECTORY ${ANDROID_SDK}/bin)
#	endif()
#endif()
