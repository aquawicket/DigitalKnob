# https://packages.msys2.org/base/diffutils

if(MSYS2)
	#dk_msys2("pacman -S mingw-w64-clang-i686-diffutils --noconfirm")		# CLANG32
	#dk_msys2("pacman -S mingw-w64-clang-x86_64-diffutils --noconfirm")		# CLANG64
	#dk_msys2("pacman -S mingw-w64-clang-aarch64-diffutils --noconfirm")	# CLANGARM64
	#dk_msys2("pacman -S mingw-w64-i686-diffutils --noconfirm")				# MINGW32
	dk_msys2("pacman -S mingw-w64-x86_64-diffutils --noconfirm")			# MINGW64
	#dk_msys2("pacman -S mingw-w64-ucrt-x86_64-diffutils --noconfirm")		# UCRT64
endif()