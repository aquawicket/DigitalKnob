# https://github.com/vancegroup/freealut
# http://distro.ibiblio.org/rootlinux/rootlinux-ports/more/freealut/freealut-1.1.0.tar.gz

### DEPENDS ###
dk_depend(msinttypes)
dk_depend(openal)


### IMPORT ###
dk_import(https://github.com/vancegroup/freealut.git PATCH)


### LINK ###
dk_define				(AL_LIBTYPE_STATIC)
dk_include				(${FREEALUT}/include									FREEALUT_INCLUDE_DIR)
if(MSVC)
	WIN_dk_libDebug		(${FREEALUT}/${OS}/src/${DEBUG_DIR}/alut_static.lib		FREEALUT_LIBRARY_DEBUG)
	WIN_dk_libRelease	(${FREEALUT}/${OS}/src/${RELEASE_DIR}/alut_static.lib	FREEALUT_LIBRARY_RELEASE)
elseif(APPLE OR ANDROID)
	dk_libDebug			(${FREEALUT}/${OS}/src/${DEBUG_DIR}/libalut_static.a	FREEALUT_LIBRARY_DEBUG)
	dk_libRelease		(${FREEALUT}/${OS}/src/${RELEASE_DIR}/libalut_static.a	FREEALUT_LIBRARY_RELEASE)
else()
	dk_libDebug			(${FREEALUT}/${OS}/${DEBUG_DIR}/src/libalut_static.a	FREEALUT_LIBRARY_DEBUG)
	dk_libRelease		(${FREEALUT}/${OS}/${RELEASE_DIR}/src/libalut_static.a	FREEALUT_LIBRARY_RELEASE)
endif()



### 3RDPARTY LINK ###
if(MSVC)
	WIN_dk_set	(FREEALUT_CMAKE "-DCMAKE_CXX_FLAGS=/I${FREEALUT_INCLUDE_DIR}" -DALUT_INCLUDE_DIR=${FREEALUT_INCLUDE_DIR} -DALUT_LIBRARY_DEBUG=${FREEALUT_LIBRARY_DEBUG} -DALUT_LIBRARY=${FREEALUT_LIBRARY_RELEASE})
else()
	dk_set		(FREEALUT_CMAKE "-DCMAKE_CXX_FLAGS=-I${FREEALUT_INCLUDE_DIR}" -DALUT_INCLUDE_DIR=${FREEALUT_INCLUDE_DIR} -DALUT_LIBRARY_DEBUG=${FREEALUT_LIBRARY_DEBUG} -DALUT_LIBRARY=${FREEALUT_LIBRARY_RELEASE})
endif()



### GENERATE ###
if(MSVC)
	dk_configure(${FREEALUT} -DBUILD_STATIC=ON -DBUILD_TESTS=OFF -DBUILD_EXAMPLES=OFF ${OPENAL_CMAKE} ${MSINTTYPES_CMAKE})
else()
	dk_configure(${FREEALUT} -DBUILD_STATIC=ON -DBUILD_TESTS=OFF -DBUILD_EXAMPLES=OFF ${OPENAL_CMAKE})
endif()



### COMPILE ###
ANDROID_dk_build	(${FREEALUT} alut_static)
APPLE_dk_build		(${FREEALUT} alut_static)
EMSCRIPTEN_dk_build	(${FREEALUT})
LINUX_dk_build		(${FREEALUT})
RASPBERRY_dk_build	(${FREEALUT})
WIN_dk_build		(${FREEALUT} alut_static)
