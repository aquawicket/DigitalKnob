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
if(EXISTS CMAKE_COMMAND)
	DKSET(CMAKE_EXE ${CMAKE_COMMAND})
	get_filename_component(CMAKE ${CMAKE_EXE} DIRECTORY)
else()
	# PARSED FROM EXTERNAL APPS (when not in cmake) 
	#WIN_HOST_DKSET(CMAKE "C:/Program Files (x86)/CMake/bin")
	WIN_HOST_DKSET(CMAKE "C:/Progra~2/CMake/bin")
	#WIN_GetShortPath(${CMAKE} CMAKE)
	MAC_HOST_DKSET(CMAKE /usr/local/bin)
	LINUX_HOST_DKSET(CMAKE /usr/bin)
	WIN_HOST_DKSET(CMAKE_EXE ${CMAKE}/cmake.exe)
	UNIX_HOST_DKSET(CMAKE_EXE ${CMAKE}/cmake)
endif()



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
	#DKEXECUTE_PROCESS(${CMAKE_EXE} --version ${CMAKE}/version.txt)
endif()

if(NOT EXISTS "${CMAKE_EXE}")
	DKERROR("CMAKE IS NOT FOUND OR INVALID")
endif()
