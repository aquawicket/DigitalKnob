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


############ freealut ############
# https://github.com/vancegroup/freealut.git
# http://distro.ibiblio.org/rootlinux/rootlinux-ports/more/freealut/freealut-1.1.0.tar.gz
# https://github.com/vancegroup/freealut/archive/8abb4207.zip

dk_depend(msinttypes)
dk_depend(openal)

dk_import() # PATCH

dk_define			(AL_LIBTYPE_STATIC)
dk_include			(${freealut}/include										ALUT_INCLUDE_DIR)
if(MSVC)
	dk_libDebug		(${freealut_Tuple_Dir}/src/${Debug_Dir}/alut_static.lib		ALUT_LIBRARY_DEBUG		ALUT_LIBRARY)
	dk_libRelease	(${freealut_Tuple_Dir}/src/${Release_Dir}/alut_static.lib	ALUT_LIBRARY_RELEASE	ALUT_LIBRARY)
elseif(Apple OR Android)
	dk_libDebug		(${freealut_Tuple_Dir}/src/${Debug_Dir}/libalut_static.a	ALUT_LIBRARY_DEBUG		ALUT_LIBRARY)
	dk_libRelease	(${freealut_Tuple_Dir}/src/${Release_Dir}/libalut_static.a	ALUT_LIBRARY_RELEASE	ALUT_LIBRARY)
else()
	dk_libDebug		(${freealut_Build_Dir}/src/libalut_static.a					ALUT_LIBRARY_DEBUG		ALUT_LIBRARY)
	dk_libRelease	(${freealut_Build_Dir}/src/libalut_static.a					ALUT_LIBRARY_RELEASE	ALUT_LIBRARY)
endif()


dk_set(freealut_CMAKE 
	-DALUT_INCLUDE_DIR=${ALUT_INCLUDE_DIR} 
	-DALUT_LIBRARY_DEBUG=${ALUT_LIBRARY_DEBUG} 
	-DALUT_LIBRARY=${ALUT_LIBRARY})
if(MSVC)
	dk_append(freealut_CMAKE "-DCMAKE_CXX_FLAGS=/I${ALUT_INCLUDE_DIR}")
else()
	dk_append(freealut_CMAKE "-DCMAKE_CXX_FLAGS=-I${ALUT_INCLUDE_DIR}")
endif()


if(MSVC)
	dk_configure(${freealut} ${openal_CMAKE} ${msinttypes_CMAKE})
else()
	dk_configure(${freealut} ${openal_CMAKE})
endif()


if(Android OR Apple OR Windows)
	dk_build(${freealut} alut_static)
else()
	dk_build(${freealut})
endif()
