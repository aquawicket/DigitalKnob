#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


###### android-studio ######
dk_validate(openjdk-8 "dk_depend(openjdk-8)")
dk_validate(android-ndk "dk_depend(android-ndk)")

if(Windows_X86_64_Host)
	if(NOT EXISTS "${ProgramFiles}/Android/Android Studio/bin/studio64.exe")
		dk_download		(${android-studio_Windows_Import})
		dk_exec			(${dk_download})
	endif()
elseif(Mac_Host)
	if(NOT EXISTS "/Applications/Android Studio.app")
		dk_download		(${android-studio_Mac_Import})
		# https://apple.stackexchange.com/a/73931
		dk_validate		(sudo_exe "dk_depend(sudo_exe)")
		dk_exec			(${sudo_exe} hdiutil attach ${dk_download})
		dk_copy			("/Volumes/Android\ Studio\ -\ Dolphin\ \|\ 2021.3.1\ Patch\ 1/Android\ Studio.app" "/Applications/Android\ Studio.app")
		dk_exec			(${sudo_exe} hdiutil detach "/Volumes/Android\ Studio\ -\ Dolphin\ \|\ 2021.3.1\ Patch\ 1")
	endif()
elseif(Linux_Host)
	dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
	if(NOT EXISTS "${DK3RDPARTY_DIR}/android-studio/bin/studio.sh")
		dk_download		(${android-studio_Linux_Import})
		dk_extract		(${dk_download} ${DK3RDPARTY_DIR})
	endif()
endif()

### SET ENVIRONMENT VARIABLES ###
dk_setEnv("STUDIO_JDK" ${openjdk-8})
dk_setEnv("STUDIO_GRADLE_JDK" ${openjdk-8})
