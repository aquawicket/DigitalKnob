#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


######## luajit ########
# https://github.com/LuaJIT/LuaJIT.git
dk_validate(Target_Config  "dk_Target_Config()")

dk_import(https://github.com/LuaJIT/LuaJIT/archive/refs/heads/v2.1.zip)

#dk_import(https://github.com/tarantool/luajit.git BRANCH tarantool/master)
#dk_validate(ENV{DK3RDPARTY_DIR} "dk_DK3RDPARTY_DIR()")
#dk_rename($ENV{DK3RDPARTY_DIR}/luajit-tarantool/master $ENV{DK3RDPARTY_DIR}/luajit OVERWRITE)
#dk_set(LUAJIT $ENV{DK3RDPARTY_DIR}/luajit)
#dk_fileReplace(${LUAJIT}/CMakeLists.txt "  message(FATAL_ERROR" "  message(STATUS")

dk_libDebug(${LUAJIT.Debug_Dir}/libluajit.a)


dk_configure(${LUAJIT})


dk_set(LUAJIT_CMAKE -DLUAJIT_INCLUDE_DIR= -DLUAJIT_LIBRARY=)