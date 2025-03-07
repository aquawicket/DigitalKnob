#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


######## luajit ########
# https://github.com/LuaJIT/LuaJIT.git
dk_load(dk_builder)

dk_import(https://github.com/LuaJIT/LuaJIT/archive/refs/heads/v2.1.zip)

#dk_import(https://github.com/tarantool/luajit.git BRANCH tarantool/master)
#dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
#dk_rename(${DK3RDPARTY_DIR}/luajit-tarantool/master ${DK3RDPARTY_DIR}/luajit OVERWRITE)
#dk_set(LUAJIT ${DK3RDPARTY_DIR}/luajit)
#dk_fileReplace(${LUAJIT}/CMakeLists.txt "  message(FATAL_ERROR" "  message(STATUS")

dk_libDebug(${LUAJIT_DEBUG_DIR}/libluajit.a)


dk_configure(${LUAJIT})


dk_set(LUAJIT_CMAKE -DLUAJIT_INCLUDE_DIR= -DLUAJIT_LIBRARY=)