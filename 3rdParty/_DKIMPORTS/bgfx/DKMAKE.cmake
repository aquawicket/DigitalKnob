# https://github.com/bkaradzic/bgfx.git

### DEPENDS ###
#dk_depend(libname)


### INSTALL ###
dk_import(https://github.com/bkaradzic/bgfx.git)


### LINK ###
dk_include			(${BGFX}/include)
UNIX_dk_libDebug	(${BGFX}/${OS}/${DEBUG_DIR}/libbgfx.a)
UNIX_dk_libRelease	(${BGFX}/${OS}/${RELEASE_DIR}/libbgfx.a)
WIN_dk_libDebug		(${BGFX}/${OS}/${DEBUG_DIR}/bgfx.lib)
WIN_dk_libRelease	(${BGFX}/${OS}/${RELEASE_DIR}/bgfx.lib)


### GENERATE ###
dk_configure(${BGFX})


### COMPILE ###
dk_build(${BGFX})
