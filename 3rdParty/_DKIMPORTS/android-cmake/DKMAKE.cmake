# https://dl.google.com/android/repository/7c386a739f915f5bd60051f2572c24782388e807.cmake-3.18.1-windows.zip

if(NOT ANDROID)
	dk_undepend(android-cmake)
	return()
endif()

dk_depend(android-sdk)

dk_import(https://dl.google.com/android/repository/7c386a739f915f5bd60051f2572c24782388e807.cmake-3.18.1-windows.zip PATH ${ANDROID-SDK}/cmake)
