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


############ freealut ############
# https://github.com/vancegroup/freealut.git
# http://distro.ibiblio.org/rootlinux/rootlinux-ports/more/freealut/freealut-1.1.0.tar.gz
dk_validate(Target_Config  "dk_Target_Config()")

### DEPENDS ###
dk_depend(msinttypes)
dk_depend(openal)

### IMPORT ###
dk_import(https://github.com/vancegroup/freealut/archive/8abb4207.zip PATCH)

### LINK ###
dk_define			(AL_LIBTYPE_STATIC)
dk_include			(${FREEALUT}/include										ALUT_INCLUDE_DIR)
if(MSVC)
	dk_libDebug		(${FREEALUT}/${Target_Tuple}/src/${Debug_Dir}/alut_static.lib		ALUT_LIBRARY_DEBUG)
	dk_libRelease	(${FREEALUT}/${Target_Tuple}/src/${Release_Dir}/alut_static.lib	ALUT_LIBRARY_RELEASE)
elseif(Apple OR Android)
	dk_libDebug		(${FREEALUT}/${Target_Tuple}/src/${Debug_Dir}/libalut_static.a	ALUT_LIBRARY_DEBUG)
	dk_libRelease	(${FREEALUT}/${Target_Tuple}/src/${Release_Dir}/libalut_static.a	ALUT_LIBRARY_RELEASE)
else()
	dk_libDebug		(${FREEALUT.Debug_Dir}/src/libalut_static.a					ALUT_LIBRARY_DEBUG)
	dk_libRelease	(${FREEALUT.Release_Dir}/src/libalut_static.a				ALUT_LIBRARY_RELEASE)
endif()
if(Debug)
	set(ALUT_LIBRARY	${ALUT_LIBRARY_DEBUG})
endif()
if(Release)
	set(ALUT_LIBRARY	${ALUT_LIBRARY_RELEASE})
endif()

### 3RDPARTY LINK ###
if(MSVC)
	Windows_dk_set	(FREEALUT_CMAKE "-DCMAKE_CXX_FLAGS=/I${ALUT_INCLUDE_DIR}" -DALUT_INCLUDE_DIR=${ALUT_INCLUDE_DIR} -DALUT_LIBRARY_DEBUG=${ALUT_LIBRARY_DEBUG} -DALUT_LIBRARY=${ALUT_LIBRARY})
else()
	dk_set		(FREEALUT_CMAKE "-DCMAKE_CXX_FLAGS=-I${ALUT_INCLUDE_DIR}" -DALUT_INCLUDE_DIR=${ALUT_INCLUDE_DIR} -DALUT_LIBRARY_DEBUG=${ALUT_LIBRARY_DEBUG} -DALUT_LIBRARY=${ALUT_LIBRARY})
endif()

### GENERATE ###
if(MSVC)
	dk_configure(${FREEALUT} ${OPENAL_CMAKE} ${MSINTTYPES_CMAKE})
else()
	dk_configure(${FREEALUT} ${OPENAL_CMAKE})
endif()

### COMPILE ###
Android_dk_build	(${FREEALUT} alut_static)
Apple_dk_build		(${FREEALUT} alut_static)
Emscripten_dk_build	(${FREEALUT})
Linux_dk_build		(${FREEALUT})
Raspberry_dk_build	(${FREEALUT})
Windows_dk_build	(${FREEALUT} alut_static)
