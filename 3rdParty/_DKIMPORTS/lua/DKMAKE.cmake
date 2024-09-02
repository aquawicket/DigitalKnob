include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/lua/lua.git
# https://www.lua.org/ftp/lua-5.4.3.tar.gz
# https://github.com/lubgr/lua-cmake.git


### IMPORT ###
#dk_import(https://github.com/lua/lua.git PATCH)
dk_import(https://github.com/lua/lua/archive/refs/heads/master.zip PATCH)


### LINK ###
dk_include			(${LUA}/include							LUA_INCLUDE_DIR)
dk_include			(${LUA}/${OS}							LUA_INCLUDE_DIR2)
DEBUG_dk_include	(${LUA}/${triple}/${DEBUG_DIR}/include		LUA_INCLUDE_DIR2)
RELEASE_dk_include	(${LUA}/${triple}/${RELEASE_DIR}/include	LUA_INCLUDE_DIR2)

if(MSVC)
	WIN_dk_libDebug		(${LUA}/${triple}/${DEBUG_DIR}/lua.lib		LUA_DEBUG_LIBRARY)
	WIN_dk_libRelease	(${LUA}/${triple}/${RELEASE_DIR}/lua.lib	LUA_RELEASE_LIBRARY)
else()
	dk_libDebug			(${LUA}/${triple}/${DEBUG_DIR}/liblua.a		LUA_DEBUG_LIBRARY)
	dk_libRelease		(${LUA}/${triple}/${RELEASE_DIR}/liblua.a	LUA_RELEASE_LIBRARY)
endif()


### 3RDPARTY LINK ###
#DEBUG_dk_set		(LUA_CMAKE -DLUA_INCLUDE_DIR=${LUA_INCLUDE_DIR} 	-DLUA_LIBRARIES=${LUA_DEBUG_LIBRARY} )
DEBUG_dk_set		(LUA_CMAKE -DLUA_INCLUDE_DIR=${LUA_INCLUDE_DIR2} 	-DLUA_LIBRARIES=${LUA_DEBUG_LIBRARY} )
RELEASE_dk_set		(LUA_CMAKE -DLUA_INCLUDE_DIR=${LUA_INCLUDE_DIR} 	-DLUA_LIBRARIES=${LUA_RELEASE_LIBRARY} )


### GENERATE ###
dk_configure(${LUA})


### COMPILE ###
dk_build(${LUA} lua)
