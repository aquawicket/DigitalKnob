# https://deltaepsilon.ca/posts/compiling-libogg-libvorbis-for-dummies/
#
# https://ftp.osuosl.org/pub/xiph/releases/ogg/libogg-1.3.2.zip

### VERSION ###
DKSET(OGG_VERSION 1.3.2)
DKSET(OGG_NAME libogg-${OGG_VERSION})
DKSET(OGG_DL https://ftp.osuosl.org/pub/xiph/releases/ogg/${OGG_NAME}.zip)
DKSET(OGG ${3RDPARTY}/${OGG_NAME})


### INSTALL ###
DKINSTALL(${OGG_DL} libogg ${OGG})


### DKPLUGINS LINK ###
DKINCLUDE(${OGG}/include)
ANDROID_INCLUDE(${OGG}/${OS})
WIN_DEBUG_LIB(${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a)
WIN_RELEASE_LIB(${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a)
APPLE_DEBUG_LIB(${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a)
APPLE_RELEASE_LIB(${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a)
LINUX_DEBUG_LIB(${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a)
LINUX_RELEASE_LIB(${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a)
RASPBERRY_DEBUG_LIB(${OGG}/${OS}/${DEBUG_DIR}/src/.libs/libogg.a)
RASPBERRY_RELEASE_LIB(${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a)
ANDROID_DEBUG_LIB(${OGG}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libogg.a)
ANDROID_RELEASE_LIB(${OGG}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libogg.a)


#-DOGG_INCLUDE_DIR=${OGG}/include -DOGG_LIBRARY=${OGG}/${OS}/${RELEASE_DIR}/src/.libs/libogg.a
### 3RDPARTY LINK ###
DKSET(OGG_INCLUDE -DOGG_INCLUDE_DIR=${OGG}/include)
DKSET(OGG_WIN_DEBUG CFLAGS=-I${OGG}/include --with-ogg-includes=${OGG}/include --with-ogg-libraries=${OGG}/${OS}/${DEBUG_DIR}/src/.libs)
DKSET(OGG_WIN_RELEASE CFLAGS=-I${OGG}/include --with-ogg-includes=${OGG}/include --with-ogg-libraries=${OGG}/${OS}/${RELEASE_DIR}/src/.libs)
DKSET(OGG_APPLE_DEBUG CFLAGS=-I${OGG}/include --with-ogg-includes=${OGG}/include --with-ogg-libraries=${OGG}/${OS}/${DEBUG_DIR}/src/.libs)
DKSET(OGG_APPLE_RELEASE CFLAGS=-I${OGG}/include --with-ogg-includes=${OGG}/include --with-ogg-libraries=${OGG}/${OS}/${RELEASE_DIR}/src/.libs)
DKSET(OGG_LINUX_DEBUG CFLAGS=-I${OGG}/include --with-ogg-includes=${OGG}/include --with-ogg-libraries=${OGG}/${OS}/${DEBUG_DIR}/src/.libs)
DKSET(OGG_LINUX_RELEASE CFLAGS=-I${OGG}/include --with-ogg-includes=${OGG}/include --with-ogg-libraries=${OGG}/${OS}/${RELEASE_DIR}/src/.libs)
DKSET(OGG_RASPBERRY_DEBUG CFLAGS=-I${OGG}/include --with-ogg-includes=${OGG}/include --with-ogg-libraries=${OGG}/${OS}/${DEBUG_DIR}/src/.libs)
#DKSET(OGG_RASPBERRY_RELEASE CFLAGS=-I${OGG}/include --with-ogg-includes=${OGG}/include --with-ogg-libraries=${OGG}/${OS}/${RELEASE_DIR}/src/.libs)
DKSET(OGG_RASPBERRY_RELEASE CFLAGS=-I${OGG}/include)
DKSET(OGG_ANDROID_DEBUG CFLAGS=-I${OGG}/include --with-ogg-includes=${OGG}/include --with-ogg-libraries=${OGG}/${OS}/${DEBUG_DIR}/src/.libs)
DKSET(OGG_ANDROID_RELEASE CFLAGS=-I${OGG}/include --with-ogg-includes=${OGG}/include --with-ogg-libraries=${OGG}/${OS}/${RELEASE_DIR}/src/.libs)
	
	
### COMPILE ###
WIN32_DEBUG_PATH(${OGG}/${OS}/${DEBUG_DIR})
WIN32_DEBUG_BASH("#!/bin/bash 
cd /${OGG}/${OS}/${DEBUG_DIR} 
export PATH=/${MINGW32}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static
make 
exit \n")

WIN32_RELEASE_PATH(${OGG}/${OS}/${RELEASE_DIR})
WIN32_RELEASE_BASH("#!/bin/bash 
cd /${OGG}/${OS}/${RELEASE_DIR} 
export PATH=/${MINGW32}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static 
make 
exit \n")



WIN64_DEBUG_PATH(${OGG}/${OS}/${DEBUG_DIR})
WIN64_DEBUG_BASH("#!/bin/bash 
cd /${OGG}/${OS}/${DEBUG_DIR} 
export PATH=/${MINGW64}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static 
make 
exit \n")

WIN64_RELEASE_PATH(${OGG}/${OS}/${RELEASE_DIR})
WIN64_RELEASE_BASH("#!/bin/bash 
cd /${OGG}/${OS}/${RELEASE_DIR} 
export PATH=/${MINGW64}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static 
make 
exit \n")



MAC_DEBUG_PATH(${OGG}/${OS}/${DEBUG_DIR})
MAC_DEBUG_COMMAND(../../configure --disable-shared --enable-static --build=x86_64)
MAC_DEBUG_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")
MAC_RELEASE_PATH(${OGG}/${OS}/${RELEASE_DIR})
MAC_RELEASE_COMMAND(../../configure --disable-shared --enable-static --build=x86_64)
MAC_RELEASE_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")


IOSSIM_DEBUG_PATH(${OGG}/${OS}/${DEBUG_DIR})
IOSSIM_DEBUG_COMMAND(../../configure --disable-shared --enable-static --build=x86_64)
IOSSIM_DEBUG_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")
IOSSIM_RELEASE_PATH(${OGG}/${OS}/${RELEASE_DIR})
IOSSIM_RELEASE_COMMAND(../../configure --disable-shared --enable-static --build=x86_64)
IOSSIM_RELEASE_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")


LINUX_DEBUG_PATH(${OGG}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_COMMAND(../../configure --disable-shared --enable-static) #--build=x86_64)
LINUX_DEBUG_COMMAND(make)
LINUX_RELEASE_PATH(${OGG}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_COMMAND(../../configure --disable-shared --enable-static) # --build=x86_64)
LINUX_RELEASE_COMMAND(make)


RASPBERRY_DEBUG_PATH(${OGG}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_COMMAND(../../configure --disable-shared --enable-static) # --build=x86_64)
RASPBERRY_DEBUG_COMMAND(make)
RASPBERRY_RELEASE_PATH(${OGG}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_COMMAND(../../configure --disable-shared --enable-static) # --build=x86_64)
RASPBERRY_RELEASE_COMMAND(make)


ANDROID_NDK(${OGG_NAME})
