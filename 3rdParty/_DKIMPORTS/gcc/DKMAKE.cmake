include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://packages.msys2.org/package/mingw-w64-x86_64-gcc?repo=mingw64


if(DEFINED ENV{MSYSTEM})
	dk_set(MSYSTEM "$ENV{MSYSTEM}")
	dk_set($ENV{MSYSTEM} 1)
endif()

if(MSYSTEM)
	dk_depend(msys2)
	
	dk_remove(${MSYS2}/var/lib/pacman/db.lck NO_HALT)
	
	if(CLANG32)
		dk_command(${PACMAN_EXE} -S mingw-w64-clang-i686-gcc --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# CLANG32
		dk_set(GCC_EXE ${MSYS2}/clang32/bin/gcc.exe)
		dk_set(GXX_EXE ${MSYS2}/clang32/bin/g++.exe)
	elseif(CLANG64)
		dk_command(${PACMAN_EXE} -S mingw-w64-clang-x86_64-gcc --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})	# CLANG64
		dk_set(GCC_EXE ${MSYS2}/clang64/bin/gcc.exe)
		dk_set(GXX_EXE ${MSYS2}/clang64/bin/g++.exe)
	elseif(CLANGARM64)
		dk_command(${PACMAN_EXE} -S mingw-w64-clang-aarch64-gcc --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})	# CLANGARM64
		dk_set(GCC_EXE ${MSYS2}/clangarm64/bin/gcc.exe)
		dk_set(GXX_EXE ${MSYS2}/clangarm64/bin/g++.exe)
	elseif(MINGW32)
		dk_command(${PACMAN_EXE} -S mingw-w64-i686-gcc --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# MINGW32
		dk_set(GCC_EXE ${MSYS2}/mingw32/bin/gcc.exe)
		dk_set(GXX_EXE ${MSYS2}/mingw32/bin/g++.exe)
	elseif(MINGW64)
		dk_command(${PACMAN_EXE} -S mingw-w64-x86_64-gcc --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# MINGW64
		dk_command(${PACMAN_EXE} -S mingw-w64-x86_64-toolchain --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})
		dk_set(GCC_EXE ${MSYS2}/mingw64/bin/gcc.exe)
		dk_set(GXX_EXE ${MSYS2}/mingw64/bin/g++.exe)
	elseif(UCRT64)
		dk_command(${PACMAN_EXE} -S mingw-w64-ucrt-x86_64-gcc --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})	# UCRT64
		dk_set(GCC_EXE ${MSYS2}/ucrt64/bin/gcc.exe)
		dk_set(GXX_EXE ${MSYS2}/ucrt64/bin/g++.exe)
	endif()
endif()


if(LINUX_HOST)
	if(EXISTS /usr/bin/gcc)
		dk_set(GCC_EXE	/usr/bin/gcc)
	elseif(EXISTS /usr/local/bin/gcc)
		dk_set(GCC_EXE	/usr/local/bin/gcc)
	endif()

	if(EXISTS /usr/bin/g++)
		dk_set(GXX_EXE	/usr/bin/g++)
	elseif(EXISTS /usr/local/bin/g++)
		dk_set(GXX_EXE	/usr/local/bin/g++)
	endif()
endif()



#dk_set(LINUX_GENERATOR			"Unix Makefiles")
#dk_set(RASPBERRY_GENERATOR		"Unix Makefiles")
