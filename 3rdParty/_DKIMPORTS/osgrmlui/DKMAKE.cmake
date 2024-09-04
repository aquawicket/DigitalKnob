include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/triblatron/osgRmlUi


### IMPORT ###
#dk_import(https://github.com/triblatron/osgRmlUi/archive/621fad4fcbdd01306aba3f5c1112c8b03dc8a382.zip)
#dk_import(https://github.com/triblatron/osgRmlUi.git)
dk_import(https://github.com/triblatron/osgRmlUi/archive/refs/heads/master.zip)


### LINK ###
dk_include			(${OSGRMLUI}/include)
dk_include			(${OSGRMLUI}/${triple})
UNIX_dk_libDebug	(${OSGRMLUI}/${triple}/${DEBUG_DIR}/libosgrmlui.a)
UNIX_dk_libRelease	(${OSGRMLUI}/${triple}/${RELEASE_DIR}/libosgrmlui.a)
WIN_dk_libDebug		(${OSGRMLUI}/${triple}/${DEBUG_DIR}/osgrmlui.lib)
WIN_dk_libRelease	(${OSGRMLUI}/${triple}/${RELEASE_DIR}/osgrmlui.lib)


### GENERATE ###
dk_configure(${OSGRMLUI})


### COMPILE ###
dk_build(${OSGRMLUI})
