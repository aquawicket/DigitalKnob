# https://packages.msys2.org/base/yasm

if(MINGW)
	dk_depend(msys2)
	
	dk_remove(${MSYS2}/var/lib/pacman/db.lck NOERROR)
	
	if(CLANG32)
		dk_command(pacman -S mingw-w64-clang-i686-yasm --needed --noconfirm)		# CLANG32
	elseif(CLANG64)
		dk_command(pacman -S mingw-w64-clang-x86_64-yasm --needed --noconfirm)		# CLANG64
	elseif(CLANGARM64)
		dk_command(pacman -S mingw-w64-clang-aarch64-yasm --needed --noconfirm)		# CLANGARM64
	elseif(MINGW32)
		dk_command(pacman -S mingw-w64-i686-yasm --needed --noconfirm)				# MINGW32
	elseif(MINGW64)
		dk_command(pacman -S mingw-w64-x86_64-yasm --needed --noconfirm)			# MINGW64
	elseif(UCRT64)
		dk_command(pacman -S mingw-w64-ucrt-x86_64-yasm --needed --noconfirm)		# UCRT64
	endif()
endif()