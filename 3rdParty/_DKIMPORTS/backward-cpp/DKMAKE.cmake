# https://github.com/bombela/backward-cpp.git


### IMPORT ###
dk_import(https://github.com/bombela/backward-cpp.git)


### LINK ###
dk_include			(${BACKWARD-CPP})
WIN_dk_libDebug		(${BACKWARD-CPP}/${OS}/${DEBUG_DIR}/backward.lib)
WIN_dk_libRelease	(${BACKWARD-CPP}/${OS}/${RELEASE_DIR}/backward.lib)
UNIX_dk_libDebug	(${BACKWARD-CPP}/${OS}/${DEBUG_DIR}/libbackward.a)
UNIX_dk_libRelease	(${BACKWARD-CPP}/${OS}/${RELEASE_DIR}/libbackward.a)


### GENERATE ###
dk_setPath		(${BACKWARD-CPP}/${BUILD_DIR})
dk_queueCommand	(${DKCMAKE_BUILD} ${BACKWARD-CPP})


### COMPILE ###
dk_build(${BACKWARD-CPP_FOLDER})
