include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_validate(HOST_TRIPLE "dk_getHostTriple()")
dk_validate(TARGET_TRIPLE "dk_getTargetTriple()")
# https://packages.msys2.org/base/make

dk_depend(cmake)
dk_depend(msys2)
dk_depend(pacman)

dk_delete(${MSYS2}/var/lib/pacman/db.lck NO_HALT)

if(android)
	dk_command(${PACMAN_EXE} -S mingw-w64-clang-x86_64-make --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# CLANG64
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2}/clang64/bin")
#elseif(EMSCRIPTEN)
#	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${EMSDK}/mingw/4.6.2_32bit")
elseif(LINUX_HOST)
	dk_findProgram(CMAKE_MAKE_PROGRAM make /usr/bin)
elseif(win_arm64_clang)
	dk_command(${PACMAN_EXE} -S mingw-w64-clang-aarch64-make --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# CLANGARM64
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2}/clangarm64/bin")
elseif(win_x86_clang)
	dk_command(${PACMAN_EXE} -S mingw-w64-clang-i686-make --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# CLANG32
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2}/clang32/bin")
elseif(win_x86_64_clang)	
	dk_command(${PACMAN_EXE} -S mingw-w64-clang-x86_64-make --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# CLANG64
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2}/clang64/bin")
elseif(win_x86_mingw)
	dk_command(${PACMAN_EXE} -S mingw-w64-i686-make --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})				# MINGW32
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2}/mingw32/bin")
elseif(win_x86_64_mingw)
	dk_command(${PACMAN_EXE} -S mingw-w64-x86_64-make --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# MINGW64
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2}/mingw64/bin")
elseif(win_x86_64_ucrt)
	dk_command(${PACMAN_EXE} -S mingw-w64-ucrt-x86_64-make --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# UCRT64
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2}/ucrt64/bin")
else()
	dk_error("Could not determine 'CMAKE_MAKE_PROGRAM'")
endif()



dk_assert(CMAKE_MAKE_PROGRAM)
