# https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi
if(MAC)
	DKDEPEND(homebrew)
endif()


### VERSION ###
DKSET(CMAKE_VERSION 3.21.1)
DKSET(CMAKE_NAME cmake-${CMAKE_VERSION}-windows-i386)
WIN_DKSET(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/${CMAKE_NAME}.msi)
#WIN_DKSET(CMAKE "C:/Program Files (x86)/CMake/bin")
dk_getShortPath("C:/Program Files (x86)/CMake/bin" CMAKE)
MAC_DKSET(CMAKE /usr/local/bin)
LINUX_DKSET(CMAKE /usr/bin) 

WIN_DKSET(CMAKE_EXE ${CMAKE}/cmake.exe)
#MAC_DKSET(CMAKE_EXE cmake)
MAC_DKSET(CMAKE_EXE ${CMAKE}/cmake)
LINUX_DKSET(CMAKE_EXE ${CMAKE}/cmake)


### INSTALL ###
if(NOT EXISTS ${CMAKE_EXE})
	if(CMAKE_HOST_WIN32)
		DOWNLOAD(${CMAKE_DL} ${DIGITALKNOB}/Download)
		DKCOMMAND(${DIGITALKNOB}/Download/${CMAKE_NAME}.msi)
	endif()
	if(CMAKE_HOST_MAC)
		DKCOMMAND("brew install cmake")
	endif()
	if(CMAKE_HOST_LINUX)
		message(FATAL_ERROR "${CMAKE} not found")
		# TODO
	endif()
endif()











