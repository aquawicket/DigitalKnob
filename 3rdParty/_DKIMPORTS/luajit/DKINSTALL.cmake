#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


######## luajit ########
# https://github.com/LuaJIT/LuaJIT.git
# https://github.com/LuaJIT/LuaJIT/archive/refs/heads/v2.1.zip

dk_import()

#dk_import(https://github.com/tarantool/luajit.git BRANCH tarantool/master)
#dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
#dk_rename(${DK3RDPARTY_DIR}/luajit-tarantool/master ${DK3RDPARTY_DIR}/luajit OVERWRITE)
#dk_set(LUAJIT ${DK3RDPARTY_DIR}/luajit)
#dk_fileReplace(${LUAJIT}/CMakeLists.txt "  message(FATAL_ERROR" "  message(STATUS")

dk_libDebug(${luajit_Debug_Dir}/libluajit.a)
dk_libRelease(${luajit_Release_Dir}/libluajit.a)

dk_set(luajit_CMAKE -DLUAJIT_INCLUDE_DIR= -DLUAJIT_LIBRARY=)

dk_configure(${luajit})

#dk_build()
