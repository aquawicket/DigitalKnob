# https://cmake.org
# https://github.com/Kitware/CMake
# https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi
# https://developer.android.com/studio/projects/configure-cmake
# https://discourse.cmake.org/t/cmake-silent-install-with-options-help/1475/2
if(CMAKE)
	return()
endif()

### DOWNLOAD ###
WIN_HOST_dk_set(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi)
WIN_HOST_dk_set(CMAKE_FILE cmake-3.21.1-windows-i386.msi)


if(MSYSTEM)
	dk_depend(msys2)
	
	dk_remove(${MSYS2}/var/lib/pacman/db.lck NOERROR)
	
	if(CLANG32)
		dk_command("pacman -S mingw-w64-clang-i686-cmake --needed --noconfirm")		# CLANG32
	elseif(CLANG64)
		dk_command("pacman -S mingw-w64-clang-x86_64-cmake --needed --noconfirm")	# CLANG64
	elseif(CLANGARM64)
		dk_command("pacman -S mingw-w64-clang-aarch64-cmake --needed --noconfirm")	# CLANGARM64
	elseif(MINGW32)
		dk_command("pacman -S mingw-w64-i686-cmake --needed --noconfirm")			# MINGW32
	elseif(MINGW64)
		dk_command("pacman -S mingw-w64-x86_64-cmake --needed --noconfirm")			# MINGW64
	elseif(UCRT64)
		dk_command("pacman -S mingw-w64-ucrt-x86_64-cmake --needed --noconfirm")	# UCRT64
	endif()
	
	dk_set(CMAKE_EXE cmake)
	dk_debug("CMAKE_EXE = ${CMAKE_EXE}")
	dk_command(${CMAKE_EXE} --version)
	
	return()
endif()


if(EXISTS /usr/bin/cmake)
	dk_set(CMAKE /usr/bin)
	dk_set(CMAKE_EXE /usr/bin/cmake)
elseif(EXISTS ${MSYS2}/mingw64/bin/cmake.exe)
	dk_set(CMAKE ${MSYS2}/mingw64/bin)
	dk_set(CMAKE_EXE ${MSYS2}/mingw64/bin/cmake.exe)
elseif(EXISTS ${MSYS2}/ucrt64/bin/cmake.exe)
	dk_set(CMAKE ${MSYS2}/ucrt64/bin)
	dk_set(CMAKE_EXE ${MSYS2}/ucrt64/bin/cmake.exe)
elseif(EXISTS /usr/local/bin/cmake)
	dk_set(CMAKE /usr/local/bin)
	dk_set(CMAKE_EXE /usr/local/bin/cmake)
elseif(EXISTS /data/data/com.termux/files/usr/bin/cmake)
	dk_set(CMAKE /data/data/com.termux/files/usr/bin)
	dk_set(CMAKE_EXE /data/data/com.termux/files/usr/bin/cmake)
elseif(EXISTS /mingw64/bin/cmake)
	dk_set(CMAKE /mingw64/bin)
	dk_set(CMAKE_EXE /mingw64/bin/cmake)
elseif(EXISTS "C:/Progra~1/CMake/bin/cmake.exe")
	dk_set(CMAKE "C:/Progra~1/CMake/bin")
	dk_set(CMAKE_EXE "C:/Progra~1/CMake/bin/cmake.exe")
elseif(EXISTS "C:/Progra~2/CMake/bin/cmake.exe")
	dk_set(CMAKE "C:/Progra~2/CMake/bin")
	dk_set(CMAKE_EXE "C:/Progra~2/CMake/bin/cmake.exe")
elseif(EXISTS "${ProgramFiles}/CMake/bin/cmake.exe")
	dk_set(CMAKE "${ProgramFiles}/CMake/bin")
	dk_set(CMAKE_EXE "${ProgramFiles}/CMake/bin/cmake.exe")
elseif(EXISTS "${ProgramFiles_x86}/CMake/bin/cmake.exe")
	dk_set(CMAKE "${ProgramFiles_x86}/CMake/bin")
	dk_set(CMAKE_EXE "${ProgramFiles_x86}/CMake/bin/cmake.exe")
else()
	### INSTALL ###
	dk_info("Installing CMake . . .")
	if(MSVC)
		WIN_HOST_dk_download(${CMAKE_DL} ${DKDOWNLOAD})
		WIN_HOST_dk_command(${DKDOWNLOAD}/${CMAKE_FILE})
	endif()
	MAC_HOST_dk_command(brew install cmake)
	if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Android")
		dk_set(APT "apt")
	else()
		dk_set(APT "apt-get")
	endif()
	LINUX_HOST_dk_command(sudo ${APT} -y install cmake)
endif()

if(EXISTS /usr/bin/cmake)
	dk_set(CMAKE /usr/bin)
	dk_set(CMAKE_EXE /usr/bin/cmake)
elseif(MSYS)
	dk_set(CMAKE ${MSYS2}/mingw64/bin)
	dk_set(CMAKE_EXE ${MSYS2}/mingw64/bin/cmake.exe)
elseif(EXISTS ${MSYS2}/ucrt64/bin/cmake.exe)
	dk_set(CMAKE ${MSYS2}/ucrt64/bin)
	dk_set(CMAKE_EXE ${MSYS2}/ucrt64/bin/cmake.exe)
elseif(EXISTS /usr/local/bin/cmake)
	dk_set(CMAKE /usr/local/bin)
	dk_set(CMAKE_EXE /usr/local/bin/cmake)
elseif(EXISTS /data/data/com.termux/files/usr/bin/cmake)
	dk_set(CMAKE /data/data/com.termux/files/usr/bin)
	dk_set(CMAKE_EXE /data/data/com.termux/files/usr/bin/cmake)
elseif(EXISTS /mingw64/bin/cmake)
	dk_set(CMAKE /mingw64/bin)
	dk_set(CMAKE_EXE /mingw64/bin/cmake)
elseif(EXISTS "C:/Progra~1/CMake/bin/cmake.exe")
	dk_set(CMAKE "C:/Progra~1/CMake/bin")
	dk_set(CMAKE_EXE "C:/Progra~1/CMake/bin/cmake.exe")
elseif(EXISTS "C:/Progra~2/CMake/bin/cmake.exe")
	dk_set(CMAKE "C:/Progra~2/CMake/bin")
	dk_set(CMAKE_EXE "C:/Progra~2/CMake/bin/cmake.exe")
elseif(EXISTS "${ProgramFiles}/CMake/bin/cmake.exe")
	dk_set(CMAKE "${ProgramFiles}/CMake/bin")
	dk_set(CMAKE_EXE "${ProgramFiles}/CMake/bin/cmake.exe")
elseif(EXISTS "${ProgramFiles_x86}/CMake/bin/cmake.exe")
	dk_set(CMAKE "${ProgramFiles_x86}/CMake/bin")
	dk_set(CMAKE_EXE "${ProgramFiles_x86}/CMake/bin/cmake.exe")
else()
	dk_error("CMAKE NOT FOUND!")
endif()


dk_debug("CMAKE_EXE = ${CMAKE_EXE}")
#dk_command(${CMAKE_EXE} --version)	#FIXME: fails in msys2
