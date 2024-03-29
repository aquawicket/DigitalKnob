# https://github.com/madler/zlib
# http://www.zlib.net/


### IMPORT ###
dk_import(https://github.com/madler/zlib.git)


### LINK ###
dk_include			(${ZLIB})
dk_include			(${ZLIB}/${OS})
UNIX_dk_libDebug	(${ZLIB}/${OS}/${DEBUG_DIR}/libz.a)
UNIX_dk_libRelease	(${ZLIB}/${OS}/${RELEASE_DIR}/libz.a)
WIN_dk_libDebug		(${ZLIB}/${OS}/${DEBUG_DIR}/zlibstaticd.lib)
WIN_dk_libRelease	(${ZLIB}/${OS}/${RELEASE_DIR}/zlibstatic.lib)


## 3RDPARTY LINK ##
ANDROID_dk_set				(ZLIB_CMAKE -DZLIB_INCLUDE_DIR=${ZLIB} "-DCMAKE_C_FLAGS=-I${ZLIB}/${OS}" "-DCMAKE_CXX_FLAGS=-I${ZLIB}/${OS}" -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/${DEBUG_DIR}/libz.a -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE_DIR}/libz.a)
APPLE_dk_set				(ZLIB_CMAKE -DZLIB_INCLUDE_DIR=${ZLIB} "-DCMAKE_C_FLAGS=-I${ZLIB}/${OS}" "-DCMAKE_CXX_FLAGS=-I${ZLIB}/${OS}" -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/${DEBUG_DIR}/libz.a -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE_DIR}/libz.a)
EMSCRIPTEN_DEBUG_dk_set		(ZLIB_CMAKE -DZLIB_INCLUDE_DIR=${ZLIB} "-DCMAKE_C_FLAGS=-I${ZLIB} -I${ZLIB}/${OS}/${DEBUG_DIR}" "-DCMAKE_CXX_FLAGS=-I${ZLIB} -I${ZLIB}/${OS}/${DEBUG_DIR}" -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/${DEBUG_DIR}/libz.a -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE_DIR}/libz.a)
EMSCRIPTEN_RELEASE_dk_set	(ZLIB_CMAKE -DZLIB_INCLUDE_DIR=${ZLIB} "-DCMAKE_C_FLAGS=-I${ZLIB} -I${ZLIB}/${OS}/${RELEASE_DIR}" "-DCMAKE_CXX_FLAGS=-I${ZLIB} -I${ZLIB}/${OS}/${RELEASE_DIR}" -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/${DEBUG_DIR}/libz.a -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE_DIR}/libz.a)
LINUX_DEBUG_dk_set			(ZLIB_CMAKE -DZLIB_INCLUDE_DIR=${ZLIB} "-DCMAKE_C_FLAGS=-I${ZLIB}/${OS}/${DEBUG_DIR}" "-DCMAKE_CXX_FLAGS=-I${ZLIB}/${OS}/${DEBUG_DIR}" -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/${DEBUG_DIR}/libz.a -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE_DIR}/libz.a)
LINUX_RELEASE_dk_set		(ZLIB_CMAKE -DZLIB_INCLUDE_DIR=${ZLIB} "-DCMAKE_C_FLAGS=-I${ZLIB}/${OS}/${RELEASE_DIR}" "-DCMAKE_CXX_FLAGS=-I${ZLIB}/${OS}/${RELEASE_DIR}" -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/${DEBUG_DIR}/libz.a -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE_DIR}/libz.a)
RASPBERRY_DEBUG_dk_set		(ZLIB_CMAKE -DZLIB_INCLUDE_DIR=${ZLIB} "-DCMAKE_C_FLAGS=-I${ZLIB}/${OS}/${DEBUG_DIR}" "-DCMAKE_CXX_FLAGS=-I${ZLIB}/${OS}/${DEBUG_DIR}" -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/${DEBUG_DIR}/libz.a -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE_DIR}/libz.a)
RASPBERRY_RELEASE_dk_set	(ZLIB_CMAKE -DZLIB_INCLUDE_DIR=${ZLIB} "-DCMAKE_C_FLAGS=-I${ZLIB}/${OS}/${RELEASE_DIR}" "-DCMAKE_CXX_FLAGS=-I${ZLIB}/${OS}/${RELEASE_DIR}" -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/${DEBUG_DIR}/libz.a -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE_DIR}/libz.a)
WIN_dk_set					(ZLIB_CMAKE -DZLIB_INCLUDE_DIR=${ZLIB} "-DCMAKE_C_FLAGS=/I${ZLIB} /I${ZLIB}/${OS}" "-DCMAKE_CXX_FLAGS=/I${ZLIB} /I${ZLIB}/${OS}" -DZLIB_LIBRARY=${ZLIB}/${OS}/${RELEASE_DIR}/zlibstatic.lib -DZLIB_LIBRARY_DEBUG=${ZLIB}/${OS}/${DEBUG_DIR}/zlibstatic.lib -DZLIB_LIBRARY_RELEASE=${ZLIB}/${OS}/${RELEASE_DIR}/zlibstatic.lib)


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${ZLIB})


### COMPILE ###
dk_build(${ZLIB} zlibstatic)
