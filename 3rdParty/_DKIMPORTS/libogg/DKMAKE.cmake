### VERSION ###
DKSET(OGG_VERSION 1.3.2)
DKSET(OGG ${3RDPARTY}/libogg-${OGG_VERSION})


### INSTALL ###
## https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.2.zip
DKINSTALL(https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-${OGG_VERSION}.zip libogg libogg-${OGG_VERSION})


### DKPLUGINS LINK ###
DKINCLUDE(${OGG}/include)
ANDROID_INCLUDE(${OGG}/${OS})
WIN_DEBUG_LIB(${OGG}/${OS}/${DEBUG}/src/.libs/libogg.a)
WIN_RELEASE_LIB(${OGG}/${OS}/${RELEASE}/src/.libs/libogg.a)
APPLE_DEBUG_LIB(${OGG}/${OS}/${DEBUG}/src/.libs/libogg.a)
APPLE_RELEASE_LIB(${OGG}/${OS}/${RELEASE}/src/.libs/libogg.a)
LINUX_DEBUG_LIB(${OGG}/${OS}/${DEBUG}/src/.libs/libogg.a)
LINUX_RELEASE_LIB(${OGG}/${OS}/${RELEASE}/src/.libs/libogg.a)
ANDROID_DEBUG_LIB(${OGG}/${OS}/${DEBUG}/obj/local/armeabi-v7a/libogg.a)
ANDROID_RELEASE_LIB(${OGG}/${OS}/${RELEASE}/obj/local/armeabi-v7a/libogg.a)


### 3RDPARTY LINK ###
DKSET(OGG_INCLUDE -DOGG_INCLUDE_DIR=${OGG}/include)
DKSET(OGG_WIN_DEBUG "--with-ogg-includes=\"${OGG}/include\" --with-ogg-libraries=\"${OGG}/${OS}/${DEBUG}/src/.libs\"")
DKSET(OGG_WIN_RELEASE "--with-ogg-includes=\"${OGG}/include\" --with-ogg-libraries=\"${OGG}/${OS}/${RELEASE}/src/.libs\"")
DKSET(OGG_APPLE_DEBUG "--with-ogg-includes=\"${OGG}/include\" --with-ogg-libraries=\"${OGG}/${OS}/${DEBUG}/src/.libs\"")
DKSET(OGG_APPLE_RELEASE "--with-ogg-includes=\"${OGG}/include\" --with-ogg-libraries=\"${OGG}/${OS}/${RELEASE}/src/.libs\"")
DKSET(OGG_LINUX_DEBUG "--with-ogg-includes=\"${OGG}/include\" --with-ogg-libraries=\"${OGG}/${OS}/${DEBUG}/src/.libs\"")
DKSET(OGG_LINUX_RELEASE "--with-ogg-includes=\"${OGG}/include\" --with-ogg-libraries=\"${OGG}/${OS}/${RELEASE}/src/.libs\"")
DKSET(OGG_RASPBERRY_DEBUG "--with-ogg-includes=\"${OGG}/include\" --with-ogg-libraries=\"${OGG}/${OS}/${DEBUG}/src/.libs\"")
DKSET(OGG_RASPBERRY_RELEASE "--with-ogg-includes=\"${OGG}/include\" --with-ogg-libraries=\"${OGG}/${OS}/${RELEASE}/src/.libs\"")
	
	
### COMPILE ###
WIN32_DEBUG_PATH(${OGG}/${OS}/${DEBUG})
WIN32_DEBUG_BASH("#!/bin/bash 
cd ${OGG}/${OS}/${DEBUG} 
export PATH=/${MINGW32}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static 
make 
exit \n")

WIN32_RELEASE_PATH(${OGG}/${OS}/${RELEASE})
WIN32_RELEASE_BASH("#!/bin/bash 
cd ${OGG}/${OS}/${RELEASE} 
export PATH=/${MINGW32}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static 
make 
exit \n")


WIN64_DEBUG_PATH(${OGG}/${OS}/${DEBUG})
WIN64_DEBUG_BASH("#!/bin/bash 
cd ${OGG}/${OS}/${DEBUG} 
export PATH=/${MINGW64}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static 
make 
exit \n")

WIN64_RELEASE_PATH(${OGG}/${OS}/${RELEASE})
WIN64_RELEASE_BASH("#!/bin/bash 
cd ${OGG}/${OS}/${RELEASE} 
export PATH=/${MINGW64}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static 
make 
exit \n")


MAC_DEBUG_PATH(${OGG}/${OS}/${DEBUG})
MAC_DEBUG_COMMAND(../../configure --disable-shared --enable-static --build=x86_64)
MAC_DEBUG_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")

MAC_RELEASE_PATH(${OGG}/${OS}/${RELEASE})
MAC_RELEASE_COMMAND(../../configure --disable-shared --enable-static --build=x86_64)
MAC_RELEASE_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")


IOSSIM_DEBUG_PATH(${OGG}/${OS}/${DEBUG})
IOSSIM_DEBUG_COMMAND(../../configure --disable-shared --enable-static --build=x86_64)
IOSSIM_DEBUG_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")

IOSSIM_RELEASE_PATH(${OGG}/${OS}/${RELEASE})
IOSSIM_RELEASE_COMMAND(../../configure --disable-shared --enable-static --build=x86_64)
IOSSIM_RELEASE_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")


LINUX_DEBUG_PATH(${OGG}/${OS}/${DEBUG})
LINUX_DEBUG_COMMAND(../../configure --disable-shared --enable-static --build=x86_64)
LINUX_DEBUG_COMMAND(make)

LINUX_RELEASE_PATH(${OGG}/${OS}/${RELEASE})
LINUX_RELEASE_COMMAND(../../configure --disable-shared --enable-static --build=x86_64)
LINUX_RELEASE_COMMAND(make)


ANDROID_NDK_DEBUG(libogg-${OGG_VERSION})
ANDROID_NDK_RELEASE(libogg-${OGG_VERSION})
