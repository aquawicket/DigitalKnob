# https://cmake.org
# https://github.com/Kitware/CMake
#
# https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi
# https://developer.android.com/studio/projects/configure-cmake

set(COMPILE_CMAKE 0)

if(COMPILE_CMAKE)
	################################################################################################################
	#dk_depend(msys)	# migrated to msys2
	#dk_depend(msys2)
	dk_depend(openssl)
	dk_import(https://github.com/Kitware/CMake.git)
	#WIN_HOST_dk_set(CMAKE_VERSION 3a169af9524339e8b2e82130da7605040daf7925)
	#dk_import(https://github.com/Kitware/CMake/archive/3a169af9524339e8b2e82130da7605040daf7925.zip)

	#dk_set(QUEUE_BUILD ON)
	#dk_shell(pacman -S --needed git base-devel mingw-w64-x86_64-gcc)
	
	### GENERATE ###
	dk_command(${DKCMAKE_BUILD} -DCMAKE_USE_OPENSSL=OFF ${CMAKE}) # ${OPENSSL_CMAKE}

	### COMPILE ###
	dk_set(QUEUE_BUILD ON)
	dk_build(${CMAKE})

	### GENERATE / COMPILE ###
	#DEBUG_dk_setPath	(${CMAKE}/${OS}/${DEBUG_DIR})
	#DEBUG_dk_shell		(../../configure)
	#DEBUG_dk_shell		(make)
	#RELEASE_dk_setPath	(${CMAKE}/${OS}/${RELEASE_DIR})
	#RELEASE_dk_shell	(../../configure)
	#RELEASE_dk_shell	(make)

else()
	###############################################################################################################
	WIN_HOST_dk_set(CMAKE_VERSION 3.21.1)
	WIN_HOST_dk_set(CMAKE_NAME cmake-${CMAKE_VERSION}-windows-i386)
	WIN_HOST_dk_set(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/${CMAKE_NAME}.msi)
	if(EXISTS ${CMAKE_COMMAND})
		dk_set(CMAKE_EXE "${CMAKE_COMMAND}")
		get_filename_component(CMAKE "${CMAKE_EXE}" DIRECTORY)
		dk_return()
	elseif(EXISTS "C:/Progra~2/CMake/bin")
		WIN_HOST_dk_set(CMAKE "C:/Progra~2/CMake/bin")
		#dk_getShortPath(${CMAKE} CMAKE)	
	elseif(EXISTS "C:/Program Files (x86)/CMake/bin")
		WIN_HOST_dk_set(CMAKE "C:/Program Files (x86)/CMake/bin")
		#dk_getShortPath(${CMAKE} CMAKE)	
	elseif(EXISTS /usr/local/bin)
		MAC_HOST_dk_set(CMAKE /usr/local/bin)
		#LINUX_HOST_dk_set(CMAKE /usr/bin)
		LINUX_HOST_dk_set(CMAKE /usr/local/bin)
	endif()
	WIN_HOST_dk_set(CMAKE_EXE ${CMAKE}/cmake.exe)
	UNIX_HOST_dk_set(CMAKE_EXE ${CMAKE}/cmake)	

	### INSTALL ###
	#dk_info("looking for cmake at ${CMAKE_EXE}")
	if(NOT EXISTS "${CMAKE_EXE}")
		MAC_dk_depend(homebrew)
		dk_info("cmake NOT FOUND")
		dk_info("Installing ${CMAKE_NAME}")
		WIN_HOST_dk_download(${CMAKE_DL} ${DKDOWNLOAD})
		WIN_HOST_dk_command(${DKDOWNLOAD}/${CMAKE_NAME}.msi)
		MAC_HOST_dk_command(brew install cmake)
		LINUX_HOST_dk_command(sudo apt-get -y install cmake)
	else()
		#dk_info("Found cmake at ${CMAKE_EXE}")
		#dk_executeProcess(${CMAKE_EXE} --version ${CMAKE}/version.txt)
	endif()

	if(NOT EXISTS "${CMAKE_EXE}")
		dk_assert("CMAKE IS NOT FOUND OR INVALID")
	endif()
endif()
