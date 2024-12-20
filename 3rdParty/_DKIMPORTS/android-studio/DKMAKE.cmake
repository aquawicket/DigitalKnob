#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### android-studio ######
# https://developer.android.com/studio/archive
# https://developer.android.com/studio#downloads
#
#	windows uninstall registry location
#   HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall\Android Studio
#

### DEPEND ###
dk_depend(openjdk-8u41)
dk_depend(android-ndk)

### IMPORT ###
if(WIN_X86_64_HOST)
	if(NOT EXISTS "${ProgramFiles}/Android/Android Studio/bin/studio64.exe")
		dk_validate		(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
		dk_getFileParam	(${DKIMPORTS_DIR}/android-studio/android-studio.txt ANDROID_STUDIO_WIN_DL)
		dk_basename		(${ANDROID_STUDIO_WIN_DL} ANDROID_STUDIO_DL_NAME)
		dk_download		(${ANDROID_STUDIO_WIN_DL} ${DKDOWNLOAD_DIR}/${ANDROID_STUDIO_DL_NAME})
		dk_command		(${DKDOWNLOAD_DIR}/${ANDROID_STUDIO_DL_NAME})
	endif()
elseif(MAC_HOST)
	if(NOT EXISTS "/Applications/Android Studio.app")
		dk_validate		(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
		dk_getFileParam	(${DKIMPORTS_DIR}/android-studio/android-studio.txt ANDROID_STUDIO_MAC_DL)
		dk_basename		(${ANDROID_STUDIO_MAC_DL} ANDROID_STUDIO_DL_NAME)
		dk_download		(${ANDROID_STUDIO_MAC_DL} ${DKDOWNLOAD_DIR}/${ANDROID_STUDIO_DL_NAME})
		# https://apple.stackexchange.com/a/73931
		dk_depend		(sudo)
		dk_command		(${SUDO_EXE} hdiutil attach ${DKDOWNLOAD_DIR}/${ANDROID_STUDIO_DL_NAME})
		dk_copy			("/Volumes/Android\ Studio\ -\ Dolphin\ \|\ 2021.3.1\ Patch\ 1/Android\ Studio.app" "/Applications/Android\ Studio.app")
		dk_command		(${SUDO_EXE} hdiutil detach "/Volumes/Android\ Studio\ -\ Dolphin\ \|\ 2021.3.1\ Patch\ 1")
	endif()
elseif(LINUX_HOST)
	dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
	if(NOT EXISTS "${DK3RDPARTY_DIR}/android-studio/bin/studio.sh")
		dk_validate		(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
		dk_getFileParam	(${DKIMPORTS_DIR}/android-studio/android-studio.txt ANDROID_STUDIO_LINUX_DL)
		dk_basename		(${ANDROID_STUDIO_LINUX_DL} ANDROID_STUDIO_DL_NAME)
		dk_download		(${ANDROID_STUDIO_LINUX_DL} ${DKDOWNLOAD_DIR}/${ANDROID_STUDIO_DL_NAME})
		dk_extract		(${DKDOWNLOAD_DIR}/${ANDROID_STUDIO_DL_NAME} ${DK3RDPARTY_DIR})
	endif()
endif()

### SET ENVIRONMENT VARIABLES ###
dk_setEnv("STUDIO_JDK" ${OPENJDK_8U41})
dk_setEnv("STUDIO_GRADLE_JDK" ${OPENJDK_8U41})
