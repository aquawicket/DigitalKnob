# https://packages.msys2.org/base/make

if(MSYSTEM)
	dk_depend(msys2)
	
	dk_remove(${MSYS2}/var/lib/pacman/db.lck NOERROR)
	
	if(CLANG32)
		dk_command(pacman -S mingw-w64-clang-i686-make --needed --noconfirm)			# CLANG32
		dk_find_program(MAKE_PROGRAM mingw32-make "${MSYS2}/clang32/bin")
	elseif(CLANG64)
		dk_command(pacman -S mingw-w64-clang-x86_64-make --needed --noconfirm)			# CLANG64
		dk_find_program(MAKE_PROGRAM mingw32-make "${MSYS2}/clang64/bin")
	elseif(CLANGARM64)
		dk_command(pacman -S mingw-w64-clang-aarch64-make --needed --noconfirm)			# CLANGARM64
		dk_find_program(MAKE_PROGRAM mingw32-make "${MSYS2}/clangarm64/bin")
	elseif(MINGW32)
		dk_command(pacman -S mingw-w64-i686-make --needed --noconfirm)					# MINGW32
		dk_find_program(MAKE_PROGRAM mingw32-make "${MSYS2}/mingw32/bin")
	elseif(MINGW64)
		dk_command(pacman -S mingw-w64-x86_64-make --needed --noconfirm)				# MINGW64
		dk_find_program(MAKE_PROGRAM mingw32-make "${MSYS2}/mingw64/bin")
	elseif(UCRT64)
		dk_command(pacman -S mingw-w64-ucrt-x86_64-make --needed --noconfirm)			# UCRT64
		dk_find_program(MAKE_PROGRAM mingw32-make "${MSYS2}/ucrt64/bin")
	endif()
endif()

#if(EMSCRIPTEN)
#	dk_find_program(MAKE_PROGRAM mingw32-make "${EMSDK}/mingw/4.6.2_32bit")
#endif()
