if(NOT IOSSIM)
	return()
endif()
# https://github.com/guillemj/libmd
#
# https://github.com/guillemj/libmd/archive/refs/tags/1.0.4.zip

### DEPEND ###
DKDEPEND(autotools)


### VERSION ###
DKSET(LIBMD_VERSION 1.0.4)
DKSET(LIBMD_NAME libmd-${LIBMD_VERSION})
DKSET(LIBMD_DL https://github.com/guillemj/libmd/archive/refs/tags/${LIBMD_VERSION}.zip)
DKSET(LIBMD ${3RDPARTY}/${LIBMD_NAME})


### INSTALL ###
DKINSTALL(${LIBMD_DL} libmd ${LIBMD} NOPATCH)

### LINK ###
DKINCLUDE(${LIBMD}/include)
WIN_DEBUG_LIB(${LIBMD}/${OS}/${DEBUG_DIR}/libmdd.lib)
WIN_RELEASE_LIB(${LIBMD}/${OS}/${RELEASE_DIR}/libmd.lib)
APPLE_DEBUG_LIB(${LIBMD}/${OS}/${DEBUG_DIR}/liblibmdd.a)
APPLE_RELEASE_LIB(${LIBMD}/${OS}/${RELEASE_DIR}/liblibmd.a)
LINUX_DEBUG_LIB(${LIBMD}/${OS}/${DEBUG_DIR}/liblibmdd.a)
LINUX_RELEASE_LIB(${LIBMD}/${OS}/${RELEASE_DIR}/liblibmd.a)
RASPBERRY_DEBUG_LIB(${LIBMD}/${OS}/${DEBUG_DIR}/liblibmdd.a)
RASPBERRY_RELEASE_LIB(${LIBMD}/${OS}/${RELEASE_DIR}/liblibmd.a)
ANDROID_DEBUG_LIB(${LIBMD}/${OS}/${DEBUG_DIR}/liblibmdd.a)
ANDROID_RELEASE_LIB(${LIBMD}/${OS}/${RELEASE_DIR}/liblibmd.a)


### 3RDPARTY LINK ###
DKSET(LIBMD_WIN -DLIBMD_LIBRARY=${LIBMD}/${OS}/${DEBUG_DIR}/libmd.a)
DKSET(LIBMD_APPLE -DLIBMD_LIBRARY=${LIBMD}/${OS}/${DEBUG_DIR}/libmd.a)
DKSET(LIBMD_LINUX -DLIBMD_LIBRARY=${LIBMD}/${OS}/${DEBUG_DIR}/libmd.a)
DKSET(LIBMD_RASPBERRY -DLIBMD_LIBRARY=${LIBMD}/${OS}/${DEBUG_DIR}/libmd.a)
DKSET(LIBMD_ANDROID -DLIBMD_LIBRARY=${LIBMD}/${OS}/${DEBUG_DIR}/libmd.a)


### COMPILE ###
WIN32_DEBUG_PATH(${LIBMD}/${OS}/${DEBUG_DIR})
WIN32_DEBUG_MSYS(../../configure --disable-shared --enable-static --build=i686-w64-mingw32 CFLAGS=-march=i686)
WIN32_DEBUG_MSYS(make)
WIN32_RELEASE_PATH(${LIBMD}/${OS}/${RELEASE_DIR})
WIN32_RELEASE_MSYS(../../configure --disable-shared --enable-static --build=i686-w64-mingw32 CFLAGS=-march=i686)
WIN32_RELEASE_MSYS(make)


WIN64_DEBUG_PATH(${LIBMD}/${OS}/${DEBUG_DIR})
WIN64_DEBUG_MSYS(../../configure --disable-shared --enable-static --build=x86_64-w64-mingw32 CFLAGS=-march=x86-64)
WIN64_DEBUG_MSYS(make)
WIN64_RELEASE_PATH(${LIBMD}/${OS}/${RELEASE_DIR})
WIN64_RELEASE_MSYS(../../configure --disable-shared --enable-static --build=x86_64-w64-mingw32 CFLAGS=-march=x86-64)
WIN64_RELEASE_MSYS(make)


MAC_DEBUG_PATH(${LIBMD}/${OS}/${DEBUG_DIR})
MAC_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
MAC_DEBUG_COMMAND(make)# "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")
MAC_RELEASE_PATH(${LIBMD}/${OS}/${RELEASE_DIR})
MAC_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
MAC_RELEASE_COMMAND(make)# "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")


IOS_DEBUG_PATH(${LIBMD}/${OS}/${DEBUG_DIR})
IOS_DEBUG_COMMAND(../../configure --disable-shared --enable-static) #--arch-"armv7 armv7s")
IOS_DEBUG_COMMAND(make)
IOS_RELEASE_PATH(${LIBMD}/${OS}/${RELEASE_DIR})
IOS_RELEASE_COMMAND(../../configure --disable-shared --enable-static) #--arch-"armv7 armv7s")
IOS_RELEASE_COMMAND(make)


WIN32_DEBUG_PATH(${LIBMD})
IOSSIM_DEBUG_PATH(${LIBMD}/${OS}/${DEBUG_DIR})
IOSSIM_DEBUG_COMMAND(../../automake ../../configure --disable-shared --enable-static)
IOSSIM_DEBUG_COMMAND(make)
IOSSIM_RELEASE_PATH(${LIBMD}/${OS}/${RELEASE_DIR})
IOSSIM_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
IOSSIM_RELEASE_COMMAND(make)


LINUX_DEBUG_PATH(${LIBMD}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
LINUX_DEBUG_COMMAND(make)
LINUX_RELEASE_PATH(${LIBMD}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
LINUX_RELEASE_COMMAND(make)


RASPBERRY_DEBUG_PATH(${LIBMD}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
RASPBERRY_DEBUG_COMMAND(make)
RASPBERRY_RELEASE_PATH(${LIBMD}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
RASPBERRY_RELEASE_COMMAND(make)


ANDROID_NDK(${LIBMD_NAME})
#ANDROID_DEBUG_PATH(${LIBMD}/${OS}/${DEBUG_DIR})
#ANDROID_DEBUG_MSYS(../../configure --disable-shared --enable-static)
#ANDROID_DEBUG_MSYS(make)
#ANDROID_RELEASE_PATH(${LIBMD}/${OS}/${RELEASE_DIR})
#ANDROID_RELEASE_MSYS(../../configure --disable-shared --enable-static)
#ANDROID_RELEASE_MSYS(make)
