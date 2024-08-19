include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://packages.msys2.org/base/make

dk_validate(DK_TARGET_TRIPLE "dk_getTargetTriple")
if( ("${DK_TARGET_ENV}" STREQUAL "clang") OR ("${DK_TARGET_ENV}" STREQUAL "mingw") OR ("${DK_TARGET_ENV}" STREQUAL "ucrt") )
	dk_depend(msys2)
	
	dk_delete(${MSYS2}/var/lib/pacman/db.lck NO_HALT)
	
	if("${DK_TARGET_TRIPLE}" STREQUAL "win_x86_clang")
		dk_command(${PACMAN_EXE} -S mingw-w64-clang-i686-make --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# CLANG32
		dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2}/clang32/bin")
	elseif("${DK_TARGET_TRIPLE}" STREQUAL "win_x86_64_clang")
		dk_command(${PACMAN_EXE} -S mingw-w64-clang-x86_64-make --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# CLANG64
		dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2}/clang64/bin")
	elseif("${DK_TARGET_TRIPLE}" STREQUAL "win_arm64_clang")
		dk_command(${PACMAN_EXE} -S mingw-w64-clang-aarch64-make --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# CLANGARM64
		dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2}/clangarm64/bin")
	elseif("${DK_TARGET_TRIPLE}" STREQUAL "win_x86_mingw")
		dk_command(${PACMAN_EXE} -S mingw-w64-i686-make --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})					# MINGW32
		dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2}/mingw32/bin")
	elseif("${DK_TARGET_TRIPLE}" STREQUAL "win_x86_64_mingw")
		dk_command(${PACMAN_EXE} -S mingw-w64-x86_64-make --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})				# MINGW64
		dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2}/mingw64/bin")
	elseif("${DK_TARGET_TRIPLE}" STREQUAL "win_x86_64_ucrt")
		dk_command(${PACMAN_EXE} -S mingw-w64-ucrt-x86_64-make --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# UCRT64
		dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2}/ucrt64/bin")
	else()
		dk_error("ERROR: not CLANG32, CLANG64, CLANGARM64, MINGW32, MINGW64 or UCRT64")
	endif()
endif()

if(LINUX_HOST)
	dk_findProgram(CAKE_MAKE_PROGRAM make /usr/bin)
endif()

#if(EMSCRIPTEN)
#	dk_findProgram(MAKE_PROGRAM mingw32-make "${EMSDK}/mingw/4.6.2_32bit")
#endif()

dk_assert(CMAKE_MAKE_PROGRAM)
