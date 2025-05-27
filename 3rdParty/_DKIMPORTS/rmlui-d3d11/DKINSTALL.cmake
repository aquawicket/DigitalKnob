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


dk_validate(CONFIG_PATH  "dk_CONFIG_PATH()")
# https://www.github.com/martonp96/RmlUi-D3D11.git


### IMPORT ###
#dk_import(https://www.github.com/martonp96/RmlUi-D3D11.git)
dk_import(https://github.com/martonp96/RmlUi-D3D11/archive/refs/heads/master.zip)


### LINK ###
dk_include			(${RMLUI_D3D11}/include)
dk_include			(${RMLUI_D3D11}/${Target_Tuple})
Windows_dk_libDebug		(${RMLUI_D3D11_DEBUG_DIR}/rmlui-d3d11.lib)
Windows_dk_libRelease	(${RMLUI_D3D11_RELEASE_DIR}/rmlui-d3d11.lib)
UNIX_dk_libDebug	(${RMLUI_D3D11_DEBUG_DIR}/librmlui-d3d11.a)
UNIX_dk_libRelease	(${RMLUI_D3D11_RELEASE_DIR}/librmlui-d3d11.a)


### GENERATE ###
dk_configure(${RMLUI_D3D11})


### COMPILE ###
dk_build(${RMLUI_D3D11})
