# https://github.com/GNOME/libxml2
# http://xmlsoft.org/sources/libxml2-2.9.8.tar.gz
# https://github.com/GNOME/libxml2/archive/refs/tags/v2.9.8.zip


### DEPEND ###
dk_depend(libiconv)
dk_depend(xz)
dk_depend(zlib)


### IMPORT ###
dk_import(https://github.com/GNOME/libxml2.git TAG f2ad86fa600885429a6083aaf6926c7e2e5b24d6 PATCH)
#dk_import(https://github.com/GNOME/libxml2.git PATCH)


### LINK ###
dk_include	(${LIBXML2})
dk_include	(${LIBXML2}/include)
dk_include	(${LIBXML2}/${OS})

if(MSVC)
	WIN_dk_libDebug		(${LIBXML2}/${OS}/${DEBUG_DIR}/xml2.lib)
	WIN_dk_libRelease	(${LIBXML2}/${OS}/${RELEASE_DIR}/xml2.lib)
else()
	dk_libDebug			(${LIBXML2}/${OS}/${DEBUG_DIR}/libxml2.a)
	dk_libRelease		(${LIBXML2}/${OS}/${RELEASE_DIR}/libxml2.a)
endif()



### 3RDPARTY LINK ###
if(MSVC)
	WIN_dk_set	(LIBXML2_CMAKE -DLIBXML2_INCLUDE_DIR=${LIBXML2}/include -DLIBXML2_LIBRARY=${LIBXML2}/${OS}/${RELEASE_DIR}/libxml2s.lib -DLIBXML2_LIBRARIES=${LIBXML2}/${OS}/${RELEASE_DIR}/libxml2s.lib)
else()
	dk_set		(LIBXML2_CMAKE -DLIBXML2_INCLUDE_DIR=${LIBXML2}/include -DLIBXML2_LIBRARY=${LIBXML2}/${OS}/${RELEASE_DIR}/libxml2.a -DLIBXML2_LIBRARIES=${LIBXML2}/${OS}/${RELEASE_DIR}/libxml2.a)
endif()



### GENERATE ###
ANDROID_dk_queueCommand				(${DKCONFIGURE_BUILD})
ANDROID_dk_queueCommand				(${DKCMAKE_BUILD} "-DANDROID_COMPILER_FLAGS=-I${LIBXML2}/${OS}" ${LIBICONV_CMAKE} ${XZ_CMAKE} ${ZLIB_CMAKE} ${LIBXML2})

APPLE_dk_queueCommand				(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-I${LIBXML2}/${OS}" ${LIBICONV_CMAKE} ${XZ_CMAKE} ${ZLIB_CMAKE} ${LIBXML2})

#EMSCRIPTEN_dk_queueCommand			(${DKCONFIGURE_BUILD})
EMSCRIPTEN_DEBUG_dk_queueCommand	(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-DLIBXML_THREAD_ENABLED -DHAVE_ERRNO_H -I${LIBXML2}/${OS}/${DEBUG_DIR}" ${LIBICONV_CMAKE} ${XZ_CMAKE} ${ZLIB_CMAKE} ${LIBXML2})
EMSCRIPTEN_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-DLIBXML_THREAD_ENABLED -DHAVE_ERRNO_H -I${LIBXML2}/${OS}/${RELEASE_DIR}" ${LIBICONV_CMAKE} ${XZ_CMAKE} ${ZLIB_CMAKE} ${LIBXML2})

LINUX_dk_queueCommand				(${DKCONFIGURE_BUILD})
LINUX_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-DLIBXML_THREAD_ENABLED -DHAVE_ERRNO_H -I${LIBXML2}/${OS}/${DEBUG_DIR}" ${LIBICONV_CMAKE} ${XZ_CMAKE} ${ZLIB_CMAKE} ${LIBXML2})
LINUX_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-DLIBXML_THREAD_ENABLED -DHAVE_ERRNO_H -I${LIBXML2}/${OS}/${RELEASE_DIR}" ${LIBICONV_CMAKE} ${XZ_CMAKE} ${ZLIB_CMAKE} ${LIBXML2})

RASPBERRY_dk_queueCommand			(${DKCONFIGURE_BUILD})
RASPBERRY_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-DLIBXML_THREAD_ENABLED -DHAVE_ERRNO_H -I${LIBXML2}/${OS}/${DEBUG_DIR}" ${LIBICONV_CMAKE} ${XZ_CMAKE} ${ZLIB_CMAKE} ${LIBXML2})
RASPBERRY_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-DLIBXML_THREAD_ENABLED -DHAVE_ERRNO_H -I${LIBXML2}/${OS}/${RELEASE_DIR}" ${LIBICONV_CMAKE} ${XZ_CMAKE} ${ZLIB_CMAKE} ${LIBXML2})

#if(MSYS)
#	dk_queueCommand	(${DKCONFIGURE_BUILD})
#endif()
WIN_dk_queueCommand	(${DKCMAKE_BUILD} ${LIBICONV_CMAKE} ${XZ_CMAKE} ${ZLIB_CMAKE} ${LIBXML2})



### COMPILE ###
dk_build(${LIBXML2} xml2)
