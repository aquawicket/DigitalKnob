# https://github.com/vancegroup/freealut
# http://distro.ibiblio.org/rootlinux/rootlinux-ports/more/freealut/freealut-1.1.0.tar.gz

### DEPENDS ###
dk_depend(msinttypes)
dk_depend(openal)


### IMPORT ###
dk_import(https://github.com/vancegroup/freealut.git PATCH)


### LINK ###
dk_define				(AL_LIBTYPE_STATIC)
dk_include				(${FREEALUT}/include)
if(MSVC)
	WIN_dk_libDebug		(${FREEALUT}/${OS}/src/${DEBUG_DIR}/alut_static.lib)
	WIN_dk_libRelease	(${FREEALUT}/${OS}/src/${RELEASE_DIR}/alut_static.lib)
elseif(APPLE OR ANDROID)
	dk_libDebug			(${FREEALUT}/${OS}/src/${DEBUG_DIR}/libalut_static.a)
	dk_libRelease		(${FREEALUT}/${OS}/src/${RELEASE_DIR}/libalut_static.a)
else()
	dk_libDebug			(${FREEALUT}/${OS}/${DEBUG_DIR}/src/libalut_static.a)
	dk_libRelease		(${FREEALUT}/${OS}/${RELEASE_DIR}/src/libalut_static.a)
endif()



### 3RDPARTY LINK ###
if(MSVC)
	WIN_dk_set			(FREEALUT_CMAKE "-DCMAKE_CXX_FLAGS=/I${FREEALUT}/include" -DALUT_INCLUDE_DIR=${FREEALUT}/include -DALUT_LIBRARY=${FREEALUT}/${OS}/src/${RELEASE_DIR}/alut_static.lib -DALUT_LIBRARY_DEBUG=${FREEALUT}/${OS}/src/${DEBUG_DIR}/alut_static.lib)
elseif(APPLE OR ANDROID)
	dk_set		(FREEALUT_CMAKE "-DCMAKE_CXX_FLAGS=-I${FREEALUT}/include" -DALUT_INCLUDE_DIR=${FREEALUT}/include -DALUT_LIBRARY=${FREEALUT}/${OS}/src/${RELEASE_DIR}/libalut_static.a -DALUT_LIBRARY_DEBUG=${FREEALUT}/${OS}/src/${DEBUG_DIR}/libalut_static.a)
else()
	dk_set	(FREEALUT_CMAKE "-DCMAKE_CXX_FLAGS=-I${FREEALUT}/include" -DALUT_INCLUDE_DIR=${FREEALUT}/include -DALUT_LIBRARY=${FREEALUT}/${OS}/${RELEASE_DIR}/src/libalut_static.a -DALUT_LIBRARY_DEBUG=${FREEALUT}/${OS}/${DEBUG_DIR}/src/libalut_static.a)
endif()



### GENERATE ###
if(MSVC)
	dk_queueCommand	(${DKCMAKE_BUILD} -DBUILD_STATIC=ON -DBUILD_TESTS=OFF -DBUILD_EXAMPLES=OFF ${OPENAL_CMAKE} ${MSINTTYPES_CMAKE} ${FREEALUT})
else()
	dk_queueCommand(${DKCMAKE_BUILD} -DBUILD_STATIC=ON -DBUILD_TESTS=OFF -DBUILD_EXAMPLES=OFF ${OPENAL_CMAKE} ${FREEALUT})
endif()



### COMPILE ###
ANDROID_dk_build	(${FREEALUT} alut_static)
APPLE_dk_build		(${FREEALUT} alut_static)
EMSCRIPTEN_dk_build	(${FREEALUT})
LINUX_dk_build		(${FREEALUT})
RASPBERRY_dk_build	(${FREEALUT})
WIN_dk_build		(${FREEALUT} alut_static)
