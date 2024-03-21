include_guard()

message(STATUS "##############################################################")
message(STATUS "################# emscripten_toolchain.cmake #################")
message(STATUS "##############################################################")


set(EMSCRIPTEN_DIR C:/Users/aquawicket/digitalknob/Development/3rdParty/emsdk-main)
set(EMSCRIPTEN_MINGW32_DIR ${EMSCRIPTEN_DIR}/mingw/4.6.2_32bit)
if(NOT EXISTS ${EMSCRIPTEN_MINGW32_DIR})
	dk_error("EMSCRIPTEN_MINGW32_DIR does not exist")
endif()

###### Set DKCMAKE_DIR ######
if(NOT DKCMAKE_DIR)
	get_filename_component(DKCMAKE_DIR ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)
	get_filename_component(DKBRANCH_DIR ${DKCMAKE_DIR} DIRECTORY)
	set(DK3RDPARTY ${DKBRANCH_DIR}/3rdParty)
	set(DKIMPORTS_DIR ${DK3RDPARTY}/_DKIMPORTS)
endif()

include(${DKCMAKE_DIR}/functions/dk_load.cmake)
dk_load(${DKCMAKE_DIR}/DK.cmake)
dk_load(${DKIMPORTS_DIR}/emsdk/DKMAKE.cmake)
dk_command(${EMSDK}/emsdk_env${bat})
dk_load(${EMSCRIPTEN_TOOLCHAIN_FILE})

