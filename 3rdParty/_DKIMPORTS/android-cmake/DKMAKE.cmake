#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### android-cmake ######
# https://androidsdkoffline.blogspot.com/p/android-ndk-cmake-direct-download.html

dk_depend(android-sdk)

# 3.18.1
dk_validate(host_triple "dk_host_triple()")
dk_validate(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
if(WIN_HOST)
	dk_getFileParam($ENV{DKIMPORTS_DIR}/android-cmake/dkconfig.txt ANDROID_CMAKE_WIN_DL)
	dk_import(${ANDROID_CMAKE_WIN_DL} PATH ${ANDROID_SDK}/cmake)
elseif(MAC_HOST)
	dk_getFileParam($ENV{DKIMPORTS_DIR}/android-cmake/dkconfig.txt ANDROID_CMAKE_MAC_DL)
	dk_import(${ANDROID_CMAKE_MAC_DL} PATH ${ANDROID_SDK}/cmake)
elseif(LINUX_DL)
	dk_getFileParam($ENV{DKIMPORTS_DIR}/android-cmake/dkconfig.txt ANDROID_CMAKE_LINUX_DL)
	dk_import(${ANDROID_CMAKE_LINUX_DL} PATH ${ANDROID_SDK}/cmake)
endif()

# 3.22.1
#WIN_HOST_dk_import(https://dl.google.com/android/repository/cmake-3.22.1-windows.zip PATH ${ANDROID_SDK}/cmake)
#MAC_HOST_dk_import(https://dl.google.com/android/repository/cmake-3.22.1-darwin.zip PATH ${ANDROID_SDK}/cmake)
#LINUX_HOST_dk_import(https://dl.google.com/android/repository/cmake-3.22.1-linux.zip PATH ${ANDROID_SDK}/cmake)
