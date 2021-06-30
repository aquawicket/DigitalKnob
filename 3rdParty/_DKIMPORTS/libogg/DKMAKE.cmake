### VERSION ###
DKSET(OGG_VERSION 1.3.2)

### INSTALL ###
DKINSTALL(https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-${OGG_VERSION}.zip libogg libogg-${OGG_VERSION})
DKSET(OGG ${3RDPARTY}/libogg-${OGG_VERSION})


### LINK ###
DKINCLUDE(${OGG}/include)
ANDROID_INCLUDE(${OGG}/${OS})
WIN_DEBUG_LIB(${OGG}/${OS}/${DEBUG}/src/.libs/libogg.lib)
WIN_RELEASE_LIB(${OGG}/${OS}/${RELEASE}/src/.libs/libogg.lib)
APPLE_DEBUG_LIB(${OGG}/${OS}/${DEBUG}/src/.libs/libogg.a)
APPLE_RELEASE_LIB(${OGG}/${OS}/${RELEASE}/src/.libs/libogg.a)
LINUX_DEBUG_LIB(${OGG}/${OS}/${DEBUG}/src/.libs/libogg.a)
LINUX_RELEASE_LIB(${OGG}/${OS}/${RELEASE}/src/.libs/libogg.a)
ANDROID_DEBUG_LIB(${OGG}/${OS}/${DEBUG}/obj/local/armeabi-v7a/libogg.a)
ANDROID_RELEASE_LIB(${OGG}/${OS}/${RELEASE}/obj/local/armeabi-v7a/libogg.a)


### COMPILE ###
DKSETPATH(${OGG}/${OS}/${DEBUG})
WIN32_BASH("#!/bin/bash 
cd ${OGG}/${OS}/${DEBUG} 
export PATH=/${MINGW32}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static 
make 
exit \n")
DKCOPY(${OGG}/${OS}/${DEBUG}/src/.libs/libogg.a ${OGG}/${OS}/${DEBUG}/src/.libs/libogg.lib TRUE)

DKSETPATH(${OGG}/${OS}/${RELEASE})
WIN32_BASH("#!/bin/bash 
cd ${OGG}/${OS}/${RELEASE} 
export PATH=/${MINGW32}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static 
make 
exit \n")
DKCOPY(${OGG}/${OS}/${RELEASE}/src/.libs/libogg.a ${OGG}/${OS}/${RELEASE}/src/.libs/libogg.lib TRUE)


DKSETPATH(${OGG}/${OS}/${DEBUG})
WIN64_BASH("#!/bin/bash 
cd ${OGG}/${OS}/${DEBUG} 
export PATH=/${MINGW64}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static 
make 
exit \n")
DKCOPY(${OGG}/${OS}/${DEBUG}/src/.libs/libogg.a ${OGG}/${OS}/${DEBUG}/src/.libs/libogg.lib TRUE)

DKSETPATH(${OGG}/${OS}/${RELEASE})
WIN64_BASH("#!/bin/bash 
cd ${OGG}/${OS}/${RELEASE} 
export PATH=/${MINGW64}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static 
make 
exit \n")
DKCOPY(${OGG}/${OS}/${RELEASE}/src/.libs/libogg.a ${OGG}/${OS}/${RELEASE}/src/.libs/libogg.lib TRUE)


DKSETPATH(${OGG}/${OS}/${DEBUG})
MAC_DEBUG_COMMAND(../../configure --disable-shared --enable-static --build=x86_64)
MAC_DEBUG_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")

DKSETPATH(${OGG}/${OS}/${RELEASE})
MAC_RELEASE_COMMAND(../../configure --disable-shared --enable-static --build=x86_64)
MAC_RELEASE_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")


DKSETPATH(${OGG}/${OS}/${DEBUG})
IOSSIM_DEBUG_COMMAND(../../configure --disable-shared --enable-static --build=x86_64)
IOSSIM_DEBUG_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")

DKSETPATH(${OGG}/${OS}/${RELEASE})
IOSSIM_RELEASE_COMMAND(../../configure --disable-shared --enable-static --build=x86_64)
IOSSIM_RELEASE_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")

DKSETPATH(${OGG}/${OS}/${DEBUG})
LINUX_DEBUG_COMMAND(../../configure --disable-shared --enable-static --build=x86_64)
LINUX_DEBUG_COMMAND(make)

DKSETPATH(${OGG}/${OS}/${RELEASE})
LINUX_RELEASE_COMMAND(../../configure --disable-shared --enable-static --build=x86_64)
LINUX_RELEASE_COMMAND(make)


ANDROID_NDK_DEBUG(libogg-${OGG_VERSION})
ANDROID_NDK_RELEASE(libogg-${OGG_VERSION})



### INJECT ###
DKSET(OGG_WIN32
	-DOGG_INCLUDE_DIR=${OGG}/include)