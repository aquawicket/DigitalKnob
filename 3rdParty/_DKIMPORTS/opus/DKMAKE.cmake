# https://github.com/xiph/opus.git


### IMPORT ###
dk_import(https://github.com/xiph/opus.git)


### LINK ###
dk_include			(${OPUS}/include)
dk_include			(${OPUS}/${OS})
WIN_dk_libDebug		(${OPUS}/${OS}/${DEBUG_DIR}/opus.lib)
WIN_dk_libRelease	(${OPUS}/${OS}/${RELEASE_DIR}/opus.lib)
UNIX_dk_libDebug	(${OPUS}/${OS}/${DEBUG_DIR}/libopus.a)
UNIX_dk_libRelease	(${OPUS}/${OS}/${RELEASE_DIR}/libopus.a)


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${OPUS})


### COMPILE ###
dk_build(${OPUS_FOLDER})
