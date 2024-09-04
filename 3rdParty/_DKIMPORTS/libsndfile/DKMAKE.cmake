include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
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
#dk_import(https://github.com/libsndfile/libsndfile.git)
dk_import(https://github.com/libsndfile/libsndfile/archive/refs/heads/master.zip)


### LINK ###
dk_include			(${LIBSNDFILE}/include)
dk_include			(${LIBSNDFILE}/${triple})
UNIX_dk_libDebug	(${LIBSNDFILE}/${triple}/${DEBUG_DIR}/libsndfile.a)
UNIX_dk_libRelease	(${LIBSNDFILE}/${triple}/${RELEASE_DIR}/libsndfile.a)
WIN_dk_libDebug		(${LIBSNDFILE}/${triple}/${DEBUG_DIR}/sndfile.lib)
WIN_dk_libRelease	(${LIBSNDFILE}/${triple}/${RELEASE_DIR}/sndfile.lib)


### GENERATE ###
dk_configure(${LIBSNDFILE} ${FLAC_CMAKE} ${LAME_CMAKE} ${MPG123_CMAKE} ${OGG_CMAKE} ${OPUS_CMAKE} ${SPEEX_CMAKE} ${SQLITE_CMAKE} ${VORBIS_CMAKE})


### COMPILE ###
dk_build(${LIBSNDFILE})
