include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()


dk_echo(STATUS "####################################################################")
dk_echo(STATUS "################ win_x86_64_mingw_toolchain.cmake ###############")
dk_echo(STATUS "####################################################################")

###### Get DKCMAKE_DIR ######
if(NOT DKCMAKE_DIR)
	dk_getDirname(${CMAKE_CURRENT_LIST_DIR} DKCMAKE_DIR)
	set(DKCMAKE_FUNCTIONS_DIR ${DKCMAKE_DIR}/functions)
	dk_getDirname(${DKCMAKE_DIR} DKBRANCH_DIR)
	set(DK3RDPARTY ${DKBRANCH_DIR}/3rdParty)
	set(DKIMPORTS_DIR ${DK3RDPARTY}/_DKIMPORTS)
endif()

dk_load(${DKIMPORTS_DIR}/msys2/DKMAKE.cmake)
set(MINGW64_DIR "${MSYS2}/mingw64")
set(CMAKE_MAKE_PROGRAM ${MINGW64_DIR}/bin/mingw32-make.exe CACHE FILEPATH "")
set(CMAKE_C_COMPILER ${MINGW64_DIR}/bin/gcc.exe)
set(CMAKE_CXX_COMPILER ${MINGW64_DIR}/bin/g++.exe)
