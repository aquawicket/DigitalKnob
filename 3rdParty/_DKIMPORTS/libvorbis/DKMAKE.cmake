## https://ftp.osuosl.org/pub/xiph/releases/vorbis/libvorbis-1.3.5.zip
DKDEPEND(libgcc)


### VERSION ###
DKSET(VORBIS_VERSION 1.3.5)
DKSET(VORBIS ${3RDPARTY}/libvorbis-${VORBIS_VERSION})


### INSTALL ###
DKINSTALL(https://ftp.osuosl.org/pub/xiph/releases/vorbis/libvorbis-${VORBIS_VERSION}.zip libvorbis libvorbis-${VORBIS_VERSION})


### dkplugin LINK ###
DKINCLUDE(${VORBIS}/include)
WIN_DEBUG_LIB(${VORBIS}/${OS}/${DEBUG}/lib/.libs/libvorbis.lib)
WIN_RELEASE_LIB(${VORBIS}/${OS}/${RELEASE}/lib/.libs/libvorbis.lib)
WIN_DEBUG_LIB(${VORBIS}/${OS}/${DEBUG}/lib/.libs/libvorbisfile.lib)
WIN_RELEASE_LIB(${VORBIS}/${OS}/${RELEASE}/lib/.libs/libvorbisfile.lib)
APPLE_DEBUG_LIB(${VORBIS}/${OS}/${DEBUG}/lib/.libs/libvorbis.a)
APPLE_RELEASE_LIB(${VORBIS}/${OS}/${RELEASE}/lib/.libs/libvorbis.a)
APPLE_DEBUG_LIB(${VORBIS}/${OS}/${DEBUG}/lib/.libs/libvorbisfile.a)
APPLE_RELEASE_LIB(${VORBIS}/${OS}/${RELEASE}/lib/.libs/libvorbisfile.a)
LINUX_DEBUG_LIB(${VORBIS}/${OS}/${DEBUG}/lib/.libs/libvorbis.a)
LINUX_RELEASE_LIB(${VORBIS}/${OS}/${RELEASE}/lib/.libs/libvorbis.a)
LINUX_DEBUG_LIB(${VORBIS}/${OS}/${DEBUG}/lib/.libs/libvorbisfile.a)
LINUX_RELEASE_LIB(${VORBIS}/${OS}/${RELEASE}/lib/.libs/libvorbisfile.a)
ANDROID_DEBUG_LIB(${VORBIS}/${OS}/${DEBUG}/obj/local/armeabi-v7a/libvorbis.a)
ANDROID_RELEASE_LIB(${VORBIS}/${OS}/${RELEASE}/obj/local/armeabi-v7a/libvorbis.a)


### 3RDPARTY LINK ###
DKSET(VORBIS_WIN -DVORBIS_INCLUDE_DIR=${VORBIS}/include)
	
	

### COMPILE ###
WIN32_PATH(${VORBIS}/${OS}/${DEBUG})
WIN32_BASH("#!/bin/bash 
cd ${VORBIS}/${OS}/${DEBUG} 
export PATH=/${MINGW32}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static --with-ogg-libraries=\"${OGG}/${OS}/${DEBUG}/src/.libs\" --with-ogg-includes=\"${OGG}/include\" 
make 
exit \n")
if(WIN_32)
	DKRENAME(${VORBIS}/${OS}/${DEBUG}/lib/.libs/libvorbis.a ${VORBIS}/${OS}/${DEBUG}/lib/.libs/libvorbis.lib)
	DKRENAME(${VORBIS}/${OS}/${DEBUG}/lib/.libs/libvorbisfile.a ${VORBIS}/${OS}/${DEBUG}/lib/.libs/libvorbisfile.lib)
endif()


WIN32_PATH(${VORBIS}/${OS}/${RELEASE})
WIN32_BASH("#!/bin/bash 
cd ${VORBIS}/${OS}/${RELEASE} 
export PATH=/${MINGW32}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static --with-ogg-libraries=\"${OGG}/${OS}/${RELEASE}/src/.libs\" --with-ogg-includes=\"${OGG}/include\" 
make 
exit \n")
if(WIN_32)
	DKRENAME(${VORBIS}/${OS}/${RELEASE}/lib/.libs/libvorbis.a ${VORBIS}/${OS}/${RELEASE}/lib/.libs/libvorbis.lib)
	DKRENAME(${VORBIS}/${OS}/${RELEASE}/lib/.libs/libvorbisfile.a ${VORBIS}/${OS}/${RELEASE}/lib/.libs/libvorbisfile.lib)
endif()


WIN64_PATH(${VORBIS}/${OS}/${DEBUG})
WIN64_BASH("#!/bin/bash 
cd ${VORBIS}/${OS}/${DEBUG} 
export PATH=/${MINGW64}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static --with-ogg-libraries=\"${OGG}/${OS}/${DEBUG}/src/.libs\" --with-ogg-includes=\"${OGG}/include\" 
make 
exit \n")
if(WIN_64)
	DKRENAME(${VORBIS}/${OS}/${DEBUG}/lib/.libs/libvorbis.a ${VORBIS}/${OS}/${DEBUG}/lib/.libs/libvorbis.lib)
	DKRENAME(${VORBIS}/${OS}/${DEBUG}/lib/.libs/libvorbisfile.a ${VORBIS}/${OS}/${DEBUG}/lib/.libs/libvorbisfile.lib)
endif()


WIN64_PATH(${VORBIS}/${OS}/${RELEASE})
WIN64_BASH("#!/bin/bash 
cd ${VORBIS}/${OS}/${RELEASE} 
export PATH=/${MINGW64}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static --with-ogg-libraries=\"${OGG}/${OS}/${RELEASE}/src/.libs\" --with-ogg-includes=\"${OGG}/include\" 
make 
exit \n")
if(WIN_64)
	DKRENAME(${VORBIS}/${OS}/${RELEASE}/lib/.libs/libvorbis.a ${VORBIS}/${OS}/${RELEASE}/lib/.libs/libvorbis.lib)
	DKRENAME(${VORBIS}/${OS}/${RELEASE}/lib/.libs/libvorbisfile.a ${VORBIS}/${OS}/${RELEASE}/lib/.libs/libvorbisfile.lib)
endif()


MAC_DEBUG_PATH(${VORBIS}/${OS}/${DEBUG})
MAC_DEBUG_COMMAND(../../configure --disable-shared --enable-static --build=x86_64 --with-ogg-libraries=${OGG}/${OS}/${DEBUG}/src/.libs --with-ogg-includes=${OGG}/include)
MAC_DEBUG_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")

MAC_RELEASE_PATH(${VORBIS}/${OS}/${RELEASE})
MAC_RELEASE_COMMAND(../../configure --disable-shared --enable-static --build=x86_64 --with-ogg-libraries=${OGG}/${OS}/${RELEASE}/src/.libs --with-ogg-includes=${OGG}/include)
MAC_RELEASE_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")


IOSSIM_DEBUG_PATH(${VORBIS}/${OS}/${DEBUG})
IOSSIM_DEBUG_COMMAND(../../configure --disable-shared --enable-static --build=x86_64 --with-ogg-libraries=${OGG}/${OS}/${DEBUG}/src/.libs --with-ogg-includes=${OGG}/include)
IOSSIM_DEBUG_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")

IOSSIM_RELEASE_PATH(${VORBIS}/${OS}/${RELEASE})
IOSSIM_RELEASE_COMMAND(../../configure --disable-shared --enable-static --build=x86_64 --with-ogg-libraries=${OGG}/${OS}/${RELEASE}/src/.libs --with-ogg-includes=${OGG}/include)
IOSSIM_RELEASE_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")


LINUX_DEBUG_PATH(${VORBIS}/${OS}/${DEBUG})
LINUX_DEBUG_COMMAND(../../configure --disable-shared --enable-static --with-ogg-libraries=${OGG}/${OS}/${DEBUG}/src/.libs --with-ogg-includes=${OGG}/include --disable-oggtest)
LINUX_DEBUG_COMMAND(make)

LINUX_RELEASE_PATH(${VORBIS}/${OS}/${RELEASE})
LINUX_RELEASE_COMMAND(../../configure --disable-shared --enable-static --with-ogg-libraries=${OGG}/${OS}/${RELEASE}/src/.libs --with-ogg-includes=${OGG}/include --disable-oggtest)
LINUX_RELEASE_COMMAND(make)


ANDROID_NDK_DEBUG(${VORBIS_VERSION})
ANDROID_NDK_RELEASE(${VORBIS_VERSION})
