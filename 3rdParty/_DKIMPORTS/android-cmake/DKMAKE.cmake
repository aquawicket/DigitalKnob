# https://androidsdkoffline.blogspot.com

if(NOT ANDROID)
	dk_undepend(android-cmake)
	return()
endif()

dk_depend(android-sdk)

WIN_HOST_dk_import(https://dl.google.com/android/repository/7c386a739f915f5bd60051f2572c24782388e807.cmake-3.18.1-windows.zip PATH ${ANDROID-SDK}/cmake)
MAC_HOST_dk_import(https://dl.google.com/android/repository/ba34c321f92f6e6fd696c8354c262c122f56abf8.cmake-3.18.1-darwin.zip PATH ${ANDROID-SDK}/cmake)
LINUX_HOST_dk_import(https://dl.google.com/android/repository/cmake-3.18.1-linux.zip PATH ${ANDROID-SDK}/cmake)
