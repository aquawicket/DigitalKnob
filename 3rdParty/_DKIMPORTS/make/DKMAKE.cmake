# https://packages.msys2.org/base/make

if(MSYSTEM)
	dk_depend(msys2)
	
	if(CLANG32)
		dk_msys2("pacman -S mingw-w64-clang-i686-make --noconfirm")		# CLANG32
	elseif(CLANG64)
		dk_msys2("pacman -S mingw-w64-clang-x86_64-make --noconfirm")	# CLANG64
	elseif(CLANGARM64)
		dk_msys2("pacman -S mingw-w64-clang-aarch64-make --noconfirm")	# CLANGARM64
	elseif(MINGW32)
		dk_msys2("pacman -S mingw-w64-i686-make --noconfirm")			# MINGW32
	elseif(MINGW64)
		dk_msys2("pacman -S mingw-w64-x86_64-make --noconfirm")			# MINGW64
		dk_executeProcess("mklink make mingw32-make.exe" WORKING_DIRECTORY ${MSYS2}/mingw64/bin)
	elseif(UCRT64)
		dk_msys2("pacman -S mingw-w64-ucrt-x86_64-make --noconfirm")	# UCRT64
	else()
		dk_error("MSYSTEM is invalid")
	endif()
	
	dk_set(MAKE_EXE make)
	dk_debug("MAKE_EXE = ${MAKE_EXE}")
	dk_msys2(${MAKE_EXE} --version)
	
	return()
endif()