# https://github.com/libsndfile/libsndfile.git


### DEPEND ###
dk_depend(flac)
dk_depend(lame)
dk_depend(mpg123)
dk_depend(ogg)
dk_depend(opus)
#dk_depend(speex)
#dk_depend(sqlite)
dk_depend(vorbis)


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
#dk_setPath(${LIBSNDFILE}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} ${FLAC_CMAKE} ${LAME_CMAKE} ${MPG123_CMAKE} ${OGG_CMAKE} ${OPUS_CMAKE} ${SPEEX_CMAKE} ${SQLITE_CMAKE} ${VORBIS_CMAKE} ${LIBSNDFILE})


### COMPILE ###
dk_build(${LIBSNDFILE_FOLDER})
