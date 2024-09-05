include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://packages.msys2.org/base/gdb


if(DEFINED ENV{MSYSTEM})
	dk_set(MSYSTEM "$ENV{MSYSTEM}")
	dk_set($ENV{MSYSTEM} 1)
endif()


dk_validate(HOST_TRIPLE     "dk_getHostTriple()")
dk_validate(TARGET_TRIPLE   "dk_getTargetTriple()")
dk_validate(DKDOWNLOAD_DIR  "dk_getDKPaths()")

dk_depend(msys2)
dk_depend(pacman)
dk_delete(${MSYS2}/var/lib/pacman/db.lck NO_HALT)

if(win_x86_clang)
	dk_command(${PACMAN_EXE} -S mingw-w64-clang-i686-gdb --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# CLANG32
elseif(win_x86_64_clang)
	dk_command(${PACMAN_EXE} -S mingw-w64-clang-x86_64-gdb --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})	# CLANG64
elseif(win_arm64_clang)
	dk_command(${PACMAN_EXE} -S mingw-w64-clang-aarch64-gdb --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})	# CLANGARM64
elseif(win_x86_mingw)
	dk_command(${PACMAN_EXE} -S mingw-w64-i686-gdb --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# MINGW32
elseif(win_x86_64_mingw)
	dk_command(${PACMAN_EXE} -S mingw-w64-x86_64-gdb --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# MINGW64
elseif(win_x86_64_ucrt)
	dk_command(${PACMAN_EXE} -S mingw-w64-ucrt-x86_64-gdb --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})	# UCRT64
endif()
