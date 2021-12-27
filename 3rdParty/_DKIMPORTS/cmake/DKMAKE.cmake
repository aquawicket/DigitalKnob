# https://cmake.org
# https://github.com/Kitware/CMake
#
# https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi
# https://developer.android.com/studio/projects/configure-cmake

MAC_DKDEPEND(homebrew)


### VERSION ###
WIN_HOST_DKSET(CMAKE_VERSION 3.21.1)
WIN_HOST_DKSET(CMAKE_NAME cmake-${CMAKE_VERSION}-windows-i386)
WIN_HOST_DKSET(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/${CMAKE_NAME}.msi)
#dk_getShortPath("C:\Program Files (x86)\CMake" CMAKE)

WIN_HOST_DKSET(CMAKE "C:/Program Files (x86)/CMake/bin")
#WIN_HOST_DKSET(CMAKE C:/PROGRA~2/CMake/bin)
MAC_HOST_DKSET(CMAKE /usr/local/bin)
LINUX_HOST_DKSET(CMAKE /usr/bin)

WIN_HOST_DKSET(CMAKE_EXE "\"${CMAKE}/cmake.exe\"")
UNIX_HOST_DKSET(CMAKE_EXE ${CMAKE}/cmake)


### INSTALL ###
DKINFO("looking for cmake at ${CMAKE_EXE}")
if(NOT EXISTS "${CMAKE_EXE}")
	DKINFO("cmake NOT FOUND")
	DKINFO("Installing ${CMAKE_NAME}")
	WIN_HOST_DOWNLOAD(${CMAKE_DL} ${DKDOWNLOAD})
	WIN_HOST_DKCOMMAND(${DKDOWNLOAD}/${CMAKE_NAME}.msi)
	MAC_HOST_DKCOMMAND(brew install cmake)
	LINUX_HOST_DKCOMMAND(sudo apt-get -y install cmake)
else()
	DKINFO("Found cmake at ${CMAKE_EXE}")
	DKEXECUTE_PROCESS(${CMAKE_EXE} --version version.txt)
endif()

if(NOT EXISTS "${CMAKE_EXE}")
	DKERROR("CMAKE IS NOT FOUND OR INVALID")
endif()
