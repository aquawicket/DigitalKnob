# https://github.com/jasper-software/jasper.git


### IMPORT ###
dk_import(https://github.com/jasper-software/jasper.git)


### LINK ###
dk_include			(${JASPER}/include)
dk_include			(${JASPER}/${OS})
WIN_dk_libDebug		(${JASPER}/${OS}/src/libjasper/jasperd.lib)
WIN_dk_libRelease	(${JASPER}/${OS}/src/libjasper/jasper.lib)
UNIX_dk_libDebug	(${JASPER}/${OS}/src/libjasper/libjasperd.a)
UNIX_dk_libRelease	(${JASPER}/${OS}/src/libjasper/libjasper.a)


### GENERATE ###
dk_setPath(${JASPER}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} ${JASPER})


### COMPILE ###
dk_build(${JASPER_FOLDER})
