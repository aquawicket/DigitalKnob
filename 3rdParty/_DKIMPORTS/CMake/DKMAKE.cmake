# https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi

### VERSION ###
DKSET(CMAKE_VERSION 3.21.1)
DKSET(CMAKE_NAME cmake-${CMAKE_VERSION}-windows-i386)
DKSET(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/${CMAKE_NAME}.msi)
DKSET(CMAKE_EXE ${CMAKE}/bin/cmake.exe)
DKSET(CMAKE "C:/Program Files (x86)/CMake")


### INSTALL ###	
if(CMAKE_HOST_WIN32)
	if(NOT EXISTS ${CMAKE_EXE})
		WIN32_PATH(${DIGITALKNOB}/Download)
		DKDOWNLOAD(${CMAKE_DL})
		DKSET(QUEUE_BUILD ON)
		WIN32_COMMAND(${DIGITALKNOB}/Download/${CMAKE_NAME}.msi)
	endif()
endif()











