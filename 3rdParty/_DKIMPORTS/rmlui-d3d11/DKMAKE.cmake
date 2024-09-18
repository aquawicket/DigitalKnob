include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://www.github.com/martonp96/RmlUi-D3D11.git


### IMPORT ###
#dk_import(https://www.github.com/martonp96/RmlUi-D3D11.git)
dk_import(https://github.com/martonp96/RmlUi-D3D11/archive/refs/heads/master.zip)


### LINK ###
dk_include			(${RMLUI_D3D11}/include)
dk_include			(${RMLUI_D3D11}/${triple})
WIN_dk_libDebug		(${RMLUI_D3D11}/${triple}/${DEBUG_DIR}/rmlui-d3d11.lib)
WIN_dk_libRelease	(${RMLUI_D3D11}/${triple}/${RELEASE_DIR}/rmlui-d3d11.lib)
UNIX_dk_libDebug	(${RMLUI_D3D11}/${triple}/${DEBUG_DIR}/librmlui-d3d11.a)
UNIX_dk_libRelease	(${RMLUI_D3D11}/${triple}/${RELEASE_DIR}/librmlui-d3d11.a)


### GENERATE ###
dk_configure(${RMLUI_D3D11})


### COMPILE ###
dk_build(${RMLUI_D3D11})
