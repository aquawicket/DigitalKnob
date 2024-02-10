# https://github.com/madler/zlib
# http://www.zlib.net/


### IMPORT ###
dk_import(https://github.com/madler/zlib.git)


### LINK ###
dk_include				(${ZLIB}										ZLIB_INCLUDE_DIR)
dk_include				(${ZLIB}/${OS})
DEBUG_dk_include		(${ZLIB}/${OS}/${DEBUG_DIR})
RELEASE_dk_include		(${ZLIB}/${OS}/${RELEASE_DIR})
if(MSVC)
	WIN_dk_libDebug		(${ZLIB}/${OS}/${DEBUG_DIR}/zlibstaticd.lib		ZLIB_LIBRARY_DEBUG)
	WIN_dk_libRelease	(${ZLIB}/${OS}/${RELEASE_DIR}/zlibstatic.lib	ZLIB_LIBRARY_RELEASE)
else()
	if(MSYS)
		dk_libDebug		(${ZLIB}/${OS}/${DEBUG_DIR}/libzlibstatic.a		ZLIB_LIBRARY_DEBUG)
		dk_libRelease	(${ZLIB}/${OS}/${RELEASE_DIR}/libzlibstatic.a	ZLIB_LIBRARY_RELEASE)
	else()
		dk_libDebug		(${ZLIB}/${OS}/${DEBUG_DIR}/libz.a				ZLIB_LIBRARY_DEBUG)
		dk_libRelease	(${ZLIB}/${OS}/${RELEASE_DIR}/libz.a			ZLIB_LIBRARY_RELEASE)
	endif()
endif()


## 3RDPARTY LINK ##
if(MULTI_CONFIG)
	dk_set			(ZLIB_CMAKE -DZLIB_INCLUDE_DIR=${ZLIB_INCLUDE_DIR} -DZLIB_LIBRARY_DEBUG=${ZLIB_LIBRARY_DEBUG} -DZLIB_LIBRARY_RELEASE=${ZLIB_LIBRARY_RELEASE} "-DCMAKE_C_FLAGS=/I${ZLIB} /I${ZLIB}/${OS}" "-DCMAKE_CXX_FLAGS=/I${ZLIB} /I${ZLIB}/${OS}")
else()
	DEBUG_dk_set	(ZLIB_CMAKE -DZLIB_INCLUDE_DIR=${ZLIB_INCLUDE_DIR} -DZLIB_LIBRARY_DEBUG=${ZLIB_LIBRARY_DEBUG} "-DCMAKE_C_FLAGS=-I${ZLIB} -I${ZLIB}/${OS}/${DEBUG_DIR}" "-DCMAKE_CXX_FLAGS=-I${ZLIB} -I${ZLIB}/${OS}/${DEBUG_DIR}")
	RELEASE_dk_set	(ZLIB_CMAKE -DZLIB_INCLUDE_DIR=${ZLIB_INCLUDE_DIR} -DZLIB_LIBRARY_RELEASE=${ZLIB_LIBRARY_RELEASE} "-DCMAKE_C_FLAGS=-I${ZLIB} -I${ZLIB}/${OS}/${RELEASE_DIR}" "-DCMAKE_CXX_FLAGS=-I${ZLIB} -I${ZLIB}/${OS}/${RELEASE_DIR}")
endif()


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${ZLIB})


### COMPILE ###
dk_build(${ZLIB} zlibstatic)
