# https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi

### VERSION ###
DKSET(CMAKE_VERSION 3.21.1)
DKSET(CMAKE_NAME cmake-${CMAKE_VERSION}-windows-i386)
WIN_DKSET(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/${CMAKE_NAME}.msi)
WIN_DKSET(CMAKE "C:/Program Files (x86)/CMake")
WIN_DKSET(CMAKE_EXE ${CMAKE}/bin/cmake.exe)
LINUX_DKSET(CMAKE_EXE cmake)
MAC_DKSET(CMAKE_EXE cmake)


### INSTALL ###
if(CMAKE_HOST_WIN32)
	if(NOT EXISTS ${CMAKE_EXE})
		DKDOWNLOAD(${CMAKE_DL} ${DIGITALKNOB}/Download)
		DKCOMMAND(${DIGITALKNOB}/Download/${CMAKE_NAME}.msi)
	endif()
endif()

if(CMAKE_HOST_MAC)
	if(NOT EXISTS ${CMAKE_EXE})
		message(FATAL_ERROR "${CMAKE} not found")
	endif()
endif()

if(CMAKE_HOST_LINUX)
	if(NOT EXISTS ${CMAKE_EXE})
		message(FATAL_ERROR "${CMAKE} not found")
	endif()
endif()











