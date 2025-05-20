#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ lua ############
# https://github.com/lua/lua.git
# https://www.lua.org/ftp/lua-5.4.3.tar.gz
# https://github.com/lubgr/lua-cmake.git

dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/lua/lua/archive/fd0e1f53.zip PATCH)

### LINK ###
dk_include			(${LUA}/include							LUA_INCLUDE_DIR)
dk_include			(${LUA}/${Target_Tuple}							LUA_INCLUDE_DIR2)
Debug_dk_include	(${LUA_DEBUG_DIR}/include		LUA_INCLUDE_DIR2)
Release_dk_include	(${LUA_RELEASE_DIR}/include	LUA_INCLUDE_DIR2)

if(MSVC)
	Windows_dk_libDebug		(${LUA_DEBUG_DIR}/lua.lib		LUA_DEBUG_LIBRARY)
	Windows_dk_libRelease	(${LUA_RELEASE_DIR}/lua.lib	LUA_RELEASE_LIBRARY)
else()
	dk_libDebug			(${LUA_DEBUG_DIR}/liblua.a		LUA_DEBUG_LIBRARY)
	dk_libRelease		(${LUA_RELEASE_DIR}/liblua.a	LUA_RELEASE_LIBRARY)
endif()

### 3RDPARTY LINK ###
#Debug_dk_set		(LUA_CMAKE -DLUA_INCLUDE_DIR=${LUA_INCLUDE_DIR} 	-DLUA_LIBRARIES=${LUA_DEBUG_LIBRARY} )
Debug_dk_set		(LUA_CMAKE -DLUA_INCLUDE_DIR=${LUA_INCLUDE_DIR2} 	-DLUA_LIBRARIES=${LUA_DEBUG_LIBRARY} )
Release_dk_set		(LUA_CMAKE -DLUA_INCLUDE_DIR=${LUA_INCLUDE_DIR} 	-DLUA_LIBRARIES=${LUA_RELEASE_LIBRARY} )

### GENERATE ###
dk_configure(${LUA})

### COMPILE ###
dk_build(${LUA} lua)
