# https://github.com/lua/lua.git
# https://www.lua.org/ftp/lua-5.4.3.tar.gz
# https://github.com/lubgr/lua-cmake.git


### IMPORT ###
dk_import(https://github.com/lua/lua.git PATCH)


### LINK ###
dk_include				(${LUA}/include)
dk_include				(${LUA}/${OS})
WIN_dk_libDebug			(${LUA}/${OS}/${DEBUG_DIR}/lua.lib)
WIN_dk_libRelease		(${LUA}/${OS}/${RELEASE_DIR}/lua.lib)
UNIX_dk_libDebug		(${LUA}/${OS}/${DEBUG_DIR}/liblua.a)
UNIX_dk_libRelease		(${LUA}/${OS}/${RELEASE_DIR}/liblua.a)


### 3RDPARTY LINK ###
WIN_DEBUG_dk_set			(LUA_CMAKE -DLUA_INCLUDE_DIR=${LUA} -DLUA_LIBRARIES=${LUA}/${OS}/${DEBUG_DIR}/lua.lib)
WIN_RELEASE_dk_set			(LUA_CMAKE -DLUA_INCLUDE_DIR=${LUA} -DLUA_LIBRARIES=${LUA}/${OS}/${RELEASE_DIR}/lua.lib)
APPLE_DEBUG_dk_set			(LUA_CMAKE -DLUA_INCLUDE_DIR=${LUA} -DLUA_LIBRARIES=${LUA}/${OS}/${DEBUG_DIR}/liblua.a)
APPLE_RELEASE_dk_set		(LUA_CMAKE -DLUA_INCLUDE_DIR=${LUA} -DLUA_LIBRARIES=${LUA}/${OS}/${RELEASE_DIR}/liblua.a)
LINUX_DEBUG_dk_set			(LUA_CMAKE -DLUA_INCLUDE_DIR=${LUA}/${OS}/${DEBUG_DIR}/include -DLUA_LIBRARIES=${LUA}/${OS}/${DEBUG_DIR}/liblua.a)
LINUX_RELEASE_dk_set		(LUA_CMAKE -DLUA_INCLUDE_DIR=${LUA}/${OS}/${RELEASE_DIR}/include -DLUA_LIBRARIES=${LUA}/${OS}/${RELEASE_DIR}/liblua.a)
RASPBERRY_DEBUG_dk_set		(LUA_CMAKE -DLUA_INCLUDE_DIR=${LUA}/${OS}/${DEBUG_DIR}/include -DLUA_LIBRARIES=${LUA}/${OS}/${DEBUG_DIR}/liblua.a)
RASPBERRY_RELEASE_dk_set	(LUA_CMAKE -DLUA_INCLUDE_DIR=${LUA}/${OS}/${RELEASE_DIR}/include -DLUA_LIBRARIES=${LUA}/${OS}/${RELEASE_DIR}/liblua.a)
ANDROID_DEBUG_dk_set		(LUA_CMAKE -DLUA_INCLUDE_DIR=${LUA} -DLUA_LIBRARIES=${LUA}/${OS}/${DEBUG_DIR}/liblua.a)
ANDROID_RELEASE_dk_set		(LUA_CMAKE -DLUA_INCLUDE_DIR=${LUA} -DLUA_LIBRARIES=${LUA}/${OS}/${RELEASE_DIR}/liblua.a)
EMSCRIPTEN_DEBUG_dk_set		(LUA_CMAKE -DLUA_INCLUDE_DIR=${LUA}/${OS}/${DEBUG_DIR}/include -DLUA_LIBRARIES=${LUA}/${OS}/${DEBUG_DIR}/liblua.a)
EMSCRIPTEN_RELEASE_dk_set	(LUA_CMAKE -DLUA_INCLUDE_DIR=${LUA}/${OS}/${RELEASE_DIR}/include -DLUA_LIBRARIES=${LUA}/${OS}/${RELEASE_DIR}/liblua.a)


### GENERATE ###
dk_queueCommand	(${DKCMAKE_BUILD} ${LUA})


### COMPILE ###
dk_build(${LUA} lua)
