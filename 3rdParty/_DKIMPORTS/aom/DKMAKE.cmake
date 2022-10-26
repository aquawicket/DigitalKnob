# https://aomedia.googlesource.com/aom.git


### IMPORT ###
dk_import(https://aomedia.googlesource.com/aom.git)


### LINK ###
dk_include(${AOM})
WIN_dk_libDebug		(${AOM}/${OS}/${DEBUG_DIR}/aom.lib)
WIN_dk_libRelease	(${AOM}/${OS}/${RELEASE_DIR}/aom.lib)
UNIX_dk_libDebug	(${AOM}/${OS}/${DEBUG_DIR}/libaom.a)
UNIX_dk_libRelease	(${AOM}/${OS}/${RELEASE_DIR}/libaom.a)


### GENERATE ###
dk_setPath		(${AOM}/${BUILD_DIR})
dk_queueCommand	(${DKCMAKE_BUILD} -DAOM_TARGET_CPU=generic ${AOM})


### COMPILE ###
dk_build(${AOM_FOLDER})
