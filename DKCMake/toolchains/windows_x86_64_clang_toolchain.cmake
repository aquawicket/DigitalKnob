#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()


dk_echo(STATUS "######################################################################")
dk_echo(STATUS "################ windoows_x86_64_clang_toolchain.cmake ###############")
dk_echo(STATUS "######################################################################")

###### Get DKCMAKE_DIR ######
if(NOT DKCMAKE_DIR)
	dk_dirname(${CMAKE_CURRENT_LIST_DIR} DKCMAKE_DIR)
	set(DKCMAKE_FUNCTIONS_DIR ${DKCMAKE_DIR}/functions)
	dk_dirname(${DKCMAKE_DIR} DKBRANCH_DIR)
	set(DK3RDPARTY ${DKBRANCH_DIR}/3rdParty)
	set(DKIMPORTS_DIR ${DK3RDPARTY}/_DKIMPORTS)
endif()

dk_load(${DKIMPORTS_DIR}/msys2/DKMAKE.cmake)
set(CLANG64_DIR "${MSYS2_DIR}/clang64")
set(CMAKE_MAKE_PROGRAM ${CLANG64_DIR}/bin/mingw32-make.exe CACHE FILEPATH "")
set(CMAKE_C_COMPILER ${CLANG64_DIR}/bin/clang.exe)
set(CMAKE_CXX_COMPILER ${CLANG64_DIR}/bin/clang++.exe)