#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ libsndfile ############
# https://github.com/libsndfile/libsndfile.git
dk_validate(Target_Config  "dk_Target_Config()")

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
dk_include			(${LIBSNDFILE}/${Target_Tuple})
if(MSVC)
	dk_libDebug		(${LIBSNDFILE_Debug_Dir}/sndfile.lib)
	dk_libRelease	(${LIBSNDFILE_Release_Dir}/sndfile.lib)
else()
	dk_libDebug		(${LIBSNDFILE_Debug_Dir}/libsndfile.a)
	dk_libRelease	(${LIBSNDFILE_Release_Dir}/libsndfile.a)
endif()

### GENERATE ###
dk_configure(${LIBSNDFILE} ${FLAC_CMAKE} ${LAME_CMAKE} ${MPG123_CMAKE} ${OGG_CMAKE} ${OPUS_CMAKE} ${SPEEX_CMAKE} ${SQLITE_CMAKE} ${VORBIS_CMAKE})

### COMPILE ###
dk_build()
