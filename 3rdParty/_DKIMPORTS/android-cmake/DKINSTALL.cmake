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


###### android-cmake ######
# https://androidsdkoffline.blogspot.com/p/android-ndk-cmake-direct-download.html

dk_depend(android-sdk)

# 3.18.1
dk_validate		(Host_Tuple "dk_Host_Tuple()")
dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
if(Windows_Host)
	dk_import	(${ANDROID_CMAKE_WIN_IMPORT} PATH ${ANDROID_SDK}/cmake)
elseif(Mac_Host)
	dk_import	(${ANDROID_CMAKE_MAC_IMPORT} PATH ${ANDROID_SDK}/cmake)
elseif(LINUX_DL)
	dk_import	(${ANDROID_CMAKE_LINUX_IMPORT} PATH ${ANDROID_SDK}/cmake)
endif()

# 3.22.1
#Windows_Host_dk_import(https://dl.google.com/android/repository/cmake-3.22.1-windows.zip PATH ${ANDROID_SDK}/cmake)
#Mac_Host_dk_import(https://dl.google.com/android/repository/cmake-3.22.1-darwin.zip PATH ${ANDROID_SDK}/cmake)
#Linux_Host_dk_import(https://dl.google.com/android/repository/cmake-3.22.1-linux.zip PATH ${ANDROID_SDK}/cmake)
