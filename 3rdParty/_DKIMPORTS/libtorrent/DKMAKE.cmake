### DEPENDS ###
DKDEPEND(boost Boost_System)
DKDEPEND(openssl-vs2015)


### VERSION ###
DKSET(TORRENT_VERSION 1.1.3)
DKSET(TORRENT_NAME libtorrent-${TORRENT_VERSION})
DKSET(TORRENT ${3RDPARTY}/${TORRENT_NAME})


### INSTALL ###
## https://github.com/arvidn/libtorrent/releases/download/libtorrent-1_1_3/libtorrent-rasterbar-1.1.3.tar.gz
DKINSTALL(https://github.com/arvidn/libtorrent/releases/download/libtorrent-1_1_3/${TORRENT_NAME}.tar.gz libtorrent ${TORRENT})


### LINK ###
DKINCLUDE(${TORRENT}/include)
WIN_DEBUG_LIB(${TORRENT}/${OS}/${DEBUG_DIR}/torrent-rasterbar.lib)
WIN_RELEASE_LIB(${TORRENT}/${OS}/${RELEASE_DIR}/torrent-rasterbar.lib)
MAC_DEBUG_LIB(${TORRENT}/${OS}/lib/${DEBUG_DIR}/libtorrent-rasterbar.a)
MAC_RELEASE_LIB(${TORRENT}/${OS}/lib/${RELEASE_DIR}/libtorrent-rasterbar.a)
IOSSIM_DEBUG_LIB(${TORRENT}/${OS}/${DEBUG_DIR}/lib/.libs/libtorrent-rasterbar.a)
IOSSIM_RELEASE_LIB(${TORRENT}/${OS}/${RELEASE_DIR}/lib/.libs/libtorrent-rasterbar.a)
LINUX_DEBUG_LIB(${TORRENT}/${OS}/${DEBUG_DIR}/libtorrent-rasterbar.a)
LINUX_RELEASE_LIB(${TORRENT}/${OS}/${RELEASE_DIR}/libtorrent-rasterbar.a)
ANDROID_DEBUG_LIB(${TORRENT}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libtorrent-rasterbar.a)
ANDROID_RELEASE_LIB(${TORRENT}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libtorrent-rasterbar.a)


### COMPILE ###
WIN_PATH(${TORRENT}/${OS})
WIN32_COMMAND(${DKCMAKE_WIN32} -Dshared=OFF -Dunicode=OFF -Dstatic_runtime=ON -DOPENSSL_ROOT_DIR=${OPENSSL} -DBOOST_ROOT=${BOOST} -DBOOST_LIBRARYDIR=${BOOST}/${OS}/lib ${TORRENT})
WIN64_COMMAND(${DKCMAKE_WIN64} -Dshared=OFF -Dunicode=OFF -Dstatic_runtime=ON -DOPENSSL_ROOT_DIR=${OPENSSL} -DBOOST_ROOT=${BOOST} -DBOOST_LIBRARYDIR=${BOOST}/${OS}/lib ${TORRENT})
WIN_VS(${TORRENT_NAME} libtorrent.sln torrent-rasterbar)


MAC_PATH(${TORRENT}/${OS})
MAC64_COMMAND(${DKCMAKE_MAC64} ${TORRENT})
MAC_XCODE_DEBUG(${TORRENT_NAME} libtorrent-rasterbar)


IOS_PATH(${TORRENT}/${OS})
IOS_COMMAND(${DKCMAKE_IOS64} ${TORRENT})
IOS_XCODE(${TORRENT_NAME} libtorrent-rasterbar)

IOSSIM_PATH(${TORRENT}/${OS})
IOSSIM64_COMMAND(${DKCMAKE_IOSSIM64} ${TORRENT})
IOSSIM_XCODE(${TORRENT_NAME} libtorrent-rasterbar)

LINUX_DEBUG_PATH(${TORRENT}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_COMMAND(${DKCMAKE_LINUX_DEBUG} -DCMAKE_C_FLAGS=-fPIC ${TORRENT})
LINUX_DEBUG_COMMAND(make torrent-rasterbar)

LINUX_RELEASE_PATH(${TORRENT}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_COMMAND(${DKCMAKE_LINUX_RELEASE} -DCMAKE_C_FLAGS=-fPIC ${TORRENT})
LINUX_RELEASE_COMMAND(make torrent-rasterbar)

ANDROID_NDK(${TORRENT_NAME})