# https://github.com/LuaJIT/LuaJIT.git

dk_import(https://github.com/LuaJIT/LuaJIT.git BRANCH v2.1)

#dk_import(https://github.com/tarantool/luajit.git BRANCH tarantool/master)
#dk_rename(${DK3RDPARTY_DIR}/luajit-tarantool/master ${DK3RDPARTY_DIR}/luajit OVERWRITE)
#dk_set(LUAJIT ${DK3RDPARTY_DIR}/luajit)
#dk_fileReplace(${LUAJIT}/CMakeLists.txt "  message(FATAL_ERROR" "  message(STATUS")

dk_libDebug			(${LUAJIT}/${OS}/${DEBUG_DIR}/libluajit.a)


dk_configure(${LUAJIT})


dk_set(LUAJIT_CMAKE -DLUAJIT_INCLUDE_DIR= -DLUAJIT_LIBRARY=)