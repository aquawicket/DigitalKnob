# https://cmake.org
# https://github.com/Kitware/CMake
# https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi
# https://developer.android.com/studio/projects/configure-cmake
# https://discourse.cmake.org/t/cmake-silent-install-with-options-help/1475/2
# https://askubuntu.com/questions/355565/how-do-i-install-the-latest-version-of-cmake-from-the-command-line 	# How to get latest version on ubuntu


### DOWNLOAD ###
# https://github.com/Kitware/CMake/releases
#LINUX_ARM64_HOST_dk_set	(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3-linux-aarch64.tar.gz)
LINUX_X86_64_HOST_dk_set	(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3-linux-x86_64.tar.gz)
MAC_HOST_dk_set				(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3-macos-universal.dmg)
#WIN_ARM64_HOST_dk_set		(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3-windows-arm64.msi)
WIN_X86_HOST_dk_set			(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3-windows-i386.msi)
WIN_X86_64_HOST_dk_set		(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3-windows-x86_64.msi)

get_filename_component(CMAKE_DL_FILE ${CMAKE_DL} NAME)
dk_removeExtension(${CMAKE_DL_FILE} CMAKE_FOLDER)


if(MSYSTEM)
	dk_depend(msys2)
	
	dk_remove(${MSYS2}/var/lib/pacman/db.lck NOERROR)
	
	if(CLANG32)
		dk_command("pacman -S mingw-w64-clang-i686-cmake --needed --noconfirm")		# CLANG32
		dk_set(CMAKE ${MSYS2}/clang32/share/cmake)
		dk_set(CMAKE_EXE ${MSYS2}/clang32/bin/cmake)
		dk_set(CMAKE_MODULES ${MSYS2}/clang32/share/cmake/Modules)
	elseif(CLANG64)
		dk_command("pacman -S mingw-w64-clang-x86_64-cmake --needed --noconfirm")	# CLANG64
		dk_set(CMAKE ${MSYS2}/clang64/share/cmake)
		dk_set(CMAKE_EXE ${MSYS2}/clang64/bin/cmake)
		dk_set(CMAKE_MODULES ${MSYS2}/clang64/share/cmake/Modules)
	elseif(CLANGARM64)
		dk_command("pacman -S mingw-w64-clang-aarch64-cmake --needed --noconfirm")	# CLANGARM64
		dk_set(CMAKE ${MSYS2}/clangarm64/share/cmake)
		dk_set(CMAKE_EXE ${MSYS2}/clangarm64/bin/cmake)
		dk_set(CMAKE_MODULES ${MSYS2}/clangarm64/share/cmake/Modules)
	elseif(MINGW32)
		dk_command("pacman -S mingw-w64-i686-cmake --needed --noconfirm")			# MINGW32
		dk_set(CMAKE ${MSYS2}/mingw32/share/cmake)
		dk_set(CMAKE_EXE ${MSYS2}/mingw32/bin/cmake)
		dk_set(CMAKE_MODULES ${MSYS2}/mingw32/share/cmake/Modules)
	elseif(MINGW64)
		dk_command("pacman -S mingw-w64-x86_64-cmake --needed --noconfirm")			# MINGW64
		dk_set(CMAKE ${MSYS2}/mingw64/share/cmake)
		dk_set(CMAKE_EXE ${MSYS2}/mingw64/bin/cmake)
		dk_set(CMAKE_MODULES ${MSYS2}/mingw64/share/cmake/Modules)
	elseif(UCRT64)
		dk_command("pacman -S mingw-w64-ucrt-x86_64-cmake --needed --noconfirm")	# UCRT64
		dk_set(CMAKE ${MSYS2}/ucrt64/share/cmake)
		dk_set(CMAKE_EXE ${MSYS2}/ucrt64/bin/cmake)
		dk_set(CMAKE_MODULES ${MSYS2}/ucrt64/share/cmake/Modules)
	endif()
	
	#dk_set(CMAKE_EXE cmake)
	
else()
	if(WIN_HOST)
		dk_set(CMAKE_EXE ${3RDPARTY}/${CMAKE_FOLDER}/bin/cmake.exe)
		if(NOT EXISTS ${CMAKE_EXE})
			### INSTALL ###
			dk_info("Installing CMake . . .")
			dk_download(${CMAKE_DL} ${DKDOWNLOAD})
			get_filename_component(CMAKE_DL_FILE ${CMAKE_DL} NAME)
			
			file(TO_NATIVE_PATH "${DKDOWNLOAD}/${CMAKE_DL_FILE}" CMAKE_INSTALL_FILE)
			file(TO_NATIVE_PATH "${3RDPARTY}/${CMAKE_FOLDER}" CMAKE_INSTALL_PATH)
			execute_process(COMMAND cmd /c echo MsiExec.exe /i "${CMAKE_INSTALL_FILE}" INSTALL_ROOT=${CMAKE_INSTALL_PATH})
			execute_process(COMMAND cmd /c MsiExec.exe /i "${CMAKE_INSTALL_FILE}" INSTALL_ROOT=${CMAKE_INSTALL_PATH})
		endif()
		if(NOT EXISTS ${CMAKE_EXE})
			dk_error("cannot find cmake")
		endif()
	else()
		execute_process(COMMAND which cmake OUTPUT_VARIABLE CMAKE_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
		#string(STRIP ${CMAKE_EXE} CMAKE_EXE)
		if(NOT EXISTS ${CMAKE_EXE})
			dk_error("cannot find cmake")
		endif()
	endif()
	
#	if(EXISTS /usr/bin/cmake)
#		dk_set(CMAKE /usr/bin)
#		dk_set(CMAKE_EXE /usr/bin/cmake)
#	elseif(EXISTS /usr/local/bin/cmake)
#		dk_set(CMAKE /usr/local/bin)
#		dk_set(CMAKE_EXE /usr/local/bin/cmake)
#	elseif(EXISTS /data/data/com.termux/files/usr/bin/cmake)
#		dk_set(CMAKE /data/data/com.termux/files/usr/bin)
#		dk_set(CMAKE_EXE /data/data/com.termux/files/usr/bin/cmake)

#		### INSTALL ###
#		dk_info("Installing CMake . . .")
#		MAC_HOST_dk_command(brew install cmake)
#		if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Android")
#			dk_set(APT "apt")
#		else()
#			dk_set(APT "apt-get")
#		endif()
#		LINUX_HOST_dk_command(sudo ${APT} -y install cmake)
#	endif()
#
#	if(EXISTS /usr/bin/cmake)
#		dk_set(CMAKE /usr/bin)
#		dk_set(CMAKE_EXE /usr/bin/cmake)
#	elseif(EXISTS /usr/local/bin/cmake)
#		dk_set(CMAKE /usr/local/bin)
#		dk_set(CMAKE_EXE /usr/local/bin/cmake)
#	elseif(EXISTS /data/data/com.termux/files/usr/bin/cmake)
#		dk_set(CMAKE /data/data/com.termux/files/usr/bin)
#		dk_set(CMAKE_EXE /data/data/com.termux/files/usr/bin/cmake)
#	else()
#		dk_error("CMAKE NOT FOUND!")
#	endif()
endif()


###### CMake variables #######
dk_debug("CMAKE_COMMAND = ${CMAKE_COMMAND}")
dk_debug("CMAKE = ${CMAKE}")
dk_debug("CMAKE_EXE = ${CMAKE_EXE}")
dk_command(${CMAKE_EXE} --version)

