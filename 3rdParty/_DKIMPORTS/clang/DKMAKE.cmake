include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://packages.msys2.org/package/mingw-w64-x86_64-clang?repo=mingw64


if(DEFINED ENV{MSYSTEM})
	dk_set(MSYSTEM "$ENV{MSYSTEM}")
	dk_set($ENV{MSYSTEM} 1)
endif()

if(MSYSTEM)
	dk_depend(msys2)
	
	dk_delete(${MSYS2}/var/lib/pacman/db.lck NO_HALT)
	
	if(win_x86_clang)
		dk_command(${PACMAN_EXE} -S mingw-w64-clang-i686-clang --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# CLANG32
		dk_set(CLANG_EXE   ${MSYS2}/clang32/bin/clang.exe)
		dk_set(CLANGXX_EXE ${MSYS2}/clang32/bin/clang++.exe)
	elseif(win_x86_64_clang)
		dk_command(${PACMAN_EXE} -S mingw-w64-clang-x86_64-clang --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# CLANG64
		dk_set(CLANG_EXE   ${MSYS2}/clang64/bin/clang.exe)
		dk_set(CLANGXX_EXE ${MSYS2}/clang64/bin/clang++.exe)
	elseif(win_arm64_clang)
		dk_command(${PACMAN_EXE} -S mingw-w64-clang-aarch64-clang --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})	# CLANGARM64
		dk_set(CLANG_EXE   ${MSYS2}/clangarm64/bin/clang.exe)
		dk_set(CLANGXX_EXE ${MSYS2}/clangarm64/bin/clang++.exe)
	elseif(win_x86_mingw)
		dk_command(${PACMAN_EXE} -S mingw-w64-i686-clang --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})				# MINGW32
		dk_set(CLANG_EXE   ${MSYS2}/mingw32/bin/clang.exe)
		dk_set(CLANGXX_EXE ${MSYS2}/mingw32/bin/clang++.exe)
	elseif(win_x86_64_mingw)
		dk_command(${PACMAN_EXE} -S mingw-w64-x86_64-clang --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# MINGW64
		dk_set(CLANG_EXE   ${MSYS2}/mingw64/bin/clang.exe)
		dk_set(CLANGXX_EXE ${MSYS2}/mingw64/bin/clang++.exe)
	elseif(win_x86_64_ucrt)
		dk_command(${PACMAN_EXE} -S mingw-w64-ucrt-x86_64-clang --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# UCRT64
		dk_set(CLANG_EXE   ${MSYS2}/ucrt64/bin/clang.exe)
		dk_set(CLANGXX_EXE ${MSYS2}/ucrt64/bin/clang++.exe)
	endif()
endif()


if(LINUX_HOST)
	if(EXISTS /usr/bin/clang)
		dk_set(CLANG_EXE	/usr/bin/clang)
	elseif(EXISTS /usr/local/bin/clang)
		dk_set(CLANG_EXE	/usr/local/bin/clang)
	endif()

	if(EXISTS /usr/bin/clang++)
		dk_set(CLANGXX_EXE	/usr/bin/clang++)
	elseif(EXISTS /usr/local/bin/clang++)
		dk_set(CLANGXX_EXE	/usr/local/bin/clang++)
	endif()
endif()

#dk_command(command -v clang OUTPUT_VARIABLE CLANG_EXE) # BASH_ENV)
#dk_command(command -v clang++ OUTPUT_VARIABLE CLANGXX_EXE) # BASH_ENV)