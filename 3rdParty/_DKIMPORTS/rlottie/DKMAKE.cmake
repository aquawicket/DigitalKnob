# https://github.com/Samsung/rlottie
# https://github.com/Samsung/rlottie/archive/refs/tags/v0.2.zip
# https://github.com/Samsung/rlottie/archive/refs/heads/master.zip


### IMPORT ###
dk_import(https://github.com/Samsung/rlottie.git)


### LINK ###
dk_include				(${RLOTTIE}/inc)
dk_include				(${RLOTTIE}/${OS})
WIN_dk_libDebug			(${RLOTTIE}/${OS}/${DEBUG_DIR}/rlottie.lib)
WIN_dk_libRelease		(${RLOTTIE}/${OS}/${RELEASE_DIR}/rlottie.lib)
UNIX_dk_libDebug		(${RLOTTIE}/${OS}/${DEBUG_DIR}/librlottie.a)
UNIX_dk_libRelease		(${RLOTTIE}/${OS}/${RELEASE_DIR}/librlottie.a)


### GENERATE ###
WIN_dk_queueCommand	(${DKCMAKE_BUILD} /EHsc ${RLOTTIE})
UNIX_dk_queueCommand(${DKCMAKE_BUILD} ${RLOTTIE})


### COMPILE ###
dk_build(${RLOTTIE} rlottie)
