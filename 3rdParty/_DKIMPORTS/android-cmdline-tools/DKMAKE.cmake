# Information
# https://androidsdkmanager.azurewebsites.net/
# https://developer.android.com/studio/releases/cmdline-tools
# https://developer.android.com/studio?hl=fr#command-tools
# https://androidsdkoffline.blogspot.com/p/android-sdk-cmdline-tools-offline.html

if(NOT ANDROID)
	dk_undepend(android-cmdline-tools)
	dk_return()
endif()

#dk_depend(openjdk-8u41)

dk_set(ANDROID-SDK ${3RDPARTY}/android-sdk)
dk_makeDirectory(${ANDROID-SDK})
dk_makeDirectory(${ANDROID-SDK}/cmdline-tools)

# 7583922
WIN_HOST_dk_import(https://dl.google.com/android/repository/commandlinetools-win-7583922_latest.zip PATH ${ANDROID-SDK}/cmdline-tools/latest)
MAC_HOST_dk_import(https://dl.google.com/android/repository/commandlinetools-mac-7583922_latest.zip PATH ${ANDROID-SDK}/cmdline-tools/latest)
LINUX_HOST_dk_import(https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip PATH ${ANDROID-SDK}/cmdline-tools/latest)

# 8512546
#WIN_HOST_dk_import(https://dl.google.com/android/repository/commandlinetools-win-8512546_latest.zip PATH ${ANDROID-SDK}/cmdline-tools/latest)
#MAC_HOST_dk_import(https://dl.google.com/android/repository/commandlinetools-mac-8512546_latest.zip PATH ${ANDROID-SDK}/cmdline-tools/latest)
#LINUX_HOST_dk_import(https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip PATH ${ANDROID-SDK}/cmdline-tools/latest)


dk_set(SDKMANAGER_BAT ${ANDROID-CMDLINE-TOOLS}/bin/sdkmanager.bat)







## FIXME
dk_return()


if(WIN_HOST)
	dk_executeProcess(sdkmanager --sdk_root=${ANDROID-SDK} WORKING_DIRECTORY ${ANDROID-CMDLINE-TOOLS}/bin)
	if(NOT EXISTS ${ANDROID-SDK}/build-tools/${ANDROID-BUILD-TOOLS_VERSION})
		dk_info("Installing Android build-tools: ${ANDROID-BUILD-TOOLS_VERSION} . . .")
		set(ARGUMNTS "${SDKMANAGER_BAT} --install build-tools\\;${ANDROID-BUILD-TOOLS_VERSION} --sdk_root=${ANDROID-SDK}")
		separate_arguments(ARGUMNTS)
		dk_executeProcess(${ARGUMNTS})
	endif()
	if(NOT EXISTS ${ANDROID-SDK}/build-tools/${ANDROID-BUILD-TOOLS_VERSION})
		dk_assert("Failed to install Android build-tools")
	endif()
	if(NOT EXISTS ${ANDROID-SDK}/platforms/${ANDROIDPLATFORM_VERSION})
		dk_info("Installing Android platform: ${ANDROIDPLATFORM_VERSION} . . .")
		set(ARGUMNTS "${SDKMANAGER_BAT} --install platforms\\;${ANDROIDPLATFORM_VERSION} --sdk_root=${ANDROID-SDK}")
		separate_arguments(ARGUMNTS)
		dk_executeProcess(${ARGUMNTS} WORKING_DIRECTORY ${ANDROID-SDK}/bin)
	endif()
	if(NOT EXISTS ${ANDROID-SDK}/platforms/${ANDROIDPLATFORM_VERSION})
		dk_assert("Failed to install Android platform")
	endif()
	if(NOT EXISTS ${ANDROID-SDK}/Sources/${ANDROIDSOURCES_VERSION})
		dk_info("Installing Android API sources: ${ANDROIDSOURCES_VERSION}")
		set(ARGUMNTS "${SDKMANAGER_BAT} --install sources\\;${ANDROIDSOURCES_VERSION} --sdk_root=${ANDROID-SDK}")
		separate_arguments(ARGUMNTS)
		dk_executeProcess(${ARGUMNTS} WORKING_DIRECTORY ${ANDROID-SDK}/bin)
	endif()
	if(NOT EXISTS ${ANDROID-SDK}/Sources/${ANDROIDSOURCES_VERSION})
		dk_assert("Failed to install Android sources")
	endif()
	if(NOT EXISTS ${ANDROID-SDK}/system-images/${ANDROID-SYSTEM-IMAGES_VERSION}/google_apis/armeabi-v7a)
		dk_info("Installing Android system image: ${ANDROID-SYSTEM-IMAGES_VERSION} armeabi-v7a")
		set(ARGUMNTS "${SDKMANAGER_BAT} --install system-images\\;${ANDROID-SYSTEM-IMAGES_VERSION}\\;google_apis\\;armeabi-v7a --sdk_root=${ANDROID-SDK}")
		separate_arguments(ARGUMNTS)
		dk_executeProcess(${ARGUMNTS} WORKING_DIRECTORY ${ANDROID-SDK}/bin)
	endif()
	if(NOT EXISTS ${ANDROID-SDK}/system-images/${ANDROID-SYSTEM-IMAGES_VERSION}/google_apis/armeabi-v7a)
		dk_assert("Failed to install Android Image armeabi-v7a")
	endif()
	if(NOT EXISTS ${ANDROID-SDK}/system-images/${ANDROID-SYSTEM-IMAGES_VERSION}/google_apis/arm64-v8a)
		dk_info("Installing Android API system image: ${ANDROID-SYSTEM-IMAGES_VERSION} arm64-v8a")
		set(ARGUMNTS "${SDKMANAGER_BAT} --install system-images\\;${ANDROID-SYSTEM-IMAGES_VERSION}\\;google_apis\\;arm64-v8a --sdk_root=${ANDROID-SDK}")
		separate_arguments(ARGUMNTS)
		dk_executeProcess(${ARGUMNTS} WORKING_DIRECTORY ${ANDROID-SDK}/bin)
	endif()
	if(NOT EXISTS ${ANDROID-SDK}/system-images/${ANDROID-SYSTEM-IMAGES_VERSION}/google_apis/arm64-v8a)
		dk_assert("Failed to install Android Image arm64-v8a")
	endif()
	if(NOT EXISTS ${ANDROID-SDK}/system-images/${ANDROID-SYSTEM-IMAGES_VERSION}/google_apis/x86)
		dk_info("Installing Android API system image: ${ANDROID-SYSTEM-IMAGES_VERSION} x86")
		set(ARGUMNTS "${SDKMANAGER_BAT} --install system-images\\;${ANDROID-SYSTEM-IMAGES_VERSION}\\;google_apis\\;x86 --sdk_root=${ANDROID-SDK}")
		separate_arguments(ARGUMNTS)
		dk_executeProcess(${ARGUMNTS} WORKING_DIRECTORY ${ANDROID-SDK}/bin)
	endif()
	if(NOT EXISTS ${ANDROID-SDK}/system-images/${ANDROID-SYSTEM-IMAGES_VERSION}/google_apis/x86)
		dk_assert("Failed to install Android Image x86")
	endif()
	if(NOT EXISTS ${ANDROID-SDK}/system-images/${ANDROID-SYSTEM-IMAGES_VERSION}/google_apis/x86_64)
		dk_info("Installing Android API system image: ${ANDROID-SYSTEM-IMAGES_VERSION} x86_64")
		set(ARGUMNTS "${SDKMANAGER_BAT} --install system-images\\;${ANDROID-SYSTEM-IMAGES_VERSION}\\;google_apis\\;x86_64 --sdk_root=${ANDROID-SDK}")
		separate_arguments(ARGUMNTS)
		dk_executeProcess(${ARGUMNTS} WORKING_DIRECTORY ${ANDROID-SDK}/bin)
	endif()
	if(NOT EXISTS ${ANDROID-SDK}/system-images/${ANDROID-SYSTEM-IMAGES_VERSION}/google_apis/x86_64)
		dk_assert("Failed to install Android Image x86_64")
	endif()
endif()


#if(MAC_HOST)
#	if(NOT EXISTS ${ANDROID-SDK}/build-tools/${ANDROID-BUILD-TOOLS_VERSION})
#		dk_info("Installing Android build-tools: ${ANDROID-BUILD-TOOLS_VERSION} . . .")
#		set(ARGUMNTS "${ANDROID-SDK}/bin/sdkmanager --install build-tools\\;${ANDROID-BUILD-TOOLS_VERSION} --sdk_root=${ANDROID-SDK}")
#		separate_arguments(ARGUMNTS)
#		dk_executeProcess(COMMAND ${ARGUMNTS} WORKING_DIRECTORY ${ANDROID-SDK}/bin)
#	endif()
#	if(NOT EXISTS ${ANDROID-SDK}/platforms/${ANDROIDPLATFORM_VERSION})
#		dk_info("Installing Android platform: ${ANDROIDPLATFORM_VERSION} . . .")
#		set(ARGUMNTS "${ANDROID-SDK}/bin/sdkmanager --install platforms\\;${ANDROIDPLATFORM_VERSION} --sdk_root=${ANDROID-SDK}")
#		separate_arguments(ARGUMNTS)
#		dk_executeProcess(COMMAND ${ARGUMNTS} WORKING_DIRECTORY ${ANDROID-SDK}/bin)
#	endif()
#endif()



#if(LINUX_HOST)
#	if(NOT EXISTS ${ANDROID-SDK}/build-tools/${ANDROID-BUILD-TOOLS_VERSION})
#		dk_info("Installing Android build-tools: ${ANDROID-BUILD-TOOLS_VERSION} . . .")
#		set(ARGUMNTS "${ANDROID-SDK}/bin/sdkmanager --install build-tools\\;${ANDROID-BUILD-TOOLS_VERSION} --sdk_root=${ANDROID-SDK}")
#		separate_arguments(ARGUMNTS)
#		dk_executeProcess(COMMAND ${ARGUMNTS} WORKING_DIRECTORY ${ANDROID-SDK}/bin)
#	endif()
#	if(NOT EXISTS ${ANDROID-SDK}/platforms/${ANDROIDPLATFORM_VERSION})
#		dk_info("Installing Android platform: ${ANDROIDPLATFORM_VERSION} . . .")
#		set(ARGUMNTS "${ANDROID-SDK}/bin/sdkmanager --install platforms\\;${ANDROIDPLATFORM_VERSION} --sdk_root=${ANDROID-SDK}")
#		separate_arguments(ARGUMNTS)
#		dk_executeProcess(COMMAND ${ARGUMNTS} WORKING_DIRECTORY ${ANDROID-SDK}/bin)
#	endif()
#endif()
