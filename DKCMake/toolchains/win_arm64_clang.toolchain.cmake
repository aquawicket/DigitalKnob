<<<<<<< HEAD
#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()


dk_echo(STATUS "####################################################################")
dk_echo(STATUS "################ win_x86_64_clang_toolchain.cmake ##################")
dk_echo(STATUS "####################################################################")

###### Get DKCMAKE_DIR ######
if(NOT DKCMAKE_DIR)
	dk_dirname(${CMAKE_CURRENT_LIST_DIR} DKCMAKE_DIR)
	set(DKCMAKE_FUNCTIONS_DIR ${DKCMAKE_DIR}/functions)
	dk_dirname(${DKCMAKE_DIR} DKBRANCH_DIR)
	set(DK3RDPARTY ${DKBRANCH_DIR}/3rdParty)
	set(DKIMPORTS_DIR ${DK3RDPARTY}/_DKIMPORTS)
endif()

dk_load(${DKIMPORTS_DIR}/msys2/DKMAKE.cmake)
set(CLANGARM64_DIR "${MSYS2_DIR}/clangarm64")
set(CMAKE_MAKE_PROGRAM ${CLANGARM64_DIR}/bin/mingw32-make.exe CACHE FILEPATH "")
set(CMAKE_C_COMPILER ${CLANGARM64_DIR}/bin/clang.exe)
set(CMAKE_CXX_COMPILER ${CLANGARM64_DIR}/bin/clang++.exe)
=======
message("############################################################################")
message("################### windoows_arm64_clang_toolchain.cmake ###################")
message("############################################################################")

if(NOT WIN_HOST)
	dk_exit()
endif()

dk_validate(MSYS2 "dk_depend(msys2)")
dk_depend(clang)

dk_set(MSYSTEM 						CLANGARM64)
dk_prependEnvPath("${${MSYSTEM}_BIN}")
dk_set(CMAKE_GENERATOR				"MinGW Makefiles")
dk_set(CMAKE_MAKE_PROGRAM 			"${${MSYSTEM}_BIN}/mingw32-make.exe")
dk_set(CMAKE_C_COMPILER				"${${MSYSTEM}_BIN}/clang.exe")
dk_set(CMAKE_CXX_COMPILER 			"${${MSYSTEM}_BIN}/clang++.exe")
dk_set(CMAKE_RC_COMPILER  			"${${MSYSTEM}_BIN}/windres.exe")

dk_append(CMAKE_C_FLAGS				-march=aarch64 -DMSYSTEM=${MSYSTEM} -DWIN -DWIN_ARM64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu17)
dk_append(CMAKE_CXX_FLAGS			-march=aarch64 -DMSYSTEM=${MSYSTEM} -DWIN -DWIN_ARM64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu++17)
dk_append(CMAKE_EXE_LINKER_FLAGS	-static) # -s)

dk_append(DKCONFIGURE_FLAGS			--build=aarch64-w64-mingw32)
>>>>>>> Development
