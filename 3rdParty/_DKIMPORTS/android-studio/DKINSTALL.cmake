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


###### android-studio ######

### DEPEND ###
dk_depend(openjdk-8)
dk_depend(android-ndk)

### IMPORT ###
dk_getFileParams		("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
if(Windows_X86_64_Host)
	if(NOT EXISTS "${ProgramFiles}/Android/Android Studio/bin/studio64.exe")
		dk_basename		(${ANDROID_STUDIO_WIN_DL} ANDROID_STUDIO_DL_NAME)
		dk_download		(${ANDROID_STUDIO_WIN_DL} $ENV{DKDOWNLOAD_DIR}/${ANDROID_STUDIO_DL_NAME})
		dk_exec			($ENV{DKDOWNLOAD_DIR}/${ANDROID_STUDIO_DL_NAME})
	endif()
elseif(Mac_Host)
	if(NOT EXISTS "/Applications/Android Studio.app")
		dk_basename		(${ANDROID_STUDIO_MAC_DL} ANDROID_STUDIO_DL_NAME)
		dk_download		(${ANDROID_STUDIO_MAC_DL} $ENV{DKDOWNLOAD_DIR}/${ANDROID_STUDIO_DL_NAME})
		# https://apple.stackexchange.com/a/73931
		dk_depend		(sudo)
		dk_exec			(${SUDO_EXE} hdiutil attach $ENV{DKDOWNLOAD_DIR}/${ANDROID_STUDIO_DL_NAME})
		dk_copy			("/Volumes/Android\ Studio\ -\ Dolphin\ \|\ 2021.3.1\ Patch\ 1/Android\ Studio.app" "/Applications/Android\ Studio.app")
		dk_exec			(${SUDO_EXE} hdiutil detach "/Volumes/Android\ Studio\ -\ Dolphin\ \|\ 2021.3.1\ Patch\ 1")
	endif()
elseif(Linux_Host)
	dk_validate(ENV{DK3RDPARTY_DIR} "dk_DK3RDPARTY_DIR()")
	if(NOT EXISTS "$ENV{DK3RDPARTY_DIR}/android-studio/bin/studio.sh")
		dk_basename		(${ANDROID_STUDIO_LINUX_DL} ANDROID_STUDIO_DL_NAME)
		dk_download		(${ANDROID_STUDIO_LINUX_DL} $ENV{DKDOWNLOAD_DIR}/${ANDROID_STUDIO_DL_NAME})
		dk_extract		($ENV{DKDOWNLOAD_DIR}/${ANDROID_STUDIO_DL_NAME} $ENV{DK3RDPARTY_DIR})
	endif()
endif()

### SET ENVIRONMENT VARIABLES ###
dk_setEnv("STUDIO_JDK" ${OPENJDK_8})
dk_setEnv("STUDIO_GRADLE_JDK" ${OPENJDK_8})
