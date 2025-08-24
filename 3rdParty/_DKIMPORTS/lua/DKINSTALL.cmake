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

dk_validate(Target_Config  "dk_Target_Config()")

### IMPORT ###
dk_import(https://github.com/lua/lua/archive/fd0e1f53.zip PATCH)

### LINK ###
dk_include			(${LUA}/include							LUA_INCLUDE_DIR)
dk_include			(${LUA}/${Target_Tuple}							LUA_INCLUDE_DIR2)
Debug_dk_include	(${LUA.Debug_Dir}/include		LUA_INCLUDE_DIR2)
Release_dk_include	(${LUA.Release_Dir}/include	LUA_INCLUDE_DIR2)

if(MSVC)
	Windows_dk_libDebug		(${LUA.Debug_Dir}/lua.lib		LUA_DEBUG_LIBRARY)
	Windows_dk_libRelease	(${LUA.Release_Dir}/lua.lib	LUA_RELEASE_LIBRARY)
else()
	dk_libDebug			(${LUA.Debug_Dir}/liblua.a		LUA_DEBUG_LIBRARY)
	dk_libRelease		(${LUA.Release_Dir}/liblua.a	LUA_RELEASE_LIBRARY)
endif()

### 3RDPARTY LINK ###
#Debug_dk_set		(LUA_CMAKE -DLUA_INCLUDE_DIR=${LUA_INCLUDE_DIR} 	-DLUA_LIBRARIES=${LUA_DEBUG_LIBRARY} )
Debug_dk_set		(LUA_CMAKE -DLUA_INCLUDE_DIR=${LUA_INCLUDE_DIR2} 	-DLUA_LIBRARIES=${LUA_DEBUG_LIBRARY} )
Release_dk_set		(LUA_CMAKE -DLUA_INCLUDE_DIR=${LUA_INCLUDE_DIR} 	-DLUA_LIBRARIES=${LUA_RELEASE_LIBRARY} )

### GENERATE ###
dk_configure()

### COMPILE ###
dk_build(${LUA} lua)
