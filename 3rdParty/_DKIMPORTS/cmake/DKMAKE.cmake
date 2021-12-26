# https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi
# https://developer.android.com/studio/projects/configure-cmake

MAC_DEPEND(homebrew)


### VERSION ###
WIN_HOST_SET(CMAKE_VERSION 3.21.1)
WIN_HOST_SET(CMAKE_NAME cmake-${CMAKE_VERSION})
WIN_HOST_SET(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/${CMAKE_NAME}-windows-i386.msi)
#dk_getShortPath("C:/Program Files (x86)/CMake/bin" CMAKE)

WIN_HOST_SET(CMAKE C:/PROGRA~2/CMake/bin)
MAC_HOST_SET(CMAKE /usr/local/bin)
LINUX_HOST_SET(CMAKE /usr/bin)

WIN_HOST_SET(CMAKE_EXE ${CMAKE}/cmake.exe)
UNIX_HOST_SET(CMAKE_EXE ${CMAKE}/cmake)


### INSTALL ###
DKINFO("looking for cmake at ${CMAKE_EXE}")
if(NOT EXISTS "${CMAKE_EXE}")
	DKINFO("cmake NOT FOUND")
	DKINFO("Installing cmake ${CMAKE_VERSION}")
	WIN_HOST_DOWNLOAD(${CMAKE_DL} ${DKDOWNLOAD})
	WIN_HOST_COMMAND(${DKDOWNLOAD}/${CMAKE_NAME}-windows-i386.msi)
	MAC_HOST_COMMAND(brew install cmake)
	LINUX_HOST_COMMAND(sudo apt-get -y install cmake)
else()
	DKINFO("Found cmake at ${CMAKE_EXE}")
endif()

if(NOT EXISTS "${CMAKE_EXE}")
	DKERROR("CMAKE IS NOT FOUND OR INVALID")
endif()








