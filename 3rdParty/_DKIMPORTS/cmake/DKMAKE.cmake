# https://cmake.org
# https://github.com/Kitware/CMake
# https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi
# https://developer.android.com/studio/projects/configure-cmake
# https://discourse.cmake.org/t/cmake-silent-install-with-options-help/1475/2
# https://askubuntu.com/questions/355565/how-do-i-install-the-latest-version-of-cmake-from-the-command-line 	# How to get latest version on ubuntu


### DOWNLOAD ###
# https://github.com/Kitware/CMake/releases
#ANDROID_HOST_dk_set		(CMAKE_DL https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3-linux-aarch64.tar.gz)
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



### COMPILE CMAKE ###
set(COMPILE_CMAKE 0)
if(COMPILE_CMAKE)
	if(NOT CMAKE_EXE)
		dk_set(CMAKE_EXE ${CMAKE_COMMAND})
	else()
		dk_import(https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3.tar.gz)
		if(ANDROID_HOST)
			dk_download(https://raw.githubusercontent.com/libarchive/libarchive/master/contrib/android/include/android_lf.h ${CMAKE}/Utilities/cmlibarchive/libarchive)
		endif()
		
		dk_include				(${CMAKE}									CMAKE_INCLUDE_DIR)
		dk_include				(${CMAKE}/${OS})
		DEBUG_dk_include		(${CMAKE}/${OS}/${DEBUG_DIR})
		RELEASE_dk_include		(${CMAKE}/${OS}/${RELEASE_DIR})

		dk_libDebug		(${CMAKE}/${OS}/${DEBUG_DIR}/libcmake.a				CMAKE_LIBRARY_DEBUG)
		dk_libRelease	(${CMAKE}/${OS}/${RELEASE_DIR}/libcmake.a			CMAKE_LIBRARY_RELEASE)
		
		string(REPLACE "--DDEBUG" 	""	CMAKE_BUILD "${DKCMAKE_BUILD}")
		string(REPLACE "  " 		" " CMAKE_BUILD "${CMAKE_BUILD}")
		dk_queueCommand(${DKCMAKE_BUILD} 
			-DCMake_INSTALL_COMPONENTS=OFF 			# "Using components when installing" OFF
			-DCMake_INSTALL_DEPENDENCIES=OFF		# "Whether to install 3rd-party runtime dependencies" OFF
			-DCMake_BUILD_DEVELOPER_REFERENCE=OFF	# "Build CMake Developer Reference" OFF
			-DCMake_BUILD_LTO=OFF 					# "Compile CMake with link-time optimization if supported" OFF
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
			-DBUILD_TESTING=OFF
			${CMAKE})
			 
		#dk_build(${CMAKE} cmake)
		dk_command(${CMAKE_MAKE_PROGRAM})
		
		return()
	endif()
endif()
	
	

### OR ###	


	
### INSTALL PREBUILT CMAKE ###
if(MSYSTEM)
	dk_depend(msys2)
	DK_ASSERT(MSYS2)
	
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
	if(WIN_HOST)
		if(NOT CMAKE_EXE)
			dk_set(CMAKE_EXE ${CMAKE_COMMAND})
		else()
			dk_set(CMAKE_EXE ${DKTOOLS_DIR}/${CMAKE_FOLDER}/bin/cmake.exe)
			if(NOT EXISTS ${CMAKE_EXE})
				### INSTALL ###
				dk_info("Installing CMake . . .")
				dk_download(${CMAKE_DL} ${DKDOWNLOAD_DIR})			
				file(TO_NATIVE_PATH "${DKDOWNLOAD_DIR}/${CMAKE_DL_FILE}" CMAKE_INSTALL_FILE)
				file(TO_NATIVE_PATH "${DKTOOLS_DIR}/${CMAKE_FOLDER}" CMAKE_INSTALL_PATH)
				dk_command(MsiExec.exe /i "${CMAKE_INSTALL_FILE}" INSTALL_ROOT=${CMAKE_INSTALL_PATH})
			endif()
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
DK_ASSERT(CMAKE_COMMAND)

if(NOT EXISTS ${CMAKE_COMMAND})
	dk_error("CMAKE_COMMAND:${CMAKE_COMMAND} does not exist")
endif()
if(NOT CMAKE_EXE)
	dk_warn("CMAKE_EXE:${CMAKE_EXE} is empty. setting to ${CMAKE_COMMAND}")
	set(CMAKE_EXE "${CMAKE_COMMAND}" CACHE INTERNAL "" FORCE)
endif()

DK_ASSERT(CMAKE_EXE)
if(NOT EXISTS ${CMAKE_EXE})
	dk_error("CMAKE_EXE:${CMAKE_EXE} does not exist")
endif()

dk_set(CMAKE_EXE ${CMAKE_EXE}) # make the variable persistent

### print CMAKE info ###
dk_debug(CMAKE_EX	PRINTVAR)
dk_command(${CMAKE_EXE} --version OUTPUT_VARIABLE CMAKE_VERSION)
dk_debug(CMAKE_VERSION	PRINTVAR)
