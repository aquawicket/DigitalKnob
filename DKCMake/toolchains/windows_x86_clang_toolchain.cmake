dk_load(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()


message(STATUS "####################################################################")
message(STATUS "################ window_x86_clang_toolchain.cmake ##################")
message(STATUS "####################################################################")

###### Get DKCMAKE_DIR ######
if(NOT DKCMAKE_DIR)
	dk_getDirname(${CMAKE_CURRENT_LIST_DIR} DKCMAKE_DIR)
	set(DKCMAKE_FUNCTIONS_DIR ${DKCMAKE_DIR}/functions)
	dk_getDirname(${DKCMAKE_DIR} DKBRANCH_DIR)
	set(DK3RDPARTY ${DKBRANCH_DIR}/3rdParty)
	set(DKIMPORTS_DIR ${DK3RDPARTY}/_DKIMPORTS)
endif()

dk_load(${DKIMPORTS_DIR}/msys2/DKMAKE.cmake)
set(CLANG32_DIR "${MSYS2}/clang32")
set(CMAKE_MAKE_PROGRAM ${CLANG32_DIR}/bin/mingw32-make.exe CACHE FILEPATH "")
set(CMAKE_C_COMPILER ${CLANG32_DIR}/bin/clang.exe)
set(CMAKE_CXX_COMPILER ${CLANG32_DIR}/bin/clang++.exe)