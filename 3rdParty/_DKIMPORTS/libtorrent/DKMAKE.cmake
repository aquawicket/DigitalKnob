# https://github.com/arvidn/libtorrent
# https://github.com/arvidn/libtorrent/releases/download/libtorrent-1_1_3/libtorrent-rasterbar-1.1.3.tar.gz
# https://github.com/arvidn/libtorrent/archive/refs/tags/v2.0.4.zip


### DEPENDS ###
dk_depend(boost boost_system)
dk_depend(openssl)


### IMPORT ###
dk_import(https://github.com/arvidn/libtorrent/archive/refs/tags/v2.0.7.zip)
#dk_import(https://github.com/arvidn/libtorrent.git)


### LINK ###
dk_include				(${LIBTORRENT}/include)
ANDROID_dk_libDebug		(${LIBTORRENT}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libtorrent-rasterbar.a)
ANDROID_dk_libRelease	(${LIBTORRENT}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libtorrent-rasterbar.a)
EMSCRIPTEN_dk_libDebug	(${LIBTORRENT}/${OS}/${DEBUG_DIR}/libtorrent-rasterbar.a)
EMSCRIPTEN_dk_libRelease(${LIBTORRENT}/${OS}/${RELEASE_DIR}/libtorrent-rasterbar.a)
IOSSIM_dk_libDebug		(${LIBTORRENT}/${OS}/${DEBUG_DIR}/lib/.libs/libtorrent-rasterbar.a)
IOSSIM_dk_libRelease	(${LIBTORRENT}/${OS}/${RELEASE_DIR}/lib/.libs/libtorrent-rasterbar.a)
LINUX_dk_libDebug		(${LIBTORRENT}/${OS}/${DEBUG_DIR}/libtorrent-rasterbar.a)
LINUX_dk_libRelease		(${LIBTORRENT}/${OS}/${RELEASE_DIR}/libtorrent-rasterbar.a)
MAC_dk_libDebug			(${LIBTORRENT}/${OS}/lib/${DEBUG_DIR}/libtorrent-rasterbar.a)
MAC_dk_libRelease		(${LIBTORRENT}/${OS}/lib/${RELEASE_DIR}/libtorrent-rasterbar.a)
WIN_dk_libDebug			(${LIBTORRENT}/${OS}/${DEBUG_DIR}/torrent-rasterbar.lib)
WIN_dk_libRelease		(${LIBTORRENT}/${OS}/${RELEASE_DIR}/torrent-rasterbar.lib)


### GENERATE ###
dk_queueCommand	(${DKCMAKE_BUILD} -Dshared=OFF -Dunicode=OFF -Dstatic_runtime=ON ${BOOST_CMAKE} ${OPENSSL_CMAKE} ${LIBTORRENT})


### COMPILE ###
dk_build(${LIBTORRENT})
#dk_build(${LIBTORRENT} torrent-rasterbar)
