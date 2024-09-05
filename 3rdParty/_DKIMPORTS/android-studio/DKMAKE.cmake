include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://developer.android.com/studio/archive
# https://developer.android.com/studio#downloads

if(NOT ANDROID)
	dk_undepend(android-studio)
	dk_return()
endif()


### DEPEND ###
dk_depend(openjdk-8u41)
dk_depend(android-ndk)
dk_depend(sudo)


### IMPORT ###
if(WIN_HOST)
	if(NOT EXISTS "${ProgramFiles}/Android/Android Studio/bin/studio.exe")
		dk_download("https://redirector.gvt1.com/edgedl/android/studio/install/2020.3.1.26/android-studio-2020.3.1.26-windows.exe" ${DKDOWNLOAD_DIR}/android-studio-2020.3.1.26-windows.exe)
		dk_command(${DKDOWNLOAD_DIR}/android-studio-2020.3.1.26-windows.exe)
		#dk_delete(${DKDOWNLOAD_DIR}/android-studio-2020.3.1.26-windows.exe)
	endif()
endif()

if(MAC_HOST)
	if(NOT EXISTS "/Applications/Android Studio.app")
		dk_download("https://redirector.gvt1.com/edgedl/android/studio/install/2021.3.1.17/android-studio-2021.3.1.17-mac.dmg" ${DKDOWNLOAD_DIR}/android-studio-2021.3.1.17-mac.dmg)
		# https://apple.stackexchange.com/a/73931
		dk_command(${SUDO} hdiutil attach ${DKDOWNLOAD_DIR}/android-studio-2021.3.1.17-mac.dmg)
		dk_copy("/Volumes/Android\ Studio\ -\ Dolphin\ \|\ 2021.3.1\ Patch\ 1/Android\ Studio.app" "/Applications/Android\ Studio.app")
		dk_command(${SUDO} hdiutil detach "/Volumes/Android\ Studio\ -\ Dolphin\ \|\ 2021.3.1\ Patch\ 1")
		#dk_delete(${DKDOWNLOAD_DIR}/android-studio-2021.3.1.17-mac.dmg)
	endif()
endif()

if(LINUX_HOST)
	if(NOT EXISTS "${DK3RDPARTY_DIR}/android-studio/bin/studio.sh")
		dk_download("https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2021.3.1.17/android-studio-2021.3.1.17-linux.tar.gz" ${DKDOWNLOAD_DIR}/android-studio-2021.3.1.17-linux.tar.gz)
		dk_extract(${DKDOWNLOAD_DIR}/android-studio-2021.3.1.17-linux.tar.gz ${DK3RDPARTY_DIR})
		#dk_delete(${DKDOWNLOAD_DIR}/android-studio-2021.3.1.17-linux.tar.gz)
	endif()
endif()


### SET ENVIRONMENT VARIABLES ###
dk_setEnv("STUDIO_JDK" ${OPENJDK_8U41})
dk_setEnv("STUDIO_GRADLE_JDK" ${OPENJDK_8U41})
