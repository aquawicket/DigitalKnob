include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()


message(STATUS "####################################################################")
message(STATUS "################ win_x86_64_clang_toolchain.cmake ##################")
message(STATUS "####################################################################")

###### Get DKCMAKE_DIR ######
if(NOT DKCMAKE_DIR)
	get_filename_component(DKCMAKE_DIR ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)
	set(DKCMAKE_FUNCTIONS_DIR ${DKCMAKE_DIR}/functions)
	get_filename_component(DKBRANCH_DIR ${DKCMAKE_DIR} DIRECTORY)
	set(DK3RDPARTY ${DKBRANCH_DIR}/3rdParty)
	set(DKIMPORTS_DIR ${DK3RDPARTY}/_DKIMPORTS)
endif()

dk_load(${DKIMPORTS_DIR}/msys2/DKMAKE.cmake)
set(CLANGARM64_DIR "${MSYS2}/clangarm64")
set(CMAKE_MAKE_PROGRAM ${CLANGARM64_DIR}/bin/mingw32-make.exe CACHE FILEPATH "")
set(CMAKE_C_COMPILER ${CLANGARM64_DIR}/bin/clang.exe)
set(CMAKE_CXX_COMPILER ${CLANGARM64_DIR}/bin/clang++.exe)