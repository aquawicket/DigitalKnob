# https://github.com/libuv/libuv.git


### DEPEND ###
dk_depend(iphlpapi.lib)
dk_depend(userenv.lib)


### IMPORT ###
#dk_import(https://github.com/libuv/libuv/archive/2bc22c40eb68f3b38d1ae3ea68ef2f180cbe9fef.zip)
dk_import(https://github.com/libuv/libuv.git TAG 2bc22c40eb68f3b38d1ae3ea68ef2f180cbe9fef)
#dk_import(https://github.com/libuv/libuv.git)


### LINK ###
dk_include			(${LIBUV}/include)
dk_include			(${LIBUV}/${OS})
WIN_dk_libDebug		(${LIBUV}/${OS}/${DEBUG_DIR}/uv_a.lib)
WIN_dk_libRelease	(${LIBUV}/${OS}/${RELEASE_DIR}/uv_a.lib)
UNIX_dk_libDebug	(${LIBUV}/${OS}/${DEBUG_DIR}/libuv_a.a)
UNIX_dk_libRelease	(${LIBUV}/${OS}/${RELEASE_DIR}/libuv_a.a)


### 3RDPARTY LINK ###
WIN_DEBUG_dk_set	(LIBUV_CMAKE -DLIBUV_INCLUDE_DIR=${LIBUV} -DLIBUV_LIBRARY=${LIBUV}/${OS}/${DEBUG_DIR}/uv_a.lib)
WIN_RELEASE_dk_set	(LIBUV_CMAKE -DLIBUV_INCLUDE_DIR=${LIBUV} -DLIBUV_LIBRARY=${LIBUV}/${OS}/${RELEASE_DIR}/uv_a.lib)
UNIX_DEBUG_dk_set	(LIBUV_CMAKE -DLIBUV_INCLUDE_DIR=${LIBUV} -DLIBUV_LIBRARY=${LIBUV}/${OS}/${DEBUG_DIR}/uv_a.a)
UNIX_RELEASE_dk_set	(LIBUV_CMAKE -DLIBUV_INCLUDE_DIR=${LIBUV} -DLIBUV_LIBRARY=${LIBUV}/${OS}/${RELEASE_DIR}/uv_a.a)


### GENERATE ###
dk_queueCommand	(${DKCMAKE_BUILD} ${LIBUV})


### COMPILE ###
dk_build(${LIBUV} uv_a)
