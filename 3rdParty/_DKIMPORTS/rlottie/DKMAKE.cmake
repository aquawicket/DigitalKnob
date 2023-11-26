# https://github.com/Samsung/rlottie.git


### IMPORT ###
dk_import(https://github.com/Samsung/rlottie.git)


### LINK ###
dk_include				(${RLOTTIE}/inc)
dk_include				(${RLOTTIE}/${OS})
UNIX_dk_libDebug		(${RLOTTIE}/${OS}/${DEBUG_DIR}/librlottie.a)
UNIX_dk_libRelease		(${RLOTTIE}/${OS}/${RELEASE_DIR}/librlottie.a)
WIN_dk_libDebug			(${RLOTTIE}/${OS}/${DEBUG_DIR}/rlottie.lib)
WIN_dk_libRelease		(${RLOTTIE}/${OS}/${RELEASE_DIR}/rlottie.lib)


### GENERATE ###
UNIX_dk_queueCommand(${DKCMAKE_BUILD} ${RLOTTIE})
WIN_dk_queueCommand	(${DKCMAKE_BUILD} /EHsc ${RLOTTIE})


### COMPILE ###
dk_build(${RLOTTIE} rlottie)
