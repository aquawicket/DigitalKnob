# https://developer.android.com/studio/archive
# https://developer.android.com/studio#downloads

if(NOT ANDROID)
	dk_undepend(android-studio)
	dk_return()
endif()


### DEPEND ###
dk_depend(openjdk-8u41)
dk_depend(android-ndk)


### IMPORT ###
if(WIN_HOST)
	if(NOT EXISTS "C:/Program Files/Android/Android Studio/bin/studio.exe")
		dk_download("https://redirector.gvt1.com/edgedl/android/studio/install/2020.3.1.26/android-studio-2020.3.1.26-windows.exe" ${DKDOWNLOAD}/android-studio-2020.3.1.26-windows.exe)
		dk_command(${DKDOWNLOAD}/android-studio-2020.3.1.26-windows.exe)
		#dk_remove(${DKDOWNLOAD}/android-studio-2020.3.1.26-windows.exe)
	endif()
endif()

if(MAC_HOST)
	if(NOT EXISTS "/Applications/Android Studio.app")
		dk_download("https://redirector.gvt1.com/edgedl/android/studio/install/2021.3.1.17/android-studio-2021.3.1.17-mac.dmg" ${DKDOWNLOAD}/android-studio-2021.3.1.17-mac.dmg)
		# https://apple.stackexchange.com/a/73931
		dk_command(sudo hdiutil attach ${DKDOWNLOAD}/android-studio-2021.3.1.17-mac.dmg)
		dk_copy("/Volumes/Android\ Studio\ -\ Dolphin\ \|\ 2021.3.1\ Patch\ 1/Android\ Studio.app" "/Applications/Android\ Studio.app")
		dk_command(sudo hdiutil detach "/Volumes/Android\ Studio\ -\ Dolphin\ \|\ 2021.3.1\ Patch\ 1")
		#dk_remove(${DKDOWNLOAD}/android-studio-2021.3.1.17-mac.dmg)
	endif()
endif()

if(LINUX_HOST)
	if(NOT EXISTS "${3RDPARTY}/android-studio/bin/studio.sh")
		dk_download("https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2021.3.1.17/android-studio-2021.3.1.17-linux.tar.gz" ${DKDOWNLOAD}/android-studio-2021.3.1.17-linux.tar.gz)
		dk_extract(${DKDOWNLOAD}/android-studio-2021.3.1.17-linux.tar.gz ${3RDPARTY})
		#dk_remove(${DKDOWNLOAD}/android-studio-2021.3.1.17-linux.tar.gz)
	endif()
endif()


### SET ENVIRONMENT VARIABLES ###
dk_setEnv("STUDIO_JDK" ${OPENJDK_8U41})
dk_setEnv("STUDIO_GRADLE_JDK" ${OPENJDK_8U41})
