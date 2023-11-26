# https://github.com/jbruchon/libjodycode.git


### INSTALL ###
dk_import(https://github.com/jbruchon/libjodycode.git)


### LINK ###
dk_include			(${LIBJODYCODE}/include)
UNIX_dk_libDebug	(${LIBJODYCODE}/${OS}/${DEBUG_DIR}/libjodycode.a)
UNIX_dk_libRelease	(${LIBJODYCODE}/${OS}/${RELEASE_DIR}/libjodycode.a)
WIN_dk_libDebug		(${LIBJODYCODE}/${OS}/${DEBUG_DIR}/libjodycode.lib)
WIN_dk_libRelease	(${LIBJODYCODE}/${OS}/${RELEASE_DIR}/libjodycode.lib)


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${LIBJODYCODE})


### COMPILE ###
dk_build(${LIBJODYCODE} libjodycode)
