# https://packages.msys2.org/base/make

if(MSYS2)
	#dk_msys2("pacman -S mingw-w64-clang-i686-make --noconfirm")		# CLANG32
	#dk_msys2("pacman -S mingw-w64-clang-x86_64-make --noconfirm")		# CLANG64
	#dk_msys2("pacman -S mingw-w64-clang-aarch64-make --noconfirm")		# CLANGARM64
	#dk_msys2("pacman -S mingw-w64-i686-make --noconfirm")				# MINGW32
	dk_msys2("pacman -S mingw-w64-x86_64-make --noconfirm")				# MINGW64
	#dk_msys2("pacman -S mingw-w64-ucrt-x86_64-make --noconfirm")		# UCRT64
endif()