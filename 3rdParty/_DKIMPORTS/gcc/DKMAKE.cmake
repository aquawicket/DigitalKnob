# https://packages.msys2.org/package/mingw-w64-x86_64-gcc?repo=mingw64


if(MSYSTEM)
	dk_depend(msys2)
	
	if(CLANG32)
		dk_msys2("pacman -S mingw-w64-clang-i686-gcc --noconfirm")		# CLANG32
		dk_set(C_COMPILER ${MSYS2}/clang32/bin/gcc.exe)
		dk_set(CXX_COMPILER ${MSYS2}/clang32/bin/g++.exe)
	elseif(CLANG64)
		dk_msys2("pacman -S mingw-w64-clang-x86_64-gcc --noconfirm")	# CLANG64
		dk_set(C_COMPILER ${MSYS2}/clang64/bin/gcc.exe)
		dk_set(CXX_COMPILER ${MSYS2}/clang64/bin/g++.exe)
	elseif(CLANGARM64)
		dk_msys2("pacman -S mingw-w64-clang-aarch64-gcc --noconfirm")	# CLANGARM64
		dk_set(C_COMPILER ${MSYS2}/clangarm64/bin/gcc.exe)
		dk_set(CXX_COMPILER ${MSYS2}/clangarm64/bin/g++.exe)
	elseif(MINGW32)
		dk_msys2("pacman -S mingw-w64-i686-gcc --noconfirm")			# MINGW32
		dk_set(C_COMPILER ${MSYS2}/mingw32/bin/gcc.exe)
		dk_set(CXX_COMPILER ${MSYS2}/mingw32/bin/g++.exe)
	elseif(MINGW64)
		dk_msys2("pacman -S mingw-w64-x86_64-gcc --noconfirm")			# MINGW64
		dk_set(C_COMPILER ${MSYS2}/mingw64/bin/gcc.exe)
		dk_set(CXX_COMPILER ${MSYS2}/mingw64/bin/g++.exe)
	elseif(UCRT64)
		dk_msys2("pacman -S mingw-w64-ucrt-x86_64-gcc --noconfirm")		# UCRT64
		dk_set(C_COMPILER ${MSYS2}/ucrt64/bin/gcc.exe)
		dk_set(CXX_COMPILER ${MSYS2}/ucrt64/bin/g++.exe)
	else()
		dk_error("MSYSTEM is invalid")
	endif()
endif()