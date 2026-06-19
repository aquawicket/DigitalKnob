#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ libsndfile ############
# https://github.com/libsndfile/libsndfile.git

dk_depend(flac)
dk_depend(lame)
dk_depend(mpg123)
dk_depend(ogg)
dk_depend(opus)
#dk_depend(speex)
#dk_depend(sqlite)
dk_depend(vorbis)

dk_import(https://github.com/libsndfile/libsndfile/archive/58c05b87.zip)

dk_include			(${libsndfile}/include)
dk_include			(${libsndfile}/${Target_Tuple})
if(MSVC)
	dk_libDebug		(${libsndfile_Debug_Dir}/sndfile.lib)
	dk_libRelease	(${libsndfile_Release_Dir}/sndfile.lib)
else()
	dk_libDebug		(${libsndfile_Debug_Dir}/libsndfile.a)
	dk_libRelease	(${libsndfile_Release_Dir}/libsndfile.a)
endif()

dk_configure(${libsndfile} ${flac_CMAKE} ${LAME_CMAKE} ${MPG123_CMAKE} ${ogg_CMAKE} ${opus_CMAKE} ${SPEEX_CMAKE} ${SQLITE_CMAKE} ${vorbis_CMAKE})

dk_build()
