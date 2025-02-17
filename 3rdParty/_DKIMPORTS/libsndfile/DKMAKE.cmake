#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ libsndfile ############
# https://github.com/libsndfile/libsndfile.git
dk_load(dk_builder)

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
dk_import(https://github.com/libsndfile/libsndfile/archive/58c05b87.zip)

### LINK ###
dk_include			(${LIBSNDFILE}/include)
dk_include			(${LIBSNDFILE}/${target_triple})
if(MSVC)
	dk_libDebug		(${LIBSNDFILE_DEBUG_DIR}/sndfile.lib)
	dk_libRelease	(${LIBSNDFILE_RELEASE_DIR}/sndfile.lib)
else()
	dk_libDebug		(${LIBSNDFILE_DEBUG_DIR}/libsndfile.a)
	dk_libRelease	(${LIBSNDFILE_RELEASE_DIR}/libsndfile.a)
endif()

### GENERATE ###
dk_configure(${LIBSNDFILE} ${FLAC_CMAKE} ${LAME_CMAKE} ${MPG123_CMAKE} ${OGG_CMAKE} ${OPUS_CMAKE} ${SPEEX_CMAKE} ${SQLITE_CMAKE} ${VORBIS_CMAKE})

### COMPILE ###
dk_build(${LIBSNDFILE})
