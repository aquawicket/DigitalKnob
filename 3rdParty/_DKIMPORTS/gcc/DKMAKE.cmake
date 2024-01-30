# https://packages.msys2.org/package/mingw-w64-x86_64-gcc?repo=mingw64


if(MSYSTEM)
	dk_depend(msys2)
	
	if(CLANG32)
		dk_msys2("pacman -S mingw-w64-clang-i686-gcc --noconfirm")		# CLANG32
	elseif(CLANG64)
		dk_msys2("pacman -S mingw-w64-clang-x86_64-gcc --noconfirm")	# CLANG64
	elseif(CLANGARM64)
		dk_msys2("pacman -S mingw-w64-clang-aarch64-gcc --noconfirm")	# CLANGARM64
	elseif(MINGW32)
		dk_msys2("pacman -S mingw-w64-i686-gcc --noconfirm")			# MINGW32
	elseif(MINGW64)
		dk_msys2("pacman -S mingw-w64-x86_64-gcc --noconfirm")			# MINGW64
	elseif(UCRT64)
		dk_msys2("pacman -S mingw-w64-ucrt-x86_64-gcc --noconfirm")		# UCRT64
	else()
		dk_error("MSYSTEM is invalid")
	endif()
	
	dk_set(GCC_EXE gcc)
	dk_debug("GCC_EXE = ${GCC_EXE}")
	dk_msys2(${GCC_EXE} --version)
	
	return()
endif()