# https://github.com/libsndfile/libsndfile.git


### IMPORT ###
dk_import(https://github.com/libsndfile/libsndfile.git)


### LINK ###
dk_include			(${LIBSNDFILE}/include)
dk_include			(${LIBSNDFILE}/${OS})
WIN_dk_libDebug		(${LIBSNDFILE}/${OS}/${DEBUG_DIR}/sndfile.lib)
WIN_dk_libRelease	(${LIBSNDFILE}/${OS}/${RELEASE_DIR}/sndfile.lib)
UNIX_dk_libDebug	(${LIBSNDFILE}/${OS}/${DEBUG_DIR}/libsndfile.a)
UNIX_dk_libRelease	(${LIBSNDFILE}/${OS}/${RELEASE_DIR}/libsndfile.a)


### GENERATE ###
dk_setPath(${LIBSNDFILE}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} ${LIBSNDFILE})


### COMPILE ###
dk_build(${LIBSNDFILE_FOLDER})