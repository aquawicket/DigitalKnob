include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/jbruchon/libjodycode.git


### INSTALL ###
dk_import(https://github.com/jbruchon/libjodycode.git)


### LINK ###
dk_include			(${LIBJODYCODE}/include)
UNIX_dk_libDebug	(${LIBJODYCODE}/${triple}/${DEBUG_DIR}/libjodycode.a)
UNIX_dk_libRelease	(${LIBJODYCODE}/${triple}/${RELEASE_DIR}/libjodycode.a)
WIN_dk_libDebug		(${LIBJODYCODE}/${triple}/${DEBUG_DIR}/libjodycode.lib)
WIN_dk_libRelease	(${LIBJODYCODE}/${triple}/${RELEASE_DIR}/libjodycode.lib)


### GENERATE ###
dk_configure(${LIBJODYCODE_DIR})


### COMPILE ###
dk_build(${LIBJODYCODE_DIR} libjodycode)
