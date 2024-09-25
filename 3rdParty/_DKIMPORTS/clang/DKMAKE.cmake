include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://packages.msys2.org/package/mingw-w64-x86_64-clang?repo=mingw64


if(clang OR mingw OR ucrt)
	dk_validate(MSYS2  			"dk_depend(msys2)")
	dk_validate(PACMAN_EXE		"dk_depend(pacman)")
	dk_validate(DKDOWNLOAD_DIR  "dk_setDKDOWNLOAD_DIR()")
	dk_delete(${MSYS2_DIR}/var/lib/pacman/db.lck NO_HALT)
endif()
	
	
	
if(win_x86_clang)
	dk_command(${PACMAN_EXE}  -S mingw-w64-clang-i686-clang --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# CLANG32
	dk_set(CLANG_C_COMPILER   ${MSYS2_DIR}/clang32/bin/clang.exe)
	dk_set(CLANG_CXX_COMPILER ${MSYS2_DIR}/clang32/bin/clang++.exe)
	dk_set(CLANG_RC_COMPILER  ${MSYS2_DIR}/clang32/bin/windres.exe)
elseif(win_x86_64_clang)
	dk_command(${PACMAN_EXE}  -S mingw-w64-clang-x86_64-clang --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})	# CLANG64
	dk_set(CLANG_C_COMPILER   ${MSYS2_DIR}/clang64/bin/clang.exe)
	dk_set(CLANG_CXX_COMPILER ${MSYS2_DIR}/clang64/bin/clang++.exe)
	dk_set(CLANG_RC_COMPILER  ${MSYS2_DIR}/clang64/bin/windres.exe)
elseif(win_arm64_clang)
	dk_command(${PACMAN_EXE}  -S mingw-w64-clang-aarch64-clang --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})	# CLANGARM64
	dk_set(CLANG_C_COMPILER   ${MSYS2_DIR}/clangarm64/bin/clang.exe)
	dk_set(CLANG_CXX_COMPILER ${MSYS2_DIR}/clangarm64/bin/clang++.exe)
	dk_set(CLANG_RC_COMPILER  ${MSYS2_DIR}/clangarm64/bin/windres.exe)
elseif(win_x86_mingw)
	dk_command(${PACMAN_EXE}  -S mingw-w64-i686-clang --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# MINGW32
	dk_set(CLANG_C_COMPILER   ${MSYS2_DIR}/mingw32/bin/clang.exe)
	dk_set(CLANG_CXX_COMPILER ${MSYS2_DIR}/mingw32/bin/clang++.exe)
	dk_set(CLANG_RC_COMPILER  ${MSYS2_DIR}/mingw32/bin/windres.exe)
elseif(win_x86_64_mingw)
	dk_command(${PACMAN_EXE}  -S mingw-w64-x86_64-clang --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# MINGW64
	dk_set(CLANG_C_COMPILER   ${MSYS2_DIR}/mingw64/bin/clang.exe)
	dk_set(CLANG_CXX_COMPILER ${MSYS2_DIR}/mingw64/bin/clang++.exe)
	dk_set(CLANG_RC_COMPILER  ${MSYS2_DIR}/mingw64/bin/windres.exe)
elseif(win_x86_64_ucrt)
	dk_command(${PACMAN_EXE}  -S mingw-w64-ucrt-x86_64-clang --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# UCRT64
	dk_set(CLANG_C_COMPILER   ${MSYS2_DIR}/ucrt64/bin/clang.exe)
	dk_set(CLANG_CXX_COMPILER ${MSYS2_DIR}/ucrt64/bin/clang++.exe)
	dk_set(CLANG_RC_COMPILER  ${MSYS2_DIR}/ucrt64/bin/windres.exe)
elseif(LINUX_HOST)
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




###### set GLOBAL CMAKE VARIABLES ######
dk_set(CMAKE_C_COMPILER		${CLANG_C_COMPILER})
dk_set(CMAKE_CXX_COMPILER	${CLANG_CXX_COMPILER})
dk_set(CMAKE_RC_COMPILER	${CLANG_RC_COMPILER})		# TODO:  move to DKIMPORTS/windres

dk_set(DKCONFIGURE_CC		${CMAKE_C_COMPILER})
dk_set(DKCONFIGURE_CXX		${CMAKE_CXX_COMPILER})
