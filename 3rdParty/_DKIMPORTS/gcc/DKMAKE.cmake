# https://packages.msys2.org/package/mingw-w64-x86_64-gcc?repo=mingw64

if(CLANG32)
	dk_msys2("pacman -S mingw-w64-clang-i686-gcc --noconfirm")		# CLANG32
else if(CLANG64)
	dk_msys2("pacman -S mingw-w64-clang-x86_64-gcc --noconfirm")	# CLANG64
else if(CLANGARM64)
	dk_msys2("pacman -S mingw-w64-clang-aarch64-gcc --noconfirm")	# CLANGARM64
else if(MINGW32)
	dk_msys2("pacman -S mingw-w64-i686-gcc --noconfirm")			# MINGW32
else if(MINGW64)
	dk_msys2("pacman -S mingw-w64-x86_64-gcc --noconfirm")			# MINGW64
else if(UCRT64)
	dk_msys2("pacman -S mingw-w64-ucrt-x86_64-gcc --noconfirm")		# UCRT64
endif()