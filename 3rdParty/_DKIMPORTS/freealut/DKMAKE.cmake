#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ freealut ############
# https://github.com/vancegroup/freealut.git
# http://distro.ibiblio.org/rootlinux/rootlinux-ports/more/freealut/freealut-1.1.0.tar.gz
dk_load(dk_builder)

### DEPENDS ###
dk_depend(msinttypes)
dk_depend(openal)

### IMPORT ###
dk_import(https://github.com/vancegroup/freealut/archive/8abb4207.zip PATCH)

### LINK ###
dk_define			(AL_LIBTYPE_STATIC)
dk_include			(${FREEALUT}/include										ALUT_INCLUDE_DIR)
if(MSVC)
	dk_libDebug		(${FREEALUT}/${target_triple}/src/${DEBUG_DIR}/alut_static.lib		ALUT_LIBRARY_DEBUG)
	dk_libRelease	(${FREEALUT}/${target_triple}/src/${RELEASE_DIR}/alut_static.lib	ALUT_LIBRARY_RELEASE)
elseif(APPLE OR ANDROID)
	dk_libDebug		(${FREEALUT}/${target_triple}/src/${DEBUG_DIR}/libalut_static.a	ALUT_LIBRARY_DEBUG)
	dk_libRelease	(${FREEALUT}/${target_triple}/src/${RELEASE_DIR}/libalut_static.a	ALUT_LIBRARY_RELEASE)
else()
	dk_libDebug		(${FREEALUT_DEBUG_DIR}/src/libalut_static.a					ALUT_LIBRARY_DEBUG)
	dk_libRelease	(${FREEALUT_RELEASE_DIR}/src/libalut_static.a				ALUT_LIBRARY_RELEASE)
endif()
if(DEBUG)
	set(ALUT_LIBRARY	${ALUT_LIBRARY_DEBUG})
endif()
if(RELEASE)
	set(ALUT_LIBRARY	${ALUT_LIBRARY_RELEASE})
endif()

### 3RDPARTY LINK ###
if(MSVC)
	WIN_dk_set	(FREEALUT_CMAKE "-DCMAKE_CXX_FLAGS=/I${ALUT_INCLUDE_DIR}" -DALUT_INCLUDE_DIR=${ALUT_INCLUDE_DIR} -DALUT_LIBRARY_DEBUG=${ALUT_LIBRARY_DEBUG} -DALUT_LIBRARY=${ALUT_LIBRARY})
else()
	dk_set		(FREEALUT_CMAKE "-DCMAKE_CXX_FLAGS=-I${ALUT_INCLUDE_DIR}" -DALUT_INCLUDE_DIR=${ALUT_INCLUDE_DIR} -DALUT_LIBRARY_DEBUG=${ALUT_LIBRARY_DEBUG} -DALUT_LIBRARY=${ALUT_LIBRARY})
endif()

### GENERATE ###
if(MSVC)
	dk_configure(${FREEALUT_DIR} ${OPENAL_CMAKE} ${MSINTTYPES_CMAKE})
else()
	dk_configure(${FREEALUT_DIR} ${OPENAL_CMAKE})
endif()

### COMPILE ###
ANDROID_dk_build	(${FREEALUT_DIR} alut_static)
APPLE_dk_build		(${FREEALUT_DIR} alut_static)
EMSCRIPTEN_dk_build	(${FREEALUT_DIR})
LINUX_dk_build		(${FREEALUT_DIR})
RASPBERRY_dk_build	(${FREEALUT_DIR})
WIN_dk_build		(${FREEALUT_DIR} alut_static)
