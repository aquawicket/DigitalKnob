include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://packages.msys2.org/base/make

if(CMAKE_MAKE_PROGRAM)
	return()
endif()


dk_validate(HOST_TRIPLE   "dk_getHostTriple()")
dk_validate(TARGET_TRIPLE "dk_getTargetTriple()")
if(android)
	if(WIN_HOST)
		dk_validate(MSYS2 "dk_depend(msys2)")
		dk_validate(PACMAN_EXE "dk_depend(pacman)")
		dk_validate(DKDOWNLOAD_DIR "dk_getDKPaths()")
		
		dk_delete(${MSYS2}/var/lib/pacman/db.lck NO_HALT)
		dk_command(${PACMAN_EXE} -S mingw-w64-clang-x86_64-make --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})
		dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2}/clang64/bin")
	else()
		dk_findProgram(CMAKE_MAKE_PROGRAM make)
	endif()
	
elseif(emscripten)
	if(WIN_HOST)
		dk_validate(EMSDK "dk_depend(emsdk)")
		dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${EMSDK}/mingw/4.6.2_32bit")
	else()
		dk_findProgram(CMAKE_MAKE_PROGRAM make /usr/bin)
	endif()
	
elseif(LINUX_HOST)
	dk_findProgram(CMAKE_MAKE_PROGRAM make /usr/bin)
	
elseif(win_arm64_clang)
	dk_validate(MSYS2 "dk_depend(msys2)")
	dk_validate(PACMAN_EXE "dk_depend(pacman)")
	dk_validate(DKDOWNLOAD_DIR "dk_getDKPaths()")
	dk_delete(${MSYS2}/var/lib/pacman/db.lck NO_HALT)
	dk_command(${PACMAN_EXE} -S mingw-w64-clang-aarch64-make --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# CLANGARM64
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2}/clangarm64/bin")
	
elseif(win_x86_clang)
	dk_validate(MSYS2 "dk_depend(msys2)")
	dk_validate(PACMAN_EXE "dk_depend(pacman)")
	dk_validate(DKDOWNLOAD_DIR "dk_getDKPaths()")
	dk_delete(${MSYS2}/var/lib/pacman/db.lck NO_HALT)
	dk_command(${PACMAN_EXE} -S mingw-w64-clang-i686-make --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# CLANG32
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2}/clang32/bin")
	
elseif(win_x86_64_clang)
	dk_validate(MSYS2 "dk_depend(msys2)")
	dk_validate(PACMAN_EXE "dk_depend(pacman)")
	dk_validate(DKDOWNLOAD_DIR "dk_getDKPaths()")
	dk_delete(${MSYS2}/var/lib/pacman/db.lck NO_HALT)
	dk_command(${PACMAN_EXE} -S mingw-w64-clang-x86_64-make --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# CLANG64
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2}/clang64/bin")
	
elseif(win_x86_mingw)
	dk_validate(MSYS2 "dk_depend(msys2)")
	dk_validate(PACMAN_EXE "dk_depend(pacman)")
	dk_validate(DKDOWNLOAD_DIR "dk_getDKPaths()")
	dk_delete(${MSYS2}/var/lib/pacman/db.lck NO_HALT)
	dk_command(${PACMAN_EXE} -S mingw-w64-i686-make --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})				# MINGW32
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2}/mingw32/bin")
	
elseif(win_x86_64_mingw)
	dk_validate(MSYS2 "dk_depend(msys2)")
	dk_validate(PACMAN_EXE "dk_depend(pacman)")
	dk_validate(DKDOWNLOAD_DIR "dk_getDKPaths()")
	dk_delete(${MSYS2}/var/lib/pacman/db.lck NO_HALT)
	dk_command(${PACMAN_EXE} -S mingw-w64-x86_64-make --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# MINGW64
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2}/mingw64/bin")
	
elseif(win_x86_64_ucrt)
	dk_validate(MSYS2 "dk_depend(msys2)")
	dk_validate(PACMAN_EXE "dk_depend(pacman)")
	dk_validate(DKDOWNLOAD_DIR "dk_getDKPaths()")
	dk_delete(${MSYS2}/var/lib/pacman/db.lck NO_HALT)
	dk_command(${PACMAN_EXE} -S mingw-w64-ucrt-x86_64-make --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# UCRT64
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2}/ucrt64/bin")
	
else()
	dk_error("Could not determine 'CMAKE_MAKE_PROGRAM'")
	
endif()


dk_assert(CMAKE_MAKE_PROGRAM)
