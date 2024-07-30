#include_guard()

dk_echo(STATUS "####################################################################")
dk_echo(STATUS "################ window_x86_mingw_toolchain.cmake ###############")
dk_echo(STATUS "####################################################################")

###### Get DKCMAKE_DIR ######
if(NOT DKCMAKE_DIR)
	dk_dirname(${CMAKE_CURRENT_LIST_DIR} DKCMAKE_DIR)
	dk_dirname(${DKCMAKE_DIR} DKBRANCH_DIR)
	set(DK3RDPARTY ${DKBRANCH_DIR}/3rdParty)
	set(DKIMPORTS_DIR ${DK3RDPARTY}/_DKIMPORTS)
endif()

include(${DKCMAKE_FUNCTIONS_DIR}/dk_load.cmake)
dk_load(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(${DKIMPORTS_DIR}/msys2/DKMAKE.cmake)
set(MINGW32_DIR "${MSYS2}/mingw32")
set(CMAKE_MAKE_PROGRAM ${MINGW32_DIR}/bin/mingw32-make.exe CACHE FILEPATH "")
set(CMAKE_C_COMPILER ${MINGW32_DIR}/bin/gcc.exe)
set(CMAKE_CXX_COMPILER ${MINGW32_DIR}/bin/g++.exe)