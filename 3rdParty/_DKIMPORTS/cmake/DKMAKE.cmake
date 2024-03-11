# https://cmake.org
# https://github.com/Kitware/CMake
# https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi
# https://developer.android.com/studio/projects/configure-cmake
# https://discourse.cmake.org/t/cmake-silent-install-with-options-help/1475/2
# https://askubuntu.com/questions/355565/how-do-i-install-the-latest-version-of-cmake-from-the-command-line 	# How to get latest version on ubuntu

#if(EXISTS ${CMAKE_EXE})
#	dk_debug("CMAKE_EXE already set to: ${CMAKE_EXE}")
#	return()
#endif()


### DOWNLOAD ###
# https://github.com/Kitware/CMake/releases
#ANDROID_HOST_dk_set(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3-linux-aarch64.tar.gz)
#LINUX_ARM64_HOST_dk_set	(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3-linux-aarch64.tar.gz)
LINUX_X86_64_HOST_dk_set	(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3-linux-x86_64.tar.gz)
MAC_HOST_dk_set				(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3-macos-universal.dmg)
#WIN_ARM64_HOST_dk_set		(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3-windows-arm64.msi)
WIN_X86_HOST_dk_set			(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3-windows-i386.msi)
WIN_X86_64_HOST_dk_set		(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3-windows-x86_64.msi)
if(CMAKE_DL)
	get_filename_component(CMAKE_DL_FILE ${CMAKE_DL} NAME)
	dk_removeExtension(${CMAKE_DL_FILE} CMAKE_FOLDER)
	string(MAKE_C_IDENTIFIER ${CMAKE_FOLDER} CMAKE_FOLDER)
endif()


if(MSYSTEM)
	dk_depend(msys2)
	if(NOT EXISTS ${MSYS2})
		dk_error("MSYS2:${MSYS2} does not exist")
	endif()
	
	dk_command(command -v cmake.exe OUTPUT_VARIABLE CMAKE_EXE NOASSERT)
	if(CMAKE_EXE)
		dk_command(cygpath -m ${CMAKE_EXE} OUTPUT_VARIABLE CMAKE_EXE)
	endif()
	
	if(NOT EXISTS ${CMAKE_EXE})
		dk_remove(${MSYS2}/var/lib/pacman/db.lck NOERROR)
		if(CLANG32)
			dk_command(pacman -S mingw-w64-clang-i686-cmake --needed --noconfirm)		# CLANG32
			#dk_set(CMAKE_EXE ${MSYS2}/clang32/bin/cmake.exe)
		elseif(CLANG64)
			dk_command(pacman -S mingw-w64-clang-x86_64-cmake --needed --noconfirm)		# CLANG64
			#dk_set(CMAKE_EXE ${MSYS2}/clang64/bin/cmake.exe)
		elseif(CLANGARM64)
			dk_command(pacman -S mingw-w64-clang-aarch64-cmake --needed --noconfirm)	# CLANGARM64
			#dk_set(CMAKE_EXE ${MSYS2}/clangarm64/bin/cmake.exe)
		elseif(MINGW32)
			dk_command(pacman -S mingw-w64-i686-cmake --needed --noconfirm)				# MINGW32
			#dk_set(CMAKE_EXE ${MSYS2}/mingw32/bin/cmake.exe)
		elseif(MINGW64)
			dk_command(pacman -S mingw-w64-x86_64-cmake --needed --noconfirm)			# MINGW64
			#dk_set(CMAKE_EXE ${MSYS2}/mingw64/bin/cmake.exe)
		elseif(UCRT64)
			dk_command(pacman -S mingw-w64-ucrt-x86_64-cmake --needed --noconfirm)		# UCRT64
			#dk_set(CMAKE_EXE ${MSYS2}/ucrt64/bin/cmake.exe)
		endif()
	endif()
	
	dk_command(command -v cmake.exe OUTPUT_VARIABLE CMAKE_EXE)
	if(CMAKE_EXE)
		dk_command(cygpath -m ${CMAKE_EXE} OUTPUT_VARIABLE CMAKE_EXE)
	endif()
	
else()
	if(ANDROID_HOST)
		if(NOT CMAKE_EXE)
			dk_set(CMAKE_EXE ${CMAKE_COMMAND})
		else()
			
			#dk_import(https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3.tar.gz)
			dk_import(https://github.com/Kitware/CMake/releases/download/v3.18.4/cmake-3.18.4.tar.gz)
			dk_download(https://raw.githubusercontent.com/libarchive/libarchive/master/contrib/android/include/android_lf.h ${CMAKE}/Utilities/cmlibarchive/libarchive)
			dk_debug(CMAKE PRINTVAR)
			dk_debug(CMAKE_EXE PRINTVAR)

			dk_include				(${CMAKE}									CMAKE_INCLUDE_DIR)
			dk_include				(${CMAKE}/${OS})
			DEBUG_dk_include		(${CMAKE}/${OS}/${DEBUG_DIR})
			RELEASE_dk_include		(${CMAKE}/${OS}/${RELEASE_DIR})
	
			dk_libDebug		(${CMAKE}/${OS}/${DEBUG_DIR}/libcmake.a				CMAKE_LIBRARY_DEBUG)
			dk_libRelease	(${CMAKE}/${OS}/${RELEASE_DIR}/libcmake.a			CMAKE_LIBRARY_RELEASE)

			message(STATUS "dk_queueCommand(${DKCMAKE_BUILD}	${CMAKE})")
			dk_queueCommand(${DKCMAKE_BUILD} 
					"-DCMAKE_CXX_FLAGS=-I${CMAKE}"
					#-DCMAKE_USE_SYSTEM_LIBUV=ON
					#-DCMAKE_USE_SYSTEM_LIBARCHIVE=ON
					${CMAKE})

			#dk_build(${CMAKE} cmake)
			dk_command(${CMAKE_MAKE_PROGRAM})
		endif()
	elseif(WIN_HOST)
		dk_set(CMAKE_EXE ${DKTOOLS_DIR}/${CMAKE_FOLDER}/bin/cmake.exe)
		if(NOT EXISTS ${CMAKE_EXE})
			### INSTALL ###
			dk_info("Installing CMake . . .")
			dk_download(${CMAKE_DL} ${DKDOWNLOAD_DIR})			
			file(TO_NATIVE_PATH "${DKDOWNLOAD_DIR}/${CMAKE_DL_FILE}" CMAKE_INSTALL_FILE)
			file(TO_NATIVE_PATH "${DKTOOLS_DIR}/${CMAKE_FOLDER}" CMAKE_INSTALL_PATH)
			dk_command(MsiExec.exe /i "${CMAKE_INSTALL_FILE}" INSTALL_ROOT=${CMAKE_INSTALL_PATH})
		endif()
	else()
		dk_command(sh -c "command -v cmake" OUTPUT_VARIABLE CMAKE_EXE)
		if(NOT EXISTS ${CMAKE_EXE})
			MAC_HOST_dk_command(brew install cmake)
			ANDROID_HOST_dk_command(apt -y install cmake)
			LINUX_HOST_dk_command(sudo apt-get -y install cmake)
			dk_command(sh -c "command -v cmake" OUTPUT_VARIABLE CMAKE_EXE)
		endif()
	endif()
endif()


### validate CMAKE variables ###
if(NOT CMAKE_COMMAND)
	dk_error("CMAKE_COMMAND:${CMAKE_COMMAND} is empty")
endif()
if(NOT EXISTS ${CMAKE_COMMAND})
	dk_error("CMAKE_COMMAND:${CMAKE_COMMAND} does not exist")
endif()
if(NOT CMAKE_EXE)
	dk_warn("CMAKE_EXE:${CMAKE_EXE} is empty. setting to ${CMAKE_COMMAND}")
	set(CMAKE_EXE "${CMAKE_COMMAND}" CACHE INTERNAL "" FORCE)
endif()
if(NOT CMAKE_EXE)
	dk_error("CMAKE_EXE:${CMAKE_EXE} is empty")
endif()
if(NOT EXISTS ${CMAKE_EXE})
	dk_error("CMAKE_EXE:${CMAKE_EXE} does not exist")
endif()

dk_set(CMAKE_EXE ${CMAKE_EXE}) # make the variable persistent

### print CMAKE info ###
dk_debug(CMAKE_EX	PRINTVAR)
dk_command(${CMAKE_EXE} --version OUTPUT_VARIABLE CMAKE_VERSION)
dk_debug(CMAKE_VERSION	PRINTVAR)

