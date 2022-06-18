# https://cmake.org
# https://github.com/Kitware/CMake
#
# https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi
# https://developer.android.com/studio/projects/configure-cmake

set(COMPILE_CMAKE 0)

if(COMPILE_CMAKE)
	################################################################################################################
	DKDEPEND(msys2)
	#DKIMPORT(https://github.com/Kitware/CMake)
	
	DKIMPORT(https://github.com/Kitware/CMake.git)
	#WIN_HOST_DKSET(CMAKE_VERSION 3a169af9524339e8b2e82130da7605040daf7925)
	#DKIMPORT(https://github.com/Kitware/CMake/archive/3a169af9524339e8b2e82130da7605040daf7925.zip)

	DKSET(QUEUE_BUILD ON)
	MSYS(pacman -S --needed git base-devel mingw-w64-x86_64-gcc)
	
else()
	###############################################################################################################
	WIN_HOST_DKSET(CMAKE_VERSION 3.21.1)
	WIN_HOST_DKSET(CMAKE_NAME cmake-${CMAKE_VERSION}-windows-i386)
	WIN_HOST_DKSET(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/${CMAKE_NAME}.msi)
	if(EXISTS CMAKE_COMMAND)
		DKSET(CMAKE_EXE "${CMAKE_COMMAND}")
		get_filename_component(CMAKE "${CMAKE_EXE}" DIRECTORY)
	elseif(EXISTS "C:/Progra~2/CMake/bin")
		WIN_HOST_DKSET(CMAKE "C:/Progra~2/CMake/bin")
		#dk_getShortPath(${CMAKE} CMAKE)	
	elseif(EXISTS "C:/Program Files (x86)/CMake/bin")
		WIN_HOST_DKSET(CMAKE "C:/Program Files (x86)/CMake/bin")
		#dk_getShortPath(${CMAKE} CMAKE)	
	elseif(EXISTS /usr/local/bin)
		MAC_HOST_DKSET(CMAKE /usr/local/bin)
		LINUX_HOST_DKSET(CMAKE /usr/bin)
	endif()
	WIN_HOST_DKSET(CMAKE_EXE ${CMAKE}/cmake.exe)
	UNIX_HOST_DKSET(CMAKE_EXE ${CMAKE}/cmake)	

	### INSTALL ###
	DKINFO("looking for cmake at ${CMAKE_EXE}")
	if(NOT EXISTS "${CMAKE_EXE}")
		MAC_DKDEPEND(homebrew)
		DKINFO("cmake NOT FOUND")
		DKINFO("Installing ${CMAKE_NAME}")
		WIN_HOST_dk_download(${CMAKE_DL} ${DKDOWNLOAD})
		WIN_HOST_DKCOMMAND(${DKDOWNLOAD}/${CMAKE_NAME}.msi)
		MAC_HOST_DKCOMMAND(brew install cmake)
		LINUX_HOST_DKCOMMAND(sudo apt-get -y install cmake)
	else()
		DKINFO("Found cmake at ${CMAKE_EXE}")
		#dk_executeProcess(${CMAKE_EXE} --version ${CMAKE}/version.txt)
	endif()

	if(NOT EXISTS "${CMAKE_EXE}")
		DKERROR("CMAKE IS NOT FOUND OR INVALID")
	endif()
endif()