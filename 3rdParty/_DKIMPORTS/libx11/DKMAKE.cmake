##return() #TODO
# https://www.x.org/
# https://www.x.org/releases/individual/lib/
# https://github.com/mirror/libX11
# 
# https://www.x.org/releases/individual/lib/libX11-1.6.10.tar.gz
# https://github.com/mirror/libX11/archive/refs/tags/libX11-1.7.0.zip


### DEPENDS ###
#DKDEPEND(depend_name)


### VERSION ###
DKSET(LIBX11_VERSION 1.7.0)
DKSET(LIBX11_NAME libx11-${LIBX11_VERSION})
DKSET(LIBX11_DL https://github.com/mirror/libX11/archive/refs/tags/${LIBX11_NAME}.zip)
DKSET(LIBX11 ${3RDPARTY}/${LIBX11_NAME})


### INSTALL ###
DKINSTALL(${LIBX11_DL} libx11 ${LIBX11})


### LINK ###
DKINCLUDE(${LIBX11}/include)
WIN_DEBUG_LIB(${LIBX11}/${OS}/${DEBUG_DIR}/libx11d.lib)
WIN_RELEASE_LIB(${LIBX11}/${OS}/${RELEASE_DIR}/libx11.lib)
APPLE_DEBUG_LIB(${LIBX11}/${OS}/${DEBUG_DIR}/liblibx11d.a)
APPLE_RELEASE_LIB(${LIBX11}/${OS}/${RELEASE_DIR}/liblibx11.a)
LINUX_DEBUG_LIB(${LIBX11}/${OS}/${DEBUG_DIR}/liblibx11d.a)
LINUX_RELEASE_LIB(${LIBX11}/${OS}/${RELEASE_DIR}/liblibx11.a)
RASPBERRY_DEBUG_LIB(${LIBX11}/${OS}/${DEBUG_DIR}/liblibx11d.a)
RASPBERRY_RELEASE_LIB(${LIBX11}/${OS}/${RELEASE_DIR}/liblibx11.a)
ANDROID_DEBUG_LIB(${LIBX11}/${OS}/${DEBUG_DIR}/liblibx11d.a)
ANDROID_RELEASE_LIB(${LIBX11}/${OS}/${RELEASE_DIR}/liblibx11.a)


### COMPILE ###
WIN32_DEBUG_PATH(${LIBX11}/${OS}/${DEBUG_DIR})
WIN32_DEBUG_BASH("#!/bin/bash 
cd /${LIBX11}/${OS}/${DEBUG_DIR} 
export PATH=/${MINGW32}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static
make 
exit \n")

WIN32_RELEASE_PATH(${LIBX11}/${OS}/${RELEASE_DIR})
WIN32_RELEASE_BASH("#!/bin/bash 
cd /${LIBX11}/${OS}/${RELEASE_DIR} 
export PATH=/${MINGW32}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static 
make 
exit \n")



WIN64_DEBUG_PATH(${LIBX11}/${OS}/${DEBUG_DIR})
WIN64_DEBUG_BASH("#!/bin/bash 
cd /${LIBX11}/${OS}/${DEBUG_DIR} 
export PATH=/${MINGW64}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static 
make 
exit \n")

WIN64_RELEASE_PATH(${LIBX11}/${OS}/${RELEASE_DIR})
WIN64_RELEASE_BASH("#!/bin/bash 
cd /${LIBX11}/${OS}/${RELEASE_DIR} 
export PATH=/${MINGW64}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static 
make 
exit \n")



MAC_DEBUG_PATH(${LIBX11}/${OS}/${DEBUG_DIR})
MAC_DEBUG_COMMAND(../../configure --disable-shared --enable-static --build=x86_64)
MAC_DEBUG_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")
MAC_RELEASE_PATH(${LIBX11}/${OS}/${RELEASE_DIR})
MAC_RELEASE_COMMAND(../../configure --disable-shared --enable-static --build=x86_64)
MAC_RELEASE_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")



IOS_DEBUG_PATH(${LIBX11}/${OS}/${DEBUG_DIR})
IOS_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
IOS_DEBUG_COMMAND(make)
IOS_RELEASE_PATH(${LIBX11}/${OS}/${RELEASE_DIR})
IOS_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
IOS_RELEASE_COMMAND(make)



IOSSIM_DEBUG_PATH(${LIBX11}/${OS}/${DEBUG_DIR})
IOSSIM_DEBUG_COMMAND(../../configure --disable-shared --enable-static --build=x86_64)
IOSSIM_DEBUG_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")
IOSSIM_RELEASE_PATH(${LIBX11}/${OS}/${RELEASE_DIR})
IOSSIM_RELEASE_COMMAND(../../configure --disable-shared --enable-static --build=x86_64)
IOSSIM_RELEASE_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")



LINUX_DEBUG_PATH(${LIBX11}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
LINUX_DEBUG_COMMAND(make)
LINUX_RELEASE_PATH(${LIBX11}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
LINUX_RELEASE_COMMAND(make)



RASPBERRY_DEBUG_PATH(${LIBX11}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
RASPBERRY_DEBUG_COMMAND(make)
RASPBERRY_RELEASE_PATH(${LIBX11}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
RASPBERRY_RELEASE_COMMAND(make)



#ANDROID_NDK(${LIBX11_NAME})
ANDROID_DEBUG_PATH(${LIBX11}/${OS}/${DEBUG_DIR})
ANDROID_DEBUG_COMMAND(../../configure --disable-shared --enable-static) # --build=arm)
ANDROID_DEBUG_COMMAND(make)
ANDROID_RELEASE_PATH(${LIBX11}/${OS}/${RELEASE_DIR})
ANDROID_RELEASE_COMMAND(../../configure --disable-shared --enable-static) # --build=arm)
ANDROID_RELEASE_COMMAND(make)
