# https://github.com/arvidn/libtorrent
# https://github.com/arvidn/libtorrent/releases/download/libtorrent-1_1_3/libtorrent-rasterbar-1.1.3.tar.gz
# https://github.com/arvidn/libtorrent/archive/refs/tags/v2.0.4.zip

### DEPENDS ###
DKDEPEND(boost boost_system)
DKDEPEND(openssl)


dk_import(https://github.com/arvidn/libtorrent)
#dk_set(TORRENT_MAJOR 2)
#dk_set(TORRENT_MINOR 0)
#dk_set(TORRENT_BUILD 4)
#dk_set(TORRENT_VERSION ${TORRENT_MAJOR}.${TORRENT_MINOR}.${TORRENT_BUILD})
#dk_set(TORRENT_NAME libtorrent-${TORRENT_VERSION})
#dk_set(TORRENT_DL https://github.com/arvidn/libtorrent/archive/refs/tags/v${TORRENT_VERSION}.zip)
#dk_set(TORRENT ${3RDPARTY}/${TORRENT_NAME})
#DKINSTALL(${TORRENT_DL} libtorrent ${TORRENT})


### LINK ###
DKINCLUDE(${TORRENT}/include)
WIN_DEBUG_DKLIB(${TORRENT}/${OS}/${DEBUG_DIR}/torrent-rasterbar.lib)
WIN_RELEASE_DKLIB(${TORRENT}/${OS}/${RELEASE_DIR}/torrent-rasterbar.lib)
MAC_DEBUG_DKLIB(${TORRENT}/${OS}/lib/${DEBUG_DIR}/libtorrent-rasterbar.a)
MAC_RELEASE_DKLIB(${TORRENT}/${OS}/lib/${RELEASE_DIR}/libtorrent-rasterbar.a)
IOSSIM_DEBUG_DKLIB(${TORRENT}/${OS}/${DEBUG_DIR}/lib/.libs/libtorrent-rasterbar.a)
IOSSIM_RELEASE_DKLIB(${TORRENT}/${OS}/${RELEASE_DIR}/lib/.libs/libtorrent-rasterbar.a)
LINUX_DEBUG_DKLIB(${TORRENT}/${OS}/${DEBUG_DIR}/libtorrent-rasterbar.a)
LINUX_RELEASE_DKLIB(${TORRENT}/${OS}/${RELEASE_DIR}/libtorrent-rasterbar.a)
ANDROID_DEBUG_DKLIB(${TORRENT}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libtorrent-rasterbar.a)
ANDROID_RELEASE_DKLIB(${TORRENT}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libtorrent-rasterbar.a)


### COMPILE ###
WIN_DKSETPATH(${TORRENT}/${OS})
WIN32_DKQCOMMAND(${DKCMAKE_BUILD} -Dshared=OFF -Dunicode=OFF -Dstatic_runtime=ON ${OPENSSL_CMAKE} -DBOOST_ROOT=${BOOST} -DBOOST_LIBRARYDIR=${BOOST}/${OS}/lib ${TORRENT})
WIN64_DKQCOMMAND(${DKCMAKE_BUILD} -Dshared=OFF -Dunicode=OFF -Dstatic_runtime=ON ${OPENSSL_CMAKE} -DBOOST_ROOT=${BOOST} -DBOOST_LIBRARYDIR=${BOOST}/${OS}/lib ${TORRENT})
WIN_VS(${TORRENT_NAME} libtorrent.sln torrent-rasterbar)


MAC_DKSETPATH(${TORRENT}/${OS})
MAC64_DKQCOMMAND(${DKCMAKE_BUILD} ${TORRENT})
MAC_DEBUG_XCODE(${TORRENT_NAME} libtorrent-rasterbar)


IOS_DKSETPATH(${TORRENT}/${OS})
IOS_DKQCOMMAND(${DKCMAKE_BUILD} ${TORRENT})
IOS_XCODE(${TORRENT_NAME} libtorrent-rasterbar)

IOSSIM_DKSETPATH(${TORRENT}/${OS})
IOSSIM64_DKQCOMMAND(${DKCMAKE_BUILD} ${TORRENT})
IOSSIM_XCODE(${TORRENT_NAME} libtorrent-rasterbar)

LINUX_DEBUG_DKSETPATH(${TORRENT}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_DKQCOMMAND(${DKCMAKE_BUILD} ${TORRENT})
LINUX_DEBUG_DKQCOMMAND(make torrent-rasterbar)

LINUX_RELEASE_DKSETPATH(${TORRENT}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_DKQCOMMAND(${DKCMAKE_BUILD} ${TORRENT})
LINUX_RELEASE_DKQCOMMAND(make torrent-rasterbar)

ANDROID_NDK(${TORRENT_NAME})