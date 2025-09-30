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


############ lua ############
# https://github.com/lua/lua.git
# https://www.lua.org/ftp/lua-5.4.3.tar.gz
# https://github.com/lubgr/lua-cmake.git
# https://github.com/lua/lua/archive/fd0e1f53.zip


### IMPORT ###
dk_import()

### LINK ###
dk_include			("${lua}/include"					LUA_INCLUDE_DIR)
dk_include			("${lua_Tuple_Dir}"					LUA_INCLUDE_DIR2)
dk_include			("${lua_Build_Dir}/include"			LUA_INCLUDE_DIR3)


if(Windows AND MSVC)
	dk_libDebug		(${lua_Debug_Dir}/lua.lib			LUA_DEBUG_LIBRARY	LUA_LIBRARY)
	dk_libRelease	(${lua_Release_Dir}/lua.lib			LUA_RELEASE_LIBRARY LUA_LIBRARY)
else()
	dk_libDebug		(${lua_Debug_Dir}/liblua.a			LUA_DEBUG_LIBRARY	LUA_LIBRARY)
	dk_libRelease	(${lua_Release_Dir}/liblua.a		LUA_RELEASE_LIBRARY	LUA_LIBRARY)
endif()

### 3RDPARTY LINK ###
dk_set		(lua_CMAKE -DLUA_INCLUDE_DIR=${LUA_INCLUDE_DIR} 	-DLUA_LIBRARIES=${LUA_LIBRARY})

### GENERATE ###
dk_configure()

### COMPILE ###
dk_build(${lua} lua)
