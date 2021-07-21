### DEPENDS ###
DKDEPEND(boost Boost_System)
DKDEPEND(openssl-vs2015)


### VERSION ###
DKSET(TORRENT_VERSION libtorrent-rasterbar-1.1.3)
DKSET(TORRENT ${3RDPARTY}/${TORRENT_VERSION})


### INSTALL ###
## https://github.com/arvidn/libtorrent/releases/download/libtorrent-1_1_3/libtorrent-rasterbar-1.1.3.tar.gz
DKINSTALL(https://github.com/arvidn/libtorrent/releases/download/libtorrent-1_1_3/${TORRENT_VERSION}.tar.gz libtorrent ${TORRENT_VERSION})


### LINK ###
DKINCLUDE(${TORRENT}/include)
WIN_DEBUG_LIB(${TORRENT}/${OS}/Debug/torrent-rasterbar.lib)
WIN_RELEASE_LIB(${TORRENT}/${OS}/${RELEASE_DIR}/torrent-rasterbar.lib)
MAC_DEBUG_LIB(${TORRENT}/${OS}/lib/${DEBUG_DIR}/libtorrent-rasterbar.a)
MAC_RELEASE_LIB(${TORRENT}/${OS}/lib/${RELEASE_DIR}/libtorrent-rasterbar.a)
IOSSIM_DEBUG_LIB(${TORRENT}/${OS}/${DEBUG_DIR}/lib/.libs/libtorrent-rasterbar.a)
IOSSIM_RELEASE_LIB(${TORRENT}/${OS}/${RELEASE_DIR}/lib/.libs/libtorrent-rasterbar.a)
LINUX_DEBUG_LIB(${TORRENT}/${OS}/Debug/libtorrent-rasterbar.a)
LINUX_RELEASE_LIB(${TORRENT}/${OS}/${RELEASE_DIR}/libtorrent-rasterbar.a)
ANDROID_DEBUG_LIB(${TORRENT}/${OS}/Debug/obj/local/armeabi-v7a/libtorrent-rasterbar.a)
ANDROID_RELEASE_LIB(${TORRENT}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libtorrent-rasterbar.a)


### COMPILE ###
DKSETPATH(${TORRENT}/${OS})
WIN32_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A Win32 "-DCMAKE_C_FLAGS=/DTEST /DWIN32 /D_WINDOWS /W3 /nologo" "-DCMAKE_C_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_C_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" -Dshared=OFF -Dunicode=OFF -Dstatic_runtime=ON -DOPENSSL_ROOT_DIR=${OPENSSL} -DBOOST_ROOT=${BOOST} -DBOOST_LIBRARYDIR=${BOOST}/${OS}/lib ${TORRENT})
WIN32_VS_DEBUG(${TORRENT_VERSION} libtorrent.sln torrent-rasterbar)
WIN32_VS_RELEASE(${TORRENT_VERSION} libtorrent.sln torrent-rasterbar)

DKSETPATH(${TORRENT}/${OS})
WIN64_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A x64 "-DCMAKE_C_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo" "-DCMAKE_C_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_C_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" ${TORRENT})
WIN64_VS_DEBUG(libtorrent-master libtorrent.sln torrent-rasterbar)
WIN64_VS_RELEASE(${TORRENT_VERSION} libtorrent.sln torrent-rasterbar)

DKSETPATH(${TORRENT}/${OS})
MAC64_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DCMAKE_OSX_ARCHITECTURES=x86_64 ${TORRENT})
MAC64_XCODE_DEBUG(${TORRENT_VERSION} libtorrent-rasterbar)
MAC64_XCODE_RELEASE(${TORRENT_VERSION} libtorrent-rasterbar)

DKSETPATH(${TORRENT}/${OS})
IOS_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/iOS.cmake -DIOS_PLATFORM=OS ${TORRENT})
IOS_XCODE_DEBUG(${TORRENT_VERSION} libtorrent-rasterbar)
IOS_XCODE_RELEASE(${TORRENT_VERSION} libtorrent-rasterbar)

DKSETPATH(${TORRENT}/${OS})
IOSSIM_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/iOS.cmake -DIOS_PLATFORM=SIMULATOR ${TORRENT})
IOSSIM_XCODE_DEBUG(${TORRENT_VERSION} libtorrent-rasterbar)
IOSSIM_XCODE_RELEASE(${TORRENT_VERSION} libtorrent-rasterbar)

DKSETPATH(${TORRENT}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_COMMAND(${DKCMAKE_LINUX_DEBUG} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG -DCMAKE_C_FLAGS=-fPIC ${TORRENT})
LINUX_DEBUG_COMMAND(make torrent-rasterbar)

DKSETPATH(${TORRENT}/${OS}/${RELEASE_DIR})
LINUX_DEBUG_COMMAND(${DKCMAKE_LINUX_DEBUG} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_C_FLAGS=-fPIC ${TORRENT})
LINUX_RELEASE_COMMAND(make torrent-rasterbar)

ANDROID_NDK(${TORRENT_VERSION})