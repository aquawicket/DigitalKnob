dk_load(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()


dk_echo(STATUS "####################################################################")
dk_echo(STATUS "################ window_x86_clang_toolchain.cmake ##################")
dk_echo(STATUS "####################################################################")

###### Get DKCMAKE_DIR ######
if(NOT DKCMAKE_DIR)
	dk_dirname(${CMAKE_CURRENT_LIST_DIR} DKCMAKE_DIR)
	set(DKCMAKE_FUNCTIONS_DIR ${DKCMAKE_DIR}/functions)
	dk_dirname(${DKCMAKE_DIR} DKBRANCH_DIR)
	set(DK3RDPARTY ${DKBRANCH_DIR}/3rdParty)
	set(DKIMPORTS_DIR ${DK3RDPARTY}/_DKIMPORTS)
endif()

dk_depend(msys2)
set(CLANG32_DIR "${MSYS2_DIR}/clang32")
set(CMAKE_MAKE_PROGRAM ${CLANG32_DIR}/bin/mingw32-make.exe CACHE FILEPATH "")
set(CMAKE_C_COMPILER ${CLANG32_DIR}/bin/clang.exe)
set(CMAKE_CXX_COMPILER ${CLANG32_DIR}/bin/clang++.exe)