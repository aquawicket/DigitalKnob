#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()


dk_echo(STATUS "####################################################################")
dk_echo(STATUS "################ win_x86_mingw_toolchain.cmake #####################")
dk_echo(STATUS "####################################################################")

###### Get DKCMAKE_DIR ######
if(NOT DKCMAKE_DIR)
	dk_dirname(${CMAKE_CURRENT_LIST_DIR} DKCMAKE_DIR)
	dk_dirname(${DKCMAKE_DIR} DKBRANCH_DIR)
	set(DK3RDPARTY ${DKBRANCH_DIR}/3rdParty)
	set(DKIMPORTS_DIR ${DK3RDPARTY}/_DKIMPORTS)
endif()

dk_depend(msys2)
set(MINGW32_DIR "${MSYS2_DIR}/mingw32")
set(CMAKE_MAKE_PROGRAM ${MINGW32_DIR}/bin/mingw32-make.exe CACHE FILEPATH "")
set(CMAKE_C_COMPILER ${MINGW32_DIR}/bin/gcc.exe)
set(CMAKE_CXX_COMPILER ${MINGW32_DIR}/bin/g++.exe)