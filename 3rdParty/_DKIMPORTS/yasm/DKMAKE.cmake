#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://packages.msys2.org/base/yasm

if(MSYSTEM)
	dk_depend(msys2)
	
	dk_delete(${MSYS2_DIR}/var/lib/pacman/db.lck NO_HALT)
	
	if(win_x86_clang)
		dk_command(${PACMAN_EXE} -S mingw-w64-clang-i686-yasm --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# CLANG32
	elseif(win_x86_64_clang)
		dk_command(${PACMAN_EXE} -S mingw-w64-clang-x86_64-yasm --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# CLANG64
	elseif(win_arm64_clang)
		dk_command(${PACMAN_EXE} -S mingw-w64-clang-aarch64-yasm --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})	# CLANGARM64
	elseif(win_x86_mingw)
		dk_command(${PACMAN_EXE} -S mingw-w64-i686-yasm --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})				# MINGW32
	elseif(win_x86_64_mingw)
		dk_command(${PACMAN_EXE} -S mingw-w64-x86_64-yasm --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# MINGW64
	elseif(win_x86_64_ucrt)
		dk_command(${PACMAN_EXE} -S mingw-w64-ucrt-x86_64-yasm --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# UCRT64
	endif()
endif()