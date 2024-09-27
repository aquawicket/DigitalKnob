#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://cmake.org
# https://github.com/Kitware/CMake
# https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi
# https://developer.android.com/studio/projects/configure-cmake
# https://discourse.cmake.org/t/cmake-silent-install-with-options-help/1475/2
# https://askubuntu.com/questions/355565/how-do-i-install-the-latest-version-of-cmake-from-the-command-line 	# How to get latest version on ubuntu
# https://github.com/Kitware/CMake/releases


### BINARY DISTRIBUTIONS (PORTABLE) ###
dk_validate(HOST_TRIPLE "dk_HOST_TRIPLE()")
ANDROID_HOST_dk_set			(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-linux-aarch64.tar.gz)
LINUX_ARM64_HOST_dk_set		(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-linux-aarch64.tar.gz)
LINUX_X86_64_HOST_dk_set	(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-linux-x86_64.tar.gz)
#MAC_HOST_dk_set			(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-macos10.10-universal.tar.gz)	# macOS 10.10 or later
MAC_HOST_dk_set				(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-macos-universal.tar.gz)		# macOS 10.13 or later
WIN_ARM64_HOST_dk_set		(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-arm64.zip)
WIN_X86_HOST_dk_set			(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-i386.zip)
WIN_X86_64_HOST_dk_set		(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-x86_64.zip)

## Get CMAKE_DL_FILE, CMAKE_FOLDER
dk_importVariables(${CMAKE_DL} rtn_var)



dk_validate(TRIPLE "dk_TARGET_TRIPLE()")

### IMPORT ###
if(ANDROID_HOST)
	dk_command(pkg install cmake -y)
	dk_findProgram(CMAKE_EXE cmake)
elseif(WIN_HOST)
	if(CLANG OR MINGW OR UCRT)
		dk_depend(msys2)
		dk_toLower(${MSYSTEM} msystem)
		if(MSYSTEM STREQUAL "MSYS")
			dk_set(msystem clang64)		
		endif()
		dk_findProgram(CMAKE_EXE cmake ${MSYS2_DIR}/${msystem}/bin)
		
		if(NOT EXISTS ${CMAKE_EXE})
			dk_delete(${MSYS2_DIR}/var/lib/pacman/db.lck NO_HALT)
			if(win_x86_clang)
				dk_command(${PACMAN_EXE} -S mingw-w64-clang-i686-cmake --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# CLANG32
			elseif(win_x86_64_clang)
				dk_command(${PACMAN_EXE} -S mingw-w64-clang-x86_64-cmake --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# CLANG64
			elseif(win_arm64_clang)
				dk_command(${PACMAN_EXE} -S mingw-w64-clang-aarch64-cmake --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})	# CLANGARM64
			elseif(win_x86_mingw)
				dk_command(${PACMAN_EXE} -S mingw-w64-i686-cmake --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})				# MINGW32
			elseif(win_x86_64_mingw)
				dk_command(${PACMAN_EXE} -S mingw-w64-x86_64-cmake --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# MINGW64
			elseif(win_x86_64_ucrt)
				dk_command(${PACMAN_EXE} -S mingw-w64-ucrt-x86_64-cmake --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# UCRT64
			#elseif(MSYS)
			#	dk_command(${PACMAN_EXE} -S cmake --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})							# MSYS2_DIR
			endif()
			
			dk_findProgram(CMAKE_EXE cmake ${MSYS2_DIR}/${msystem}/bin)
		endif()
	else()
		dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
		dk_set(CMAKE_DIR "${DKTOOLS_DIR}/${CMAKE_FOLDER}")
		dk_findProgram(CMAKE_EXE cmake ${CMAKE_DIR})
	endif()
else()
	dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")

	if(MAC_HOST)
		dk_info("searching for cmake in ${CMAKE_DIR}/CMake.app/Contents/bin")
		dk_import(${CMAKE_DL} PATH ${DKTOOLS_DIR}/${CMAKE_FOLDER})
		dk_findProgram(CMAKE_EXE cmake ${CMAKE_DIR}/CMake.app/Contents/bin)
	else()
		dk_set(CMAKE_DIR "${DKTOOLS_DIR}/${CMAKE_FOLDER}")
		dk_findProgram(CMAKE_EXE cmake ${CMAKE_DIR})
		
		if(NOT EXISTS ${CMAKE_EXE})
			dk_import(${CMAKE_DL} PATH ${CMAKE_DIR})
			dk_findProgram(CMAKE_EXE cmake ${CMAKE_DIR})
		endif()
	endif()
endif()


### VALIDATE ### (second check)
if(NOT CMAKE_EXE)
	dk_fatal("COULD NOT FIND CMAKE_EXE")
	dk_set(CMAKE_EXE ${CMAKE_COMMAND})
	return()
endif()



dk_command(${CMAKE_EXE} --version OUTPUT_VARIABLE CMAKE_VERSION)
string(STRIP ${CMAKE_VERSION} CMAKE_VERSION)
dk_set(CMAKE_VERSION ${CMAKE_VERSION})

return()































### COMPILE CMAKE ###
#set(COMPILE_CMAKE 1)
if(COMPILE_CMAKE)
	if(NOT CMAKE_EXE)
		dk_set(CMAKE_EXE ${CMAKE_COMMAND})
	else()
		dk_import(https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3.tar.gz)
		if(ANDROID_HOST)
			dk_download(https://raw.githubusercontent.com/libarchive/libarchive/master/contrib/android/include/android_lf.h ${CMAKE}/Utilities/cmlibarchive/libarchive)
		endif()
		
		dk_include				(${CMAKE}									CMAKE_INCLUDE_DIR)
		dk_include				(${CMAKE}/${triple})
		DEBUG_dk_include		(${CMAKE}/${triple}/${DEBUG_DIR})
		RELEASE_dk_include		(${CMAKE}/${triple}/${RELEASE_DIR})

		dk_libDebug		(${CMAKE}/${triple}/${DEBUG_DIR}/libcmake.a				CMAKE_LIBRARY_DEBUG)
		dk_libRelease	(${CMAKE}/${triple}/${RELEASE_DIR}/libcmake.a			CMAKE_LIBRARY_RELEASE)
		
		# Remove some flags for some builds
		string(REPLACE "--DDEBUG" 	""	DKCMAKE_BUILD "${DKCMAKE_BUILD}")
		string(REPLACE "  "			" " DKCMAKE_BUILD "${DKCMAKE_BUILD}")
		dk_configure(${CMAKE_DIR} 
			-DCMake_INSTALL_COMPONENTS=OFF 			# "Using components when installing" OFF
			-DCMake_INSTALL_DEPENDENCIES=OFF		# "Whether to install 3rd-party runtime dependencies" OFF
			-DCMake_BUILD_DEVELOPER_REFERENCE=OFF	# "Build CMake Developer Reference" OFF
			-DCMake_BUILD_LTO=OFF 					# "Compile CMake with link-time optimization" OFF
			-DCMake_BUILD_PCH=OFF 					# "Compile CMake with precompiled headers" OFF
			#-DCMAKE_USE_SYSTEM_LIBARCHIVE 			# "Use system-installed libarchive" "${CMAKE_USE_SYSTEM_LIBRARY_LIBARCHIVE}"
			#-DCMAKE_USE_SYSTEM_CPPDAP 				# "Use system-installed cppdap" "${CMAKE_USE_SYSTEM_LIBRARY_CPPDAP}"
			#-DCMAKE_USE_SYSTEM_CURL 				# "Use system-installed curl" "${CMAKE_USE_SYSTEM_LIBRARY_CURL}"
			#-DCMAKE_USE_SYSTEM_EXPAT 				# "Use system-installed expat" "${CMAKE_USE_SYSTEM_LIBRARY_EXPAT}"
			#-DCMAKE_USE_SYSTEM_FORM 				# "Use system-installed libform" "${CMAKE_USE_SYSTEM_LIBRARY_FORM}"
			#-DCMAKE_USE_SYSTEM_LIBRHASH 			# "Use system-installed librhash" "${CMAKE_USE_SYSTEM_LIBRARY_LIBRHASH}"
			#-DCMAKE_USE_SYSTEM_LIBUV 				# "Use system-installed libuv" "${CMAKE_USE_SYSTEM_LIBRARY_LIBUV}"
			#-DCMAKE_USE_SYSTEM_KWIML 				# "Use system-installed KWIML" OFF
			#-DCMAKE_USE_FOLDERS 					# "Enable folder grouping of projects in IDEs." ON
			#-DCMake_RUN_CLANG_TIDY 				# "Run clang-tidy with the compiler." OFF
			#-DCMake_USE_CLANG_TIDY_MODULE 			# "Use CMake's clang-tidy module." OFF
			#-DCMake_RUN_IWYU 						# "Run include-what-you-use with the compiler." OFF
			#-DCMake_IWYU_VERBOSE 					# "Run include-what-you-use in verbose mode" OFF
		)
			 
		dk_build(${CMAKE})
		
		return()
	endif()
endif()
	
	

### OR ###	


	
### INSTALL PREBUILT CMAKE ###
if(MSYSTEM)
	dk_depend(msys2)
	dk_assert(MSYS2_DIR)
	
	dk_command(bash -c "command -v cmake" OUTPUT_VARIABLE CMAKE_EXE)
	#dk_findProgram(CMAKE_EXE cmake)
	if(CMAKE_EXE)
		dk_command(${CYGPATH_EXE} -m ${CMAKE_EXE} OUTPUT_VARIABLE CMAKE_EXE)
	endif()
	
	if(NOT EXISTS ${CMAKE_EXE})
		dk_delete(${MSYS2_DIR}/var/lib/pacman/db.lck NO_HALT)
		if(win_x86_clang)
			dk_command(${PACMAN_EXE} -S mingw-w64-clang-i686-cmake --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# CLANG32
			#dk_set(CMAKE_EXE ${MSYS2_DIR}/clang32/bin/cmake.exe)
		elseif(win_x86_64_clang)
			dk_command(${PACMAN_EXE} -S mingw-w64-clang-x86_64-cmake --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})	# CLANG64
			#dk_set(CMAKE_EXE ${MSYS2_DIR}/clang64/bin/cmake.exe)
		elseif(win_arm64_clang)
			dk_command(${PACMAN_EXE} -S mingw-w64-clang-aarch64-cmake --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})	# CLANGARM64
			#dk_set(CMAKE_EXE ${MSYS2_DIR}/clangarm64/bin/cmake.exe)
		elseif(win_x86_mingw)
			dk_command(${PACMAN_EXE} -S mingw-w64-i686-cmake --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# MINGW32
			#dk_set(CMAKE_EXE ${MSYS2_DIR}/mingw32/bin/cmake.exe)
		elseif(win_x86_64_mingw)
			dk_command(${PACMAN_EXE} -S mingw-w64-x86_64-cmake --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# MINGW64
			#dk_set(CMAKE_EXE ${MSYS2_DIR}/mingw64/bin/cmake.exe)
		elseif(win_x86_64_ucrt)
			dk_command(${PACMAN_EXE} -S mingw-w64-ucrt-x86_64-cmake --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# UCRT64
			#dk_set(CMAKE_EXE ${MSYS2_DIR}/ucrt64/bin/cmake.exe)
		endif()
	endif()
	
	dk_command(bash -c "command -v cmake" OUTPUT_VARIABLE CMAKE_EXE)
	#dk_findProgram(CMAKE_EXE cmake)
	if(CMAKE_EXE)
		dk_command(cygpath -m ${CMAKE_EXE} OUTPUT_VARIABLE CMAKE_EXE)
	endif()
	
elseif(ANDROID_HOST)
	dk_command(pkg install cmake -y)
else()
	if(WIN_HOST)
		if(NOT CMAKE_EXE)
			dk_set(CMAKE_EXE ${CMAKE_COMMAND})
		else()
			dk_set(CMAKE_EXE ${DKTOOLS_DIR}/${CMAKE_FOLDER}/bin/cmake.exe)
			if(NOT EXISTS ${CMAKE_EXE})
				### INSTALL ###
				dk_info("Installing CMake . . .")
				dk_download(${CMAKE_DL} ${DKDOWNLOAD_DIR})			
				dk_getNativePath("${DKDOWNLOAD_DIR}/${CMAKE_DL_FILE}" CMAKE_INSTALL_FILE)
				dk_getNativePath("${DKTOOLS_DIR}/${CMAKE_FOLDER}" CMAKE_INSTALL_PATH)
				dk_command(MsiExec.exe /i "${CMAKE_INSTALL_FILE}" INSTALL_ROOT=${CMAKE_INSTALL_PATH})
			endif()
		endif()
	else()
		dk_findProgram(CMAKE_EXE cmake)
		if(NOT EXISTS ${CMAKE_EXE})
			if(MAC_HOST)
				dk_command(brew install cmake)
			elseif(ANDROID_HOST)
				dk_command(apt -y install cmake)
			elseif(LINUX_HOST)
				dk_depend(sudo)
				dk_command(${SUDO} apt-get -y install cmake)
				#dk_installPackage(cmake)
			endif()
			dk_findProgram(CMAKE_EXE cmake)
		endif()
	endif()
endif()




#if(NOT EXISTS ${CMAKE_COMMAND})
#	dk_fatal("CMAKE_COMMAND:${CMAKE_COMMAND} does not exist")
#endif()
#if(NOT CMAKE_EXE)
#	dk_notice("CMAKE_EXE:${CMAKE_EXE} is empty. setting to ${CMAKE_COMMAND}")
#	set(CMAKE_EXE "${CMAKE_COMMAND}" CACHE INTERNAL "" FORCE)
#endif()
#
#if(NOT EXISTS ${CMAKE_EXE})
#	dk_fatal("CMAKE_EXE:${CMAKE_EXE} does not exist")
#endif()
#
#dk_set(CMAKE_EXE ${CMAKE_EXE}) # make the variable persistent


