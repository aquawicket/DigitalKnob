# https://github.com/jasper-software/jasper.git


### IMPORT ###
dk_import(https://github.com/jasper-software/jasper.git)


### LINK ###
dk_include			(${JASPER}/include)
dk_include			(${JASPER}/${OS})
WIN_dk_libDebug		(${JASPER}/${OS}/${DEBUG_DIR}/jasper.lib)
WIN_dk_libRelease	(${JASPER}/${OS}/${RELEASE_DIR}/jasper.lib)
UNIX_dk_libDebug	(${JASPER}/${OS}/${DEBUG_DIR}/libjasper.a)
UNIX_dk_libRelease	(${JASPER}/${OS}/${RELEASE_DIR}/libjasper.a)


### GENERATE ###
dk_setPath(${JASPER}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} ${JASPER})


### COMPILE ###
dk_build(${JASPER_FOLDER})
