if(WIN_32)
	DKDEPEND(mingw32)
endif()
if(WIN_64)
	DKDEPEND(mingw64)
endif()
DKDEPEND(msys)


### VERSION ###
DKSET(GIF_VERSION 5.1.1)


### INSTALL ###
DKINSTALL(https://sourceforge.net/projects/giflib/files/giflib-${GIF_VERSION}.tar.gz giflib giflib-${GIF_VERSION})
DKSET(GIF ${3RDPARTY}/giflib-${GIF_VERSION})


### DKPLUGINS LINK ###
DKINCLUDE(${GIF}/lib)
WIN_DEBUG_LIB(${GIF}/${OS}/${DEBUG}/lib/.libs/libgif.lib)
WIN_RELEASE_LIB(${GIF}/${OS}/${RELEASE}/lib/.libs/libgif.lib)
APPLE_DEBUG_LIB(${GIF}/${OS}/${DEBUG}/lib/.libs/libgif.a)
APPLE_RELEASE_LIB(${GIF}/${OS}/${RELEASE}/lib/.libs/libgif.a)
LINUX_DEBUG_LIB(${GIF}/${OS}/${DEBUG}/lib/.libs/libgif.a)
LINUX_RELEASE_LIB(${GIF}/${OS}/${RELEASE}/lib/.libs/libgif.a)
ANDROID_DEBUG_LIB(${GIF}/${OS}/${DEBUG}/obj/local/armeabi-v7a/libgif.a)
ANDROID_RELEASE_LIB(${GIF}/${OS}/${RELEASE}/obj/local/armeabi-v7a/libgif.a)
RASPBERRY_DEBUG_LIB(${GIF}/${OS}/${DEBUG}/lib/.libs/libgif.a)
RASPBERRY_RELEASE_LIB(${GIF}/${OS}/${RELEASE}/lib/.libs/libgif.a)



### 3RDPARTY LINK ###
DKSET(GIF_WIN -DGIF_INCLUDE_DIR=${GIF} -DGIF_INCLUDE_DIR2=${GIF}/${OS} -DGIF_INCLUDE_DIR=${GIF}/lib -DGIF_LIBRARY=${GIF}/${OS}/${RELEASE}/lib/.libs/libgif.lib)
	


### COMPILE ###
DKSETPATH(${GIF}/${OS}/${DEBUG})
WIN32_BASH("#!/bin/bash 
cd ${GIF}/${OS}/${DEBUG} 
export PATH=/${MINGW32}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static 
make 
exit \n")
DKRENAME(${GIF}/${OS}/${DEBUG}/lib/.libs/libgif.a ${GIF}/${OS}/${DEBUG}/lib/.libs/libgif.lib)

DKSETPATH(${GIF}/${OS}/${RELEASE})
WIN32_BASH("#!/bin/bash 
cd ${GIF}/${OS}/${RELEASE} 
export PATH=/${MINGW32}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static 
make 
exit\n ")
DKRENAME(${GIF}/${OS}/${RELEASE}/lib/.libs/libgif.a ${GIF}/${OS}/${RELEASE}/lib/.libs/libgif.lib)



DKSETPATH(${GIF}/${OS}/${DEBUG})
WIN64_BASH("#!/bin/bash 
cd ${GIF}/${OS}/${DEBUG} 
export PATH=/${MINGW64}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static 
make 
exit \n")
DKRENAME(${GIF}/${OS}/${DEBUG}/lib/.libs/libgif.a ${GIF}/${OS}/${DEBUG}/lib/.libs/libgif.lib)

DKSETPATH(${GIF}/${OS}/${RELEASE})
WIN64_BASH("#!/bin/bash 
cd ${GIF}/${OS}/${RELEASE} 
export PATH=/${MINGW64}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static 
make 
exit\n ")
DKRENAME(${GIF}/${OS}/${RELEASE}/lib/.libs/libgif.a ${GIF}/${OS}/${RELEASE}/lib/.libs/libgif.lib)



DKSETPATH(${GIF}/${OS}/${DEBUG})
MAC_COMMAND(../../configure --disable-shared --enable-static)
MAC_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")

DKSETPATH(${GIF}/${OS}/${RELEASE})
MAC_COMMAND(../../configure --disable-shared --enable-static)
MAC_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")



DKSETPATH(${GIF}/${OS}/${DEBUG})
IOS_DEBUG_COMMAND(../../configure --disable-shared --enable-static --arch-"armv7 armv7s")
IOS_DEBUG_COMMAND(make)

DKSETPATH(${GIF}/${OS}/${RELEASE})
IOS_RELEASE_COMMAND(../../configure --disable-shared --enable-static --arch-"armv7 armv7s")
IOS_RELEASE_COMMAND(make)



DKSETPATH(${GIF}/${OS}/${DEBUG})
IOSSIM_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
IOSSIM_DEBUG_COMMAND(make "CXXFLAGS=-arch i386" "CFLAGS=-arch i386" "LDFLAGS=-arch i386")

DKSETPATH(${GIF}/${OS}/${RELEASE})
IOSSIM_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
IOSSIM_RELEASE_COMMAND(make "CXXFLAGS=-arch i386" "CFLAGS=-arch i386" "LDFLAGS=-arch i386")



DKSETPATH(${GIF}/${OS}/${DEBUG})
LINUX_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
LINUX_DEBUG_COMMAND(make)

DKSETPATH(${GIF}/${OS}/${RELEASE})
LINUX_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
LINUX_RELEASE_COMMAND(make)



DKSETPATH(${GIF}/${OS}/${DEBUG})
RASPBERRY_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
RASPBERRY_DEBUG_COMMAND(make)

DKSETPATH(${GIF}/${OS}/${RELEASE})
RASPBERRY_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
RASPBERRY_RELEASE_COMMAND(make)



ANDROID_NDK_DEBUG(giflib-${GIF_VERSION})
ANDROID_NDK_RELEASE(giflib-${GIF_VERSION})