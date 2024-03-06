# https://packages.msys2.org/base/make

if(MINGW)
	dk_depend(msys2)
	
	dk_remove(${MSYS2}/var/lib/pacman/db.lck NOERROR)
	
	if(CLANG32)
		dk_command(pacman -S mingw-w64-clang-i686-make --needed --noconfirm)			# CLANG32
		dk_copy(${MSYS2}/clang32/bin/mingw32-make.exe ${MSYS2}/clang32/bin/make.exe)
		dk_set(MAKE_PROGRAM ${MSYS2}/clang32/bin/make.exe)
	elseif(CLANG64)
		dk_command(pacman -S mingw-w64-clang-x86_64-make --needed --noconfirm)			# CLANG64
		dk_copy(${MSYS2}/clang64/bin/mingw32-make.exe ${MSYS2}/clang64/bin/make.exe)
		dk_set(MAKE_PROGRAM ${MSYS2}/clang64/bin/make.exe)
	elseif(CLANGARM64)
		dk_command(pacman -S mingw-w64-clang-aarch64-make --needed --noconfirm)			# CLANGARM64
		dk_copy(${MSYS2}/clangarm64/bin/mingw32-make.exe ${MSYS2}/clangarm64/bin/make.exe)
		dk_set(MAKE_PROGRAM ${MSYS2}/clangarm64/bin/make.exe)
	elseif(MINGW32)
		dk_command(pacman -S mingw-w64-i686-make --needed --noconfirm)
		dk_copy(${MSYS2}/mingw32/bin/mingw32-make.exe ${MSYS2}/mingw32/bin/make.exe)	# MINGW32
		dk_set(MAKE_PROGRAM ${MSYS2}/mingw32/bin/make.exe)
	elseif(MINGW64)
		dk_command(pacman -S mingw-w64-x86_64-make --needed --noconfirm)				# MINGW64
		dk_copy(${MSYS2}/mingw64/bin/mingw32-make.exe ${MSYS2}/mingw64/bin/make.exe)
		dk_set(MAKE_PROGRAM ${MSYS2}/mingw64/bin/make.exe)
	elseif(UCRT64)
		dk_command(pacman -S mingw-w64-ucrt-x86_64-make --needed --noconfirm)			# UCRT64
		dk_copy(${MSYS2}/ucrt64/bin/mingw32-make.exe ${MSYS2}/ucrt64/bin/make.exe)
		dk_set(MAKE_PROGRAM ${MSYS2}/ucrt64/bin/make.exe)
	endif()
endif()