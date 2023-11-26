# https://github.com/libexpat/libexpat.git


### IMPORT ###
#dk_import(https://github.com/libexpat/libexpat/archive/f1a444ef64680ebd4ff89091a2c388cd046ece2d.zip)
dk_import(https://github.com/libexpat/libexpat.git)


### LINK ###
dk_include			(${LIBEXPAT}/include)
dk_include			(${LIBEXPAT}/${OS})
UNIX_dk_libDebug	(${LIBEXPAT}/${OS}/${DEBUG_DIR}/libexpat.a)
UNIX_dk_libRelease	(${LIBEXPAT}/${OS}/${RELEASE_DIR}/libexpat.a)
WIN_dk_libDebug		(${LIBEXPAT}/${OS}/${DEBUG_DIR}/libexpat.lib)
WIN_dk_libRelease	(${LIBEXPAT}/${OS}/${RELEASE_DIR}/libexpat.lib)


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${LIBEXPAT})


### COMPILE ###
dk_build(${LIBEXPAT})
