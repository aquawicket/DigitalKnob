#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### android-studio ######
# https://developer.android.com/studio/archive
# https://developer.android.com/studio#downloads

### DEPEND ###
dk_depend(openjdk-8u41)
dk_depend(android-ndk)


### IMPORT ###
if(WIN_HOST)
	if(NOT EXISTS "${ProgramFiles}/Android/Android Studio/bin/studio.exe")
		dk_validate		(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
		dk_getFileParam	(${DKIMPORTS_DIR}/android-studio/android-studio.txt ANDROID_STUDIO_WIN_DL)
		dk_download(${ANDROID_STUDIO_WIN_DL} ${DKDOWNLOAD_DIR}/android-studio-2020.3.1.26-windows.exe)
		dk_command(${DKDOWNLOAD_DIR}/android-studio-2020.3.1.26-windows.exe)
	endif()
endif()

if(MAC_HOST)
	if(NOT EXISTS "/Applications/Android Studio.app")
		dk_validate		(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
		dk_getFileParam	(${DKIMPORTS_DIR}/android-studio/android-studio.txt ANDROID_STUDIO_MAC_DL)
		dk_download(${ANDROID_STUDIO_MAC_DL} ${DKDOWNLOAD_DIR}/android-studio-2021.3.1.17-mac.dmg)
		# https://apple.stackexchange.com/a/73931
		dk_depend(sudo)
		dk_command(${SUDO_EXE} hdiutil attach ${DKDOWNLOAD_DIR}/android-studio-2021.3.1.17-mac.dmg)
		dk_copy("/Volumes/Android\ Studio\ -\ Dolphin\ \|\ 2021.3.1\ Patch\ 1/Android\ Studio.app" "/Applications/Android\ Studio.app")
		dk_command(${SUDO_EXE} hdiutil detach "/Volumes/Android\ Studio\ -\ Dolphin\ \|\ 2021.3.1\ Patch\ 1")
		#dk_delete(${DKDOWNLOAD_DIR}/android-studio-2021.3.1.17-mac.dmg)
	endif()
endif()

if(LINUX_HOST)
	dk_validate(DK3RDPARTY_DIR "dk_DKBRANCH_DIR()")
	if(NOT EXISTS "${DK3RDPARTY_DIR}/android-studio/bin/studio.sh")
		dk_validate		(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
		dk_getFileParam	(${DKIMPORTS_DIR}/android-studio/android-studio.txt ANDROID_STUDIO_LINUX_DL)
		dk_download(${ANDROID_STUDIO_LINUX_DL} ${DKDOWNLOAD_DIR}/android-studio-2021.3.1.17-linux.tar.gz)
		dk_extract(${DKDOWNLOAD_DIR}/android-studio-2021.3.1.17-linux.tar.gz ${DK3RDPARTY_DIR})
		#dk_delete(${DKDOWNLOAD_DIR}/android-studio-2021.3.1.17-linux.tar.gz)
	endif()
endif()


### SET ENVIRONMENT VARIABLES ###
dk_setEnv("STUDIO_JDK" ${OPENJDK_8U41})
dk_setEnv("STUDIO_GRADLE_JDK" ${OPENJDK_8U41})
