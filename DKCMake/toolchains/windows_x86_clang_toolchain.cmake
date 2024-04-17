include_guard()

message(STATUS "####################################################################")
message(STATUS "################ window_x86_clang_toolchain.cmake ###############")
message(STATUS "####################################################################")

###### Get DKCMAKE_DIR ######
if(NOT DKCMAKE_DIR)
	get_filename_component(DKCMAKE_DIR ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)
	get_filename_component(DKBRANCH_DIR ${DKCMAKE_DIR} DIRECTORY)
	set(DK3RDPARTY ${DKBRANCH_DIR}/3rdParty)
	set(DKIMPORTS_DIR ${DK3RDPARTY}/_DKIMPORTS)
endif()

include(${DKCMAKE_DIR}/functions/dk_load.cmake)
dk_load(${DKCMAKE_DIR}/DK.cmake)
dk_load(${DKIMPORTS_DIR}/msys2/DKMAKE.cmake)
set(CLANG32_DIR "${MSYS2}/clang32")
set(CMAKE_MAKE_PROGRAM ${CLANG32_DIR}/bin/mingw32-make.exe CACHE FILEPATH "")
set(CMAKE_C_COMPILER ${CLANG32_DIR}/bin/clang.exe)
set(CMAKE_CXX_COMPILER ${CLANG32_DIR}/bin/clang++.exe)