# https://packages.msys2.org/package/mingw-w64-x86_64-gcc?repo=mingw64

if(MINGW)
	dk_depend(msys2)
	
	dk_remove(${MSYS2}/var/lib/pacman/db.lck NOERROR)
	
	if(CLANG32)
		dk_command(pacman -S mingw-w64-clang-i686-gcc --needed --noconfirm)		# CLANG32
		dk_set(GCC_C_COMPILER ${MSYS2}/clang32/bin/gcc.exe)
		dk_set(GCC_CXX_COMPILER ${MSYS2}/clang32/bin/g++.exe)
	elseif(CLANG64)
		dk_command(pacman -S mingw-w64-clang-x86_64-gcc --needed --noconfirm)	# CLANG64
		dk_set(GCC_C_COMPILER ${MSYS2}/clang64/bin/gcc.exe)
		dk_set(GCC_CXX_COMPILER ${MSYS2}/clang64/bin/g++.exe)
	elseif(CLANGARM64)
		dk_command(pacman -S mingw-w64-clang-aarch64-gcc --needed --noconfirm)	# CLANGARM64
		dk_set(GCC_C_COMPILER ${MSYS2}/clangarm64/bin/gcc.exe)
		dk_set(GCC_CXX_COMPILER ${MSYS2}/clangarm64/bin/g++.exe)
	elseif(MINGW32)
		dk_command(pacman -S mingw-w64-i686-gcc --needed --noconfirm)			# MINGW32
		dk_set(GCC_C_COMPILER ${MSYS2}/mingw32/bin/gcc.exe)
		dk_set(GCC_CXX_COMPILER ${MSYS2}/mingw32/bin/g++.exe)
	elseif(MINGW64)
		dk_command(pacman -S mingw-w64-x86_64-gcc --needed --noconfirm)			# MINGW64
		dk_set(GCC_C_COMPILER ${MSYS2}/mingw64/bin/gcc.exe)
		dk_set(GCC_CXX_COMPILER ${MSYS2}/mingw64/bin/g++.exe)
	elseif(UCRT64)
		dk_command(pacman -S mingw-w64-ucrt-x86_64-gcc --needed --noconfirm)	# UCRT64
		dk_set(GCC_C_COMPILER ${MSYS2}/ucrt64/bin/gcc.exe)
		dk_set(GCC_CXX_COMPILER ${MSYS2}/ucrt64/bin/g++.exe)
	endif()
endif()


if(LINUX_HOST)
	if(EXISTS /usr/bin/gcc)
		dk_set(GCC_C_COMPILER	/usr/bin/gcc)
	elseif(EXISTS /usr/local/bin/gcc)
		dk_set(GCC_C_COMPILER	/usr/local/bin/gcc)
	endif()

	if(EXISTS /usr/bin/g++)
		dk_set(GCC_CXX_COMPILER	/usr/bin/g++)
	elseif(EXISTS /usr/local/bin/g++)
		dk_set(GCC_CXX_COMPILER	/usr/local/bin/g++)
	endif()
endif()



dk_set(LINUX_GENERATOR			"Unix Makefiles")
dk_set(RASPBERRY_GENERATOR		"Unix Makefiles")
