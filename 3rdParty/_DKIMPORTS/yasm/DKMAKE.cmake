# https://packages.msys2.org/base/yasm

if(MSYS2)
	#dk_msys2("pacman -S mingw-w64-clang-i686-yasm --noconfirm")		# CLANG32
	#dk_msys2("pacman -S mingw-w64-clang-x86_64-yasm --noconfirm")		# CLANG64
	#dk_msys2("pacman -S mingw-w64-clang-aarch64-yasm --noconfirm")		# CLANGARM64
	#dk_msys2("pacman -S mingw-w64-i686-yasm --noconfirm")				# MINGW32
	dk_msys2("pacman -S mingw-w64-x86_64-yasm --noconfirm")				# MINGW64
	#dk_msys2("pacman -S mingw-w64-ucrt-x86_64-yasm --noconfirm")		# UCRT64
endif()