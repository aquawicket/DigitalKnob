#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://packages.msys2.org/package/mingw-w64-x86_64-gcc?repo=mingw64


if(clang OR mingw OR ucrt)
	dk_validate(MSYS2  			"dk_depend(msys2)")
	dk_validate(PACMAN_EXE		"dk_depend(pacman)")
	dk_validate(DKDOWNLOAD_DIR 	"dk_DKDOWNLOAD_DIR()")
	dk_delete(${MSYS2_DIR}/var/lib/pacman/db.lck NO_HALT)
endif()



if(win_x86_clang)
	dk_command(${PACMAN_EXE}	-S mingw-w64-clang-i686-gcc --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# CLANG32
	dk_set(GCC_C_COMPILER   	${MSYS2_DIR}/clang32/bin/gcc.exe)
	dk_set(GCC_CXX_COMPILER 	${MSYS2_DIR}/clang32/bin/g++.exe)
	dk_set(GCC_RC_COMPILER  	${MSYS2_DIR}/clang32/bin/windres.exe)		# TODO:  move to DKIMPORTS/windres
elseif(win_x86_64_clang)
	dk_command(${PACMAN_EXE}  	-S mingw-w64-clang-x86_64-gcc --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})	# CLANG64
	dk_set(GCC_C_COMPILER   	${MSYS2_DIR}/clang64/bin/gcc.exe)
	dk_set(GCC_CXX_COMPILER 	${MSYS2_DIR}/clang64/bin/g++.exe)
	dk_set(GCC_RC_COMPILER  	${MSYS2_DIR}/clang64/bin/windres.exe)		# TODO:  move to DKIMPORTS/windres
elseif(win_arm64_clang)
	dk_command(${PACMAN_EXE}	-S mingw-w64-clang-aarch64-gcc --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})	# CLANGARM64
	dk_set(GCC_C_COMPILER   	${MSYS2_DIR}/clangarm64/bin/gcc.exe)
	dk_set(GCC_CXX_COMPILER 	${MSYS2_DIR}/clangarm64/bin/g++.exe)
	dk_set(GCC_RC_COMPILER  	${MSYS2_DIR}/clangarm64/bin/windres.exe)	# TODO:  move to DKIMPORTS/windres
elseif(win_x86_mingw)
	dk_command(${PACMAN_EXE}	-S mingw-w64-i686-gcc --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# MINGW32
	dk_set(GCC_C_COMPILER   	${MSYS2_DIR}/mingw32/bin/gcc.exe)
	dk_set(GCC_CXX_COMPILER 	${MSYS2_DIR}/mingw32/bin/g++.exe)
	dk_set(GCC_RC_COMPILER  	${MSYS2_DIR}/mingw32/bin/windres.exe)		# TODO:  move to DKIMPORTS/windres
elseif(win_x86_64_mingw)
	dk_command(${PACMAN_EXE}	-S mingw-w64-x86_64-gcc --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# MINGW64
	dk_set(GCC_C_COMPILER   	${MSYS2_DIR}/mingw64/bin/gcc.exe)
	dk_set(GCC_CXX_COMPILER 	${MSYS2_DIR}/mingw64/bin/g++.exe)
	dk_set(GCC_RC_COMPILER  	${MSYS2_DIR}/mingw64/bin/windres.exe)		# TODO:  move to DKIMPORTS/windres
elseif(win_x86_64_ucrt)
	dk_command(${PACMAN_EXE}	-S mingw-w64-ucrt-x86_64-gcc --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# UCRT64
	dk_set(GCC_C_COMPILER   	${MSYS2_DIR}/ucrt64/bin/gcc.exe)
	dk_set(GCC_CXX_COMPILER 	${MSYS2_DIR}/ucrt64/bin/g++.exe)
	dk_set(GCC_RC_COMPILER  	${MSYS2_DIR}/ucrt64/bin/windres.exe)		# TODO:  move to DKIMPORTS/windres
elseif(LINUX_HOST)
	if(EXISTS /usr/bin/gcc)
		dk_set(GCC_C_COMPILER	/usr/bin/gcc)
	elseif(EXISTS /usr/local/bin/gcc)
		dk_set(GCC_C_COMPILER	/usr/local/bin/gcc)
	endif()

	if(EXISTS /usr/bin/g++)
		dk_set(GCC_CXX_COMPILER	/usr/bin/g++)
	elseif(EXISTS /usr/local/bin/g++)
		dk_set(GCC_CXX_COMPILER	/usr/local/bin/g++)
	endif()
endif()




###### set GLOBAL CMAKE VARIABLES ######
dk_set(CMAKE_C_COMPILER		${GCC_C_COMPILER})
dk_set(CMAKE_CXX_COMPILER	${GCC_CXX_COMPILER})
dk_set(CMAKE_RC_COMPILER	${GCC_RC_COMPILER})			# TODO:  move to DKIMPORTS/windres

dk_set(DKCONFIGURE_CC		${CMAKE_C_COMPILER})
dk_set(DKCONFIGURE_CXX		${CMAKE_CXX_COMPILER})
