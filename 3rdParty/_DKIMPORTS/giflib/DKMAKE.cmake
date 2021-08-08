# http://giflib.sourceforge.net/
#
# https://sourceforge.net/projects/giflib/files/giflib-5.1.1.tar.gz

if(WIN_32)
	DKDEPEND(mingw32)
endif()
if(WIN_64)
	DKDEPEND(mingw64)
endif()
DKDEPEND(msys)



### VERSION ###
DKSET(GIF_VERSION 5.1.1)
DKSET(GIF_NAME giflib-${GIF_VERSION})
DKSET(GIF_DL https://sourceforge.net/projects/giflib/files/${GIF_NAME}.tar.gz)
DKSET(GIF ${3RDPARTY}/${GIF_NAME})



### INSTALL ###
DKINSTALL(${GIF_DL} giflib ${GIF})



### DKPLUGINS LINK ###
DKINCLUDE(${GIF}/lib)
WIN_DEBUG_LIB(${GIF}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a)
WIN_RELEASE_LIB(${GIF}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
APPLE_DEBUG_LIB(${GIF}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a)
APPLE_RELEASE_LIB(${GIF}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
LINUX_DEBUG_LIB(${GIF}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a)
LINUX_RELEASE_LIB(${GIF}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
RASPBERRY_DEBUG_LIB(${GIF}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a)
RASPBERRY_RELEASE_LIB(${GIF}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
ANDROID_DEBUG_LIB(${GIF}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libgif.a)
ANDROID_RELEASE_LIB(${GIF}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libgif.a)



### 3RDPARTY LINK ###
DKSET(GIF_WIN -DGIF_INCLUDE_DIR=${GIF}/lib -DGIF_INCLUDE_DIR2=${GIF}/${OS} -DGIF_LIBRARY=${GIF}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
DKSET(GIF_APPLE -DGIF_INCLUDE_DIR=${GIF}/lib -DGIF_INCLUDE_DIR2=${GIF}/${OS} -DGIF_LIBRARY=${GIF}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
DKSET(GIF_LINUX -DGIF_INCLUDE_DIR=${GIF}/lib -DGIF_INCLUDE_DIR2=${GIF}/${OS} -DGIF_LIBRARY=${GIF}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
DKSET(GIF_RASPBERRY -DGIF_INCLUDE_DIR=${GIF}/lib -DGIF_INCLUDE_DIR2=${GIF}/${OS} -DGIF_LIBRARY=${GIF}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
DKSET(GIF_ANDROID -DGIF_INCLUDE_DIR=${GIF}/lib -DGIF_INCLUDE_DIR2=${GIF}/${OS} -DGIF_LIBRARY=${GIF}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)	


### COMPILE ###
WIN32_DEBUG_PATH(${GIF}/${OS}/${DEBUG_DIR})
WIN32_DEBUG_BASH("#!/bin/bash 
cd /${GIF}/${OS}/${DEBUG_DIR} 
export PATH=/${MINGW32}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static 
make 
exit \n")
#if(WIN_32 AND DEBUG)
	#DKRENAME(${GIF}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a ${GIF}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.lib)
#endif()

WIN32_RELEASE_PATH(${GIF}/${OS}/${RELEASE_DIR})
WIN32_RELEASE_BASH("#!/bin/bash 
cd /${GIF}/${OS}/${RELEASE_DIR} 
export PATH=/${MINGW32}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static 
make 
exit\n ")
#if(WIN_32 AND RELEASE)
#	DKRENAME(${GIF}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a ${GIF}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.lib)
#endif()



WIN64_DEBUG_PATH(${GIF}/${OS}/${DEBUG_DIR})
WIN64_DEBUG_BASH("#!/bin/bash 
cd /${GIF}/${OS}/${DEBUG_DIR} 
export PATH=/${MINGW64}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static 
make 
exit \n")
#if(WIN_64 AND DEBUG)
#DKRENAME(${GIF}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a ${GIF}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.lib)
#endif()

WIN64_RELEASE_PATH(${GIF}/${OS}/${RELEASE_DIR})
WIN64_RELEASE_BASH("#!/bin/bash 
cd /${GIF}/${OS}/${RELEASE_DIR} 
export PATH=/${MINGW64}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static 
make 
exit\n ")
#if(WIN_64 AND RELEASE)
#	DKRENAME(${GIF}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a ${GIF}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.lib)
#endif()


MAC_DEBUG_PATH(${GIF}/${OS}/${DEBUG_DIR})
MAC_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
MAC_DEBUG_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")

MAC_RELEASE_PATH(${GIF}/${OS}/${RELEASE_DIR})
MAC_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
MAC_RELEASE_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")



IOS_DEBUG_PATH(${GIF}/${OS}/${DEBUG_DIR})
IOS_DEBUG_COMMAND(../../configure --disable-shared --enable-static --arch-"armv7 armv7s")
IOS_DEBUG_COMMAND(make)

IOS_RELEASE_PATH(${GIF}/${OS}/${RELEASE_DIR})
IOS_RELEASE_COMMAND(../../configure --disable-shared --enable-static --arch-"armv7 armv7s")
IOS_RELEASE_COMMAND(make)



IOSSIM_DEBUG_PATH(${GIF}/${OS}/${DEBUG_DIR})
IOSSIM_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
IOSSIM_DEBUG_COMMAND(make "CXXFLAGS=-arch i386" "CFLAGS=-arch i386" "LDFLAGS=-arch i386")

IOSSIM_RELEASE_PATH(${GIF}/${OS}/${RELEASE_DIR})
IOSSIM_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
IOSSIM_RELEASE_COMMAND(make "CXXFLAGS=-arch i386" "CFLAGS=-arch i386" "LDFLAGS=-arch i386")



LINUX_DEBUG_PATH(${GIF}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
LINUX_DEBUG_COMMAND(make)

LINUX_RELEASE_PATH(${GIF}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
LINUX_RELEASE_COMMAND(make)



RASPBERRY_DEBUG_PATH(${GIF}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
RASPBERRY_DEBUG_COMMAND(make)

RASPBERRY_RELEASE_PATH(${GIF}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
RASPBERRY_RELEASE_COMMAND(make)



ANDROID_NDK(${GIF_NAME})