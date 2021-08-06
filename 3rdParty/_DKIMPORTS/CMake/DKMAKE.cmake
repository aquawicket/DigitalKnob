# https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi

### VERSION ###
DKSET(CMAKE_VERSION 3.21.1)
DKSET(CMAKE_NAME cmake-${CMAKE_VERSION}-windows-i386)
WIN_DKSET(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/${CMAKE_NAME}.msi)
WIN_DKSET(CMAKE "C:/Program Files (x86)/CMake")
WIN_DKSET(CMAKE_EXE ${CMAKE}/bin/cmake.exe)


### INSTALL ###
if(NOT EXISTS ${CMAKE_EXE})
	WIN32_PATH(${DIGITALKNOB}/Download) ### FIXME - WIN32_COMMAND does not use CMAKE_HOST_WIN32
	DKDOWNLOAD(${CMAKE_DL})
	DKSET(QUEUE_BUILD ON)
	WIN32_COMMAND(${DIGITALKNOB}/Download/${CMAKE_NAME}.msi) ## FIXME - WIN32_COMMAND does not use CMAKE_HOST_WIN32
endif()











