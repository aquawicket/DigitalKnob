include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()


dk_echo(STATUS "####################################################################")
dk_echo(STATUS "################ win_x86_msvc_toolchain.cmake ######################")
dk_echo(STATUS "####################################################################")

###### Get DKCMAKE_DIR ######
if(NOT DKCMAKE_DIR)
	dk_getDirname(${CMAKE_CURRENT_LIST_DIR} DKCMAKE_DIR)
	set(DKCMAKE_FUNCTIONS_DIR ${DKCMAKE_DIR}/functions)
	dk_getDirname(${DKCMAKE_DIR} DKBRANCH_DIR)
	set(DK3RDPARTY ${DKBRANCH_DIR}/3rdParty)
	set(DKIMPORTS_DIR ${DK3RDPARTY}/_DKIMPORTS)
endif()

#dk_load(${DKIMPORTS_DIR}/msys2/DKMAKE.cmake)
#set(CLANG64_DIR "${MSYS2}/clang64")
#set(CMAKE_MAKE_PROGRAM ${CLANG64_DIR}/bin/mingw32-make.exe CACHE FILEPATH "")
#set(CMAKE_C_COMPILER ${CLANG64_DIR}/bin/clang.exe)
#set(CMAKE_CXX_COMPILER ${CLANG64_DIR}/bin/clang++.exe)
