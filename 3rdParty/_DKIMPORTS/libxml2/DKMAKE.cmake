# https://github.com/GNOME/libxml2
# http://xmlsoft.org/sources/libxml2-2.9.8.tar.gz
# https://github.com/GNOME/libxml2/archive/refs/tags/v2.9.8.zip

### DEPENDS ###
dk_depend(libiconv)
dk_depend(xz)


dk_import(https://github.com/GNOME/libxml2/archive/f2ad86fa600885429a6083aaf6926c7e2e5b24d6.zip PATCH)
#dk_import(https://github.com/GNOME/libxml2.git f2ad86fa600885429a6083aaf6926c7e2e5b24d6 PATCH)


### LINK ###
dk_include			(${LIBXML2})
dk_include			(${LIBXML2}/include)
dk_include			(${LIBXML2}/${OS})
WIN_dk_libDebug		(${LIBXML2}/${OS}/${DEBUG_DIR}/xml2.lib)
WIN_dk_libRelease	(${LIBXML2}/${OS}/${RELEASE_DIR}/xml2.lib)
UNIX_dk_libDebug	(${LIBXML2}/${OS}/${DEBUG_DIR}/libxml2.a)
UNIX_dk_libRelease	(${LIBXML2}/${OS}/${RELEASE_DIR}/libxml2.a)


### 3RDPARTY LINK ###
WIN_dk_set	(LIBXML2_CMAKE -DLIBXML2_INCLUDE_DIR=${LIBXML2}/include -DLIBXML2_LIBRARIES=${LIBXML2}/${OS}/${RELEASE_DIR}/libxml2s.lib)
UNIX_dk_set	(LIBXML2_CMAKE -DLIBXML2_INCLUDE_DIR=${LIBXML2}/include -DLIBXML2_LIBRARIES=${LIBXML2}/${OS}/${RELEASE_DIR}/libxml2.a)


### GENERATE ###
dk_setPath					(${LIBXML2}/${BUILD_DIR})
WIN_dk_queueCommand			(${DKCMAKE_BUILD} ${LIBICONV_CMAKE} ${XZ_CMAKE} ${ZLIB_CMAKE} ${LIBXML2})
APPLE_dk_queueCommand		(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-I${LIBXML2}/${OS}" ${ZLIB_CMAKE} ${LIBXML2})
LINUX_dk_queueCommand		(${DKCONFIGURE_BUILD})
LINUX_dk_queueCommand		(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-DLIBXML_THREAD_ENABLED -DHAVE_ERRNO_H -I${LIBXML2}/${OS}/${DEBUG_DIR}" ${ZLIB_CMAKE} ${LIBXML2})
RASPBERRY_dk_queueCommand	(${DKCONFIGURE_BUILD})
RASPBERRY_dk_queueCommand	(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-DLIBXML_THREAD_ENABLED -DHAVE_ERRNO_H -I${LIBXML2}/${OS}/${RELEASE_DIR}" ${ZLIB_CMAKE} ${LIBXML2})
ANDROID_dk_msys				(${DKCONFIGURE_BUILD})
ANDROID_dk_queueCommand		(${DKCMAKE_BUILD} "-DANDROID_COMPILER_FLAGS=-I${LIBXML2}/${OS}" ${LIBICONV_CMAKE} ${ZLIB_CMAKE} ${LIBXML2})


### COMPILE ###
dk_build(${LIBXML2_FOLDER} xml2)
