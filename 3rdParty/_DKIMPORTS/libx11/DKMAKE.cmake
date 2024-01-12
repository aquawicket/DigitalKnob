# https://github.com/mirror/libX11.git
# https://www.x.org/
# https://www.x.org/releases/individual/lib/
# https://www.x.org/releases/individual/lib/libX11-1.6.10.tar.gz


### IMPORT ###
dk_import(https://github.com/mirror/libX11/archive/refs/tags/libX11-1.8.1.zip)
#dk_import(https://github.com/mirror/libX11.git)


### LINK ###
dk_include			(${LIBX11}/include)
UNIX_dk_libDebug	(${LIBX11}/${OS}/${DEBUG_DIR}/liblibx11d.a)
UNIX_dk_libRelease	(${LIBX11}/${OS}/${RELEASE_DIR}/liblibx11.a)
WIN_dk_libDebug		(${LIBX11}/${OS}/${DEBUG_DIR}/libx11d.lib)
WIN_dk_libRelease	(${LIBX11}/${OS}/${RELEASE_DIR}/libx11.lib)


### GENERATE / COMPILE ###
DEBUG_dk_setPath		(${LIBX11}/${OS}/${DEBUG_DIR})
DEBUG_dk_queueCommand	(${DKCONFIGURE_BUILD})
DEBUG_dk_queueCommand	(make)
RELEASE_dk_setPath		(${LIBX11}/${OS}/${RELEASE_DIR})
RELEASE_dk_queueCommand	(${DKCONFIGURE_BUILD})
RELEASE_dk_queueCommand	(make)
