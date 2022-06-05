# Information
# https://androidsdkmanager.azurewebsites.net/
# https://developer.android.com/studio/releases/cmdline-tools
# https://developer.android.com/studio?hl=fr#command-tools
# https://androidsdkoffline.blogspot.com/p/android-sdk-cmdline-tools-offline.html

# Downloads
# https://dl.google.com/android/repository/commandlinetools-win-7302050_latest.zip
# https://dl.google.com/android/repository/commandlinetools-mac-7302050_latest.zip
# https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip
# https://dl.google.com/android/repository/commandlinetools-win-7583922_latest.zip

if(NOT WIN_HOST)
	return()
endif()

### DEPENDS ###
#DKDEPEND(jdk8)

### VERSION ###
#DKSET(ANDROIDTOOLS ${3RDPARTY}/android-cmdline-tools)
DKSET(ANDROIDTOOLS ${3RDPARTY}/android-sdk/cmdline-tools/latest)
#file(MAKE_DIRECTORY ${3RDPARTY}/android-sdk/cmdline-tools/latest)
dk_makeDirectory(${3RDPARTY}/android-sdk/cmdline-tools/latest)

DKSET(SDKMANAGER_EXE ${ANDROIDTOOLS}/bin/sdkmanager.bat)
WIN_HOST_DKSET(ANDROIDTOOLS_DL https://dl.google.com/android/repository/commandlinetools-win-7583922_latest.zip)
MAC_HOST_DKSET(ANDROIDTOOLS_DL https://dl.google.com/android/repository/commandlinetools-mac-7302050_latest.zip)
LINUX_HOST_DKSET(ANDROIDTOOLS_DL https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip)


### INSTALL ###
DKINSTALL(${ANDROIDTOOLS_DL} android-cmdline-tools ${ANDROIDTOOLS})

return()
if(WIN_HOST)
	DKEXECUTE_PROCESS(sdkmanager --sdk_root=${ANDROIDSDK} WORKING_DIRECTORY ${ANDROIDTOOLS}/bin)
	if(NOT EXISTS ${ANDROIDSDK}/build-tools/${ANDROIDBUILDTOOLS_VERSION})
		DKINFO("Installing Android build-tools: ${ANDROIDBUILDTOOLS_VERSION} . . .")
		set(ARGUMNTS "${SDKMANAGER_EXE} --install build-tools\\;${ANDROIDBUILDTOOLS_VERSION} --sdk_root=${ANDROIDSDK}")
		separate_arguments(ARGUMNTS)
		DKEXECUTE_PROCESS(${ARGUMNTS})
	endif()
	if(NOT EXISTS ${ANDROIDSDK}/build-tools/${ANDROIDBUILDTOOLS_VERSION})
		DKERROR("Failed to install Android build-tools")
	endif()
	if(NOT EXISTS ${ANDROIDSDK}/platforms/${ANDROIDPLATFORM_VERSION})
		DKINFO("Installing Android platform: ${ANDROIDPLATFORM_VERSION} . . .")
		set(ARGUMNTS "${SDKMANAGER_EXE} --install platforms\\;${ANDROIDPLATFORM_VERSION} --sdk_root=${ANDROIDSDK}")
		separate_arguments(ARGUMNTS)
		DKEXECUTE_PROCESS(${ARGUMNTS} WORKING_DIRECTORY ${ANDROIDSDK}/bin)
	endif()
	if(NOT EXISTS ${ANDROIDSDK}/platforms/${ANDROIDPLATFORM_VERSION})
		DKERROR("Failed to install Android platform")
	endif()
	if(NOT EXISTS ${ANDROIDSDK}/Sources/${ANDROIDSOURCES_VERSION})
		DKINFO("Installing Android API sources: ${ANDROIDSOURCES_VERSION}")
		set(ARGUMNTS "${SDKMANAGER_EXE} --install sources\\;${ANDROIDSOURCES_VERSION} --sdk_root=${ANDROIDSDK}")
		separate_arguments(ARGUMNTS)
		DKEXECUTE_PROCESS(${ARGUMNTS} WORKING_DIRECTORY ${ANDROIDSDK}/bin)
	endif()
	if(NOT EXISTS ${ANDROIDSDK}/Sources/${ANDROIDSOURCES_VERSION})
		DKERROR("Failed to install Android sources")
	endif()
	if(NOT EXISTS ${ANDROIDSDK}/system-images/${ANDROIDIMAGES_VERSION}/google_apis/armeabi-v7a)
		DKINFO("Installing Android system image: ${ANDROIDIMAGES_VERSION} armeabi-v7a")
		set(ARGUMNTS "${SDKMANAGER_EXE} --install system-images\\;${ANDROIDIMAGES_VERSION}\\;google_apis\\;armeabi-v7a --sdk_root=${ANDROIDSDK}")
		separate_arguments(ARGUMNTS)
		DKEXECUTE_PROCESS(${ARGUMNTS} WORKING_DIRECTORY ${ANDROIDSDK}/bin)
	endif()
	if(NOT EXISTS ${ANDROIDSDK}/system-images/${ANDROIDIMAGES_VERSION}/google_apis/armeabi-v7a)
		DKERROR("Failed to install Android Image armeabi-v7a")
	endif()
	if(NOT EXISTS ${ANDROIDSDK}/system-images/${ANDROIDIMAGES_VERSION}/google_apis/arm64-v8a)
		DKINFO("Installing Android API system image: ${ANDROIDIMAGES_VERSION} arm64-v8a")
		set(ARGUMNTS "${SDKMANAGER_EXE} --install system-images\\;${ANDROIDIMAGES_VERSION}\\;google_apis\\;arm64-v8a --sdk_root=${ANDROIDSDK}")
		separate_arguments(ARGUMNTS)
		DKEXECUTE_PROCESS(${ARGUMNTS} WORKING_DIRECTORY ${ANDROIDSDK}/bin)
	endif()
	if(NOT EXISTS ${ANDROIDSDK}/system-images/${ANDROIDIMAGES_VERSION}/google_apis/arm64-v8a)
		DKERROR("Failed to install Android Image arm64-v8a")
	endif()
	if(NOT EXISTS ${ANDROIDSDK}/system-images/${ANDROIDIMAGES_VERSION}/google_apis/x86)
		DKINFO("Installing Android API system image: ${ANDROIDIMAGES_VERSION} x86")
		set(ARGUMNTS "${SDKMANAGER_EXE} --install system-images\\;${ANDROIDIMAGES_VERSION}\\;google_apis\\;x86 --sdk_root=${ANDROIDSDK}")
		separate_arguments(ARGUMNTS)
		DKEXECUTE_PROCESS(${ARGUMNTS} WORKING_DIRECTORY ${ANDROIDSDK}/bin)
	endif()
	if(NOT EXISTS ${ANDROIDSDK}/system-images/${ANDROIDIMAGES_VERSION}/google_apis/x86)
		DKERROR("Failed to install Android Image x86")
	endif()
	if(NOT EXISTS ${ANDROIDSDK}/system-images/${ANDROIDIMAGES_VERSION}/google_apis/x86_64)
		DKINFO("Installing Android API system image: ${ANDROIDIMAGES_VERSION} x86_64")
		set(ARGUMNTS "${SDKMANAGER_EXE} --install system-images\\;${ANDROIDIMAGES_VERSION}\\;google_apis\\;x86_64 --sdk_root=${ANDROIDSDK}")
		separate_arguments(ARGUMNTS)
		DKEXECUTE_PROCESS(${ARGUMNTS} WORKING_DIRECTORY ${ANDROIDSDK}/bin)
	endif()
	if(NOT EXISTS ${ANDROIDSDK}/system-images/${ANDROIDIMAGES_VERSION}/google_apis/x86_64)
		DKERROR("Failed to install Android Image x86_64")
	endif()
endif()


#if(MAC_HOST)
#	if(NOT EXISTS ${ANDROIDSDK}/build-tools/${ANDROIDBUILDTOOLS_VERSION})
#		DKINFO("Installing Android build-tools: ${ANDROIDBUILDTOOLS_VERSION} . . .")
#		set(ARGUMNTS "${ANDROIDSDK}/bin/sdkmanager --install build-tools\\;${ANDROIDBUILDTOOLS_VERSION} --sdk_root=${ANDROIDSDK}")
#		separate_arguments(ARGUMNTS)
#		DKEXECUTE_PROCESS(COMMAND ${ARGUMNTS} WORKING_DIRECTORY ${ANDROIDSDK}/bin)
#	endif()
#	if(NOT EXISTS ${ANDROIDSDK}/platforms/${ANDROIDPLATFORM_VERSION})
#		DKINFO("Installing Android platform: ${ANDROIDPLATFORM_VERSION} . . .")
#		set(ARGUMNTS "${ANDROIDSDK}/bin/sdkmanager --install platforms\\;${ANDROIDPLATFORM_VERSION} --sdk_root=${ANDROIDSDK}")
#		separate_arguments(ARGUMNTS)
#		DKEXECUTE_PROCESS(COMMAND ${ARGUMNTS} WORKING_DIRECTORY ${ANDROIDSDK}/bin)
#	endif()
#endif()



#if(LINUX_HOST)
#	if(NOT EXISTS ${ANDROIDSDK}/build-tools/${ANDROIDBUILDTOOLS_VERSION})
#		DKINFO("Installing Android build-tools: ${ANDROIDBUILDTOOLS_VERSION} . . .")
#		set(ARGUMNTS "${ANDROIDSDK}/bin/sdkmanager --install build-tools\\;${ANDROIDBUILDTOOLS_VERSION} --sdk_root=${ANDROIDSDK}")
#		separate_arguments(ARGUMNTS)
#		DKEXECUTE_PROCESS(COMMAND ${ARGUMNTS} WORKING_DIRECTORY ${ANDROIDSDK}/bin)
#	endif()
#	if(NOT EXISTS ${ANDROIDSDK}/platforms/${ANDROIDPLATFORM_VERSION})
#		DKINFO("Installing Android platform: ${ANDROIDPLATFORM_VERSION} . . .")
#		set(ARGUMNTS "${ANDROIDSDK}/bin/sdkmanager --install platforms\\;${ANDROIDPLATFORM_VERSION} --sdk_root=${ANDROIDSDK}")
#		separate_arguments(ARGUMNTS)
#		DKEXECUTE_PROCESS(COMMAND ${ARGUMNTS} WORKING_DIRECTORY ${ANDROIDSDK}/bin)
#	endif()
#endif()
