# https://developer.android.com/studio/archive
# https://developer.android.com/studio#downloads

if(NOT ANDROID)
	dk_undepend(android-studio)
	return()
endif()


### DEPEND ###
dk_depend(openjdk-8u41)
dk_depend(android-ndk)


### IMPORT ###
if(WIN_HOST)
	dk_set(ANDROID-STUDIO "C:/Program Files/Android/Android Studio/bin")
	dk_set(ANDROID-STUDIO_EXE "${ANDROID-STUDIO}/studio.exe")
	if(NOT EXISTS ${ANDROID-STUDIO_EXE})
		dk_download("https://redirector.gvt1.com/edgedl/android/studio/install/2020.3.1.26/android-studio-2020.3.1.26-windows.exe" ${DKDOWNLOAD}/android-studio-2020.3.1.26-windows.exe)
		dk_command(${DKDOWNLOAD}/android-studio-2020.3.1.26-windows.exe)
	endif()
endif()

if(MAC_HOST)
	dk_set(ANDROID-STUDIO "/Applications")
	dk_set(ANDROID-STUDIO_EXE "${ANDROID-STUDIO}/Android Studio.app")
	if(NOT EXISTS ${ANDROID-STUDIO_EXE})
		dk_download("https://redirector.gvt1.com/edgedl/android/studio/install/2021.3.1.17/android-studio-2021.3.1.17-mac.dmg" ${DKDOWNLOAD}/android-studio-2021.3.1.17-mac.dmg)
		dk_command(chmod 777 ${DKDOWNLOAD}/android-studio-2021.3.1.17-mac.dmg)
		dk_command(sudo hdiutil attach ${DKDOWNLOAD}/android-studio-2021.3.1.17-mac.dmg)
		dk_copy("/Volumes/Android\ Studio\ -\ Dolphin\ \|\ 2021.3.1\ Patch\ 1/Android\ Studio.app" "/Applications/Android\ Studio.app")
	endif()
endif()

if(LINUX_HOST)
	dk_set(ANDROID-STUDIO "${3RDPARTY}/android-studio/bin")
	dk_set(ANDROID-STUDIO_EXE "${ANDROID-STUDIO}/Android Studio.app")
	if(NOT EXISTS ${ANDROID-STUDIO_EXE})
		dk_download("https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2021.3.1.17/android-studio-2021.3.1.17-linux.tar.gz" ${DKDOWNLOAD}/android-studio-2021.3.1.17-linux.tar.gz)
		dk_extract(${DKDOWNLOAD}/android-studio-2021.3.1.17-linux.tar.gz ${3RDPARTY}/android-studio)
	endif()
endif()


### SET ENVIRONMENT VARIABLES ###
dk_setEnv("STUDIO_JDK" ${OPENJDK-8U41})
dk_setEnv("STUDIO_GRADLE_JDK" ${OPENJDK-8U41})
