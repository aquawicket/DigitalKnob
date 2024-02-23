# https://packages.msys2.org/package/mingw-w64-x86_64-clang?repo=mingw64

if(MSYSTEM)
	dk_depend(msys2)
	
	dk_remove(${MSYS2}/var/lib/pacman/db.lck NOERROR)
	
	if(CLANG32)
		dk_command("pacman -S mingw-w64-clang-i686-clang --needed --noconfirm")		# CLANG32
		dk_set(CLANG_C_COMPILER ${MSYS2}/clang32/bin/clang.exe)
		dk_set(CLANG_CXX_COMPILER ${MSYS2}/clang32/bin/clang++.exe)
	elseif(CLANG64)
		dk_command("pacman -S mingw-w64-clang-x86_64-clang --needed --noconfirm")	# CLANG64
		dk_set(CLANG_C_COMPILER ${MSYS2}/clang64/bin/clang.exe)
		dk_set(CLANG_CXX_COMPILER ${MSYS2}/clang64/bin/clang++.exe)
	elseif(CLANGARM64)
		dk_command("pacman -S mingw-w64-clang-aarch64-clang --needed --noconfirm")	# CLANGARM64
		dk_set(CLANG_C_COMPILER ${MSYS2}/clangarm64/bin/clang.exe)
		dk_set(CLANG_CXX_COMPILER ${MSYS2}/clangarm64/bin/clang++.exe)
	elseif(MINGW32)
		dk_command("pacman -S mingw-w64-i686-clang --needed --noconfirm")			# MINGW32
		dk_set(CLANG_C_COMPILER ${MSYS2}/mingw32/bin/clang.exe)
		dk_set(CLANG_CXX_COMPILER ${MSYS2}/mingw32/bin/clang++.exe)
	elseif(MINGW64)
		dk_command("pacman -S mingw-w64-x86_64-clang --needed --noconfirm")			# MINGW64
		dk_set(CLANG_C_COMPILER ${MSYS2}/mingw64/bin/clang.exe)
		dk_set(CLANG_CXX_COMPILER ${MSYS2}/mingw64/bin/clang++.exe)
	elseif(UCRT64)
		dk_command("pacman -S mingw-w64-ucrt-x86_64-clang --needed --noconfirm")	# UCRT64
		dk_set(CLANG_C_COMPILER ${MSYS2}/ucrt64/bin/clang.exe)
		dk_set(CLANG_CXX_COMPILER ${MSYS2}/ucrt64/bin/clang++.exe)
	endif()
endif()


if(LINUX_HOST)
	if(EXISTS /usr/bin/clang)
		dk_set(CLANG_C_COMPILER	/usr/bin/clang)
	elseif(EXISTS /usr/local/bin/clang)
		dk_set(CLANG_C_COMPILER	/usr/local/bin/clang)
	endif()

	if(EXISTS /usr/bin/clang++)
		dk_set(CLANG_CXX_COMPILER	/usr/bin/clang++)
	elseif(EXISTS /usr/local/bin/clang++)
		dk_set(CLANG_CXX_COMPILER	/usr/local/bin/clang++)
	endif()
endif()