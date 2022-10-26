# https://github.com/LibVNC/libvncserver.git


### DEPEND ###
dk_depend(libjpeg-turbo)
dk_depend(libpng)
dk_depend(libsystemd-dev)
dk_depend(openssl)
dk_depend(zlib)


### IMPORT ###
dk_import(https://github.com/LibVNC/libvncserver.git)


### LINK ###
dk_include					(${LIBVNCSERVER})
dk_include					(${LIBVNCSERVER}/examples)
dk_include					(${LIBVNCSERVER}/${OS})
LINUX_DEBUG_dk_include		(${LIBVNCSERVER}/${OS}/${DEBUG_DIR})
LINUX_RELEASE_dk_include	(${LIBVNCSERVER}/${OS}/${RELEASE_DIR})
RASPBERRY_DEBUG_dk_include	(${LIBVNCSERVER}/${OS}/${DEBUG_DIR})
RASPBERRY_RELEASE_dk_include(${LIBVNCSERVER}/${OS}/${RELEASE_DIR})
WIN_dk_libDebug				(${LIBVNCSERVER}/${OS}/${DEBUG_DIR}/vncserver.lib)
WIN_dk_libRelease			(${LIBVNCSERVER}/${OS}/${RELEASE_DIR}/vncserver.lib)
WIN_dk_libDebug				(${LIBVNCSERVER}/${OS}/${DEBUG_DIR}/vncclient.lib)
WIN_dk_libRelease			(${LIBVNCSERVER}/${OS}/${RELEASE_DIR}/vncclient.lib)
MAC_dk_libDebug				(${LIBVNCSERVER}/${OS}/${DEBUG_DIR}/libvncserver.a)
MAC_dk_libRelease			(${LIBVNCSERVER}/${OS}/${RELEASE_DIR}/libvncserver.a)
MAC_dk_libDebug				(${LIBVNCSERVER}/${OS}/${DEBUG_DIR}/libvncclient.a)
MAC_dk_libRelease			(${LIBVNCSERVER}/${OS}/${RELEASE_DIR}/libvncclient.a)
IOSSIM_dk_libDebug			(${LIBVNCSERVER}/${OS}/${DEBUG_DIR}/lib/.libs/libvncserver.a)
IOSSIM_dk_libRelease		(${LIBVNCSERVER}/${OS}/${RELEASE_DIR}/lib/.libs/libvncserver.a)
LINUX_dk_libDebug			(${LIBVNCSERVER}/${OS}/${DEBUG_DIR}/libvncserver.a)
LINUX_dk_libRelease			(${LIBVNCSERVER}/${OS}/${RELEASE_DIR}/libvncserver.a)
LINUX_dk_libDebug			(${LIBVNCSERVER}/${OS}/${DEBUG_DIR}/libvncclient.a)
LINUX_dk_libRelease			(${LIBVNCSERVER}/${OS}/${RELEASE_DIR}/libvncclient.a)
ANDROID_dk_libDebug			(${LIBVNCSERVER}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libvncserver.a)
ANDROID_dk_libRelease		(${LIBVNCSERVER}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libvncserver.a)


### GENERATE ###
dk_setPath							(${LIBVNCSERVER}/${BUILD_DIR})
WIN_dk_queueCommand					(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-I${LIBJPEG-TURBO}/${OS}" ${OPENSSL_CMAKE} ${LIBPNG_CMAKE} ${ZLIB_CMAKE} -DWITH_JPEG=ON ${LIBJPEG-TURBO_CMAKE} ${LIBVNCSERVER})
APPLE_dk_queueCommand				(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-I${LIBJPEG-TURBO}/${OS} -I${OPENSSL}/include" ${OPENSSL_CMAKE} ${LIBPNG_CMAKE} ${ZLIB_CMAKE} -DWITH_JPEG=ON ${LIBJPEG-TURBO_CMAKE} ${LIBVNCSERVER})
LINUX_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-I${LIBJPEG-TURBO}/${OS}/Debug" ${OPENSSL_CMAKE} ${LIBPNG_CMAKE} ${ZLIB_CMAKE} -DWITH_JPEG=ON ${LIBJPEG-TURBO_CMAKE} ${LIBVNCSERVER})
LINUX_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-I${LIBJPEG-TURBO}/${OS}/Release" ${OPENSSL_CMAKE} ${LIBPNG_CMAKE} ${ZLIB_CMAKE} -DWITH_JPEG=ON ${LIBJPEG-TURBO_CMAKE} ${LIBVNCSERVER})
RASPBERRY_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-I${LIBJPEG-TURBO}/${OS}/Debug" ${OPENSSL_CMAKE} ${LIBPNG_CMAKE} ${ZLIB_CMAKE} -DWITH_JPEG=ON ${LIBJPEG-TURBO_CMAKE} ${LIBVNCSERVER})
RASPBERRY_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-I${LIBJPEG-TURBO}/${OS}/Release" ${OPENSSL_CMAKE} ${LIBPNG_CMAKE} ${ZLIB_CMAKE} -DWITH_JPEG=ON ${LIBJPEG-TURBO_CMAKE} ${LIBVNCSERVER})
ANDROID_dk_queueCommand				(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-I${LIBJPEG-TURBO}/${OS}" ${OPENSSL_CMAKE} ${LIBPNG_CMAKE} ${ZLIB_CMAKE} -DWITH_JPEG=ON ${LIBJPEG-TURBO_CMAKE} ${LIBVNCSERVER})


### COMPILE ###
dk_build(${LIBVNCSERVER_FOLDER} vncserver)
dk_build(${LIBVNCSERVER_FOLDER} vncclient)
