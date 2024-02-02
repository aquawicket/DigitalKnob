# https://packages.msys2.org/base/diffutils

if(WIN_HOST)
	dk_depend(msys2)
	
	dk_remove(${MSYS2}/var/lib/pacman/db.lck NOERROR)
	
	if(CLANG32)
		dk_msys2("pacman -S mingw-w64-clang-i686-diffutils --needed --noconfirm")	# CLANG32
	elseif(CLANG64)
		dk_msys2("pacman -S mingw-w64-clang-x86_64-diffutils --needed --noconfirm")	# CLANG64
	elseif(CLANGARM64)
		dk_msys2("pacman -S mingw-w64-clang-aarch64-diffutils --needed --noconfirm")	# CLANGARM64
	elseif(MINGW32)
		dk_msys2("pacman -S mingw-w64-i686-diffutils --needed --noconfirm")			# MINGW32
	elseif(MINGW64)
		dk_msys2("pacman -S mingw-w64-x86_64-diffutils --needed --noconfirm")		# MINGW64
	elseif(UCRT64)
		dk_msys2("pacman -S mingw-w64-ucrt-x86_64-diffutils --needed --noconfirm")	# UCRT64
	elseif(WIN_32)
		dk_msys2("pacman -S mingw-w64-i686-diffutils --needed --noconfirm")			# WIN32 / MINGW32
	elseif(WIN_64)
		dk_msys2("pacman -S mingw-w64-x86_64-diffutils --needed --noconfirm")		# WIN64 / MINGW64
	endif()
endif()