# https://deltaepsilon.ca/posts/compiling-libogg-libvorbis-for-dummies/
#
# https://ftp.osuosl.org/pub/xiph/releases/vorbis/libvorbis-1.3.7.zip

### DEPENDS ###
DKDEPEND(mingw32)
DKDEPEND(mingw64)
DKDEPEND(msys)
DKDEPEND(libgcc)
DKDEPEND(libogg)


### VERSION ###
DKSET(VORBIS_VERSION 1.3.7)
DKSET(VORBIS_NAME libvorbis-${VORBIS_VERSION})
DKSET(VORBIS_DL https://ftp.osuosl.org/pub/xiph/releases/vorbis/${VORBIS_NAME}.zip)
DKSET(VORBIS ${3RDPARTY}/${VORBIS_NAME})


### INSTALL ###
DKINSTALL(${VORBIS_DL} libvorbis ${VORBIS})


### dkplugin LINK ###
DKINCLUDE(${VORBIS}/include)
WIN_DEBUG_LIB(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a)
WIN_RELEASE_LIB(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a)
WIN_DEBUG_LIB(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a)
WIN_RELEASE_LIB(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a)
WIN_DEBUG_LIB(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
WIN_RELEASE_LIB(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
APPLE_DEBUG_LIB(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a)
APPLE_RELEASE_LIB(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a)
APPLE_DEBUG_LIB(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a)
APPLE_RELEASE_LIB(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a)
APPLE_DEBUG_LIB(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
APPLE_RELEASE_LIB(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
LINUX_DEBUG_LIB(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a)
LINUX_RELEASE_LIB(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a)
LINUX_DEBUG_LIB(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a)
LINUX_RELEASE_LIB(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a)
LINUX_DEBUG_LIB(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
LINUX_RELEASE_LIB(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
RASPBERRY_DEBUG_LIB(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a)
RASPBERRY_RELEASE_LIB(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a)
RASPBERRY_DEBUG_LIB(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a)
RASPBERRY_RELEASE_LIB(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a)
RASPBERRY_DEBUG_LIB(${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
RASPBERRY_RELEASE_LIB(${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
ANDROID_DEBUG_LIB(${VORBIS}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libvorbis.a)
ANDROID_RELEASE_LIB(${VORBIS}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libvorbis.a)
ANDROID_DEBUG_LIB(${VORBIS}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libvorbisfile.a)
ANDROID_RELEASE_LIB(${VORBIS}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libvorbisfile.a)
ANDROID_DEBUG_LIB(${VORBIS}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libvorbisenc.a)
ANDROID_RELEASE_LIB(${VORBIS}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libvorbisenc.a)


### 3RDPARTY LINK ###
DKSET(VORBIS_WIN_DEBUG -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a 
-DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
DKSET(VORBIS_WIN_RELEASE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a 
-DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
DKSET(VORBIS_APPLE_DEBUG -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a 
-DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
DKSET(VORBIS_APPLE_RELEASE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a 
-DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
DKSET(VORBIS_LINUX_DEBUG -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a 
-DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
DKSET(VORBIS_LINUX_RELEASE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a 
-DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
DKSET(VORBIS_RASPBERRY_DEBUG -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a 
-DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
DKSET(VORBIS_RASPBERRY_RELEASE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a 
-DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
DKSET(VORBIS_ANDROID_DEBUG -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbis.a 
-DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${DEBUG_DIR}/lib/.libs/libvorbisenc.a)
DKSET(VORBIS_ANDROID_RELEASE -DVORBIS_INCLUDE_DIR=${VORBIS}/include -DVORBIS_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbis.a 
-DVORBISFILE_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisfile.a -DVORBISENC_LIBRARY=${VORBIS}/${OS}/${RELEASE_DIR}/lib/.libs/libvorbisenc.a)
	
	
### COMPILE ###
WIN32_DEBUG_PATH(${VORBIS}/${OS}/${DEBUG_DIR})
WIN32_DEBUG_MSYS(../../configure --with-ogg-includes=${OGG}/include --disable-shared --enable-static ${OGG_WIN_DEBUG})
WIN32_DEBUG_MSYS(make)
WIN32_RELEASE_PATH(${VORBIS}/${OS}/${RELEASE_DIR})
WIN32_RELEASE_MSYS(../../configure --with-ogg-includes=${OGG}/include --disable-shared --enable-static ${OGG_WIN_RELEASE})
WIN32_RELEASE_MSYS(make)


#WIN32_PATH(${VORBIS}/${OS}/${DEBUG_DIR})
#WIN32_BASH("#!/bin/bash"
#"cd /${VORBIS}/${OS}/${DEBUG_DIR}"
#"export PATH=/${MINGW32}/bin:$PATH"
#"export PATH=/${MSYS}/bin:$PATH"
#"../../configure --disable-shared ${OGG_WIN_RELEASE}" 
#"make"
#"exit")

#WIN32_PATH(${VORBIS}/${OS}/${RELEASE_DIR})
#WIN32_BASH("#!/bin/bash"
#"cd /${VORBIS}/${OS}/${RELEASE_DIR}"
#"export PATH=/${MINGW32}/bin:$PATH"
#"export PATH=/${MSYS}/bin:$PATH"
#"../../configure --disable-shared ${OGG_WIN_RELEASE}"
#"make"
#"exit")


WIN64_PATH(${VORBIS}/${OS}/${DEBUG_DIR})
WIN64_BASH("#!/bin/bash 
cd /${VORBIS}/${OS}/${DEBUG_DIR} 
export PATH=/${MINGW64}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared ${OGG_WIN_DEBUG}
make 
exit \n")
WIN64_PATH(${VORBIS}/${OS}/${RELEASE_DIR})
WIN64_BASH("#!/bin/bash 
cd /${VORBIS}/${OS}/${RELEASE_DIR} 
export PATH=/${MINGW64}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared ${OGG_WIN_RELEASE}
make 
exit \n")



MAC_DEBUG_PATH(${VORBIS}/${OS}/${DEBUG_DIR})
MAC_DEBUG_COMMAND(../../configure --with-ogg-includes=${OGG}/include --disable-shared --enable-static --build=x86_64 ${OGG_APPLE_DEBUG})
MAC_DEBUG_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")
MAC_RELEASE_PATH(${VORBIS}/${OS}/${RELEASE_DIR})
MAC_RELEASE_COMMAND(../../configure --with-ogg-includes=${OGG}/include --disable-shared --enable-static --build=x86_64 ${OGG_APPLE_RELEASE})
MAC_RELEASE_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")



IOSSIM_DEBUG_PATH(${VORBIS}/${OS}/${DEBUG_DIR})
IOSSIM_DEBUG_COMMAND(../../configure --disable-shared --enable-static --build=x86_64 ${OGG_APPLE_DEBUG})
IOSSIM_DEBUG_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")
IOSSIM_RELEASE_PATH(${VORBIS}/${OS}/${RELEASE_DIR})
IOSSIM_RELEASE_COMMAND(../../configure --disable-shared --enable-static --build=x86_64 ${OGG_APPLE_RELEASE})
IOSSIM_RELEASE_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")



if(LINUX)
	set(ENV{PKG_CONFIG_PATH} "${OGG}/${OS}/${DEBUG_DIR}")
endif()
LINUX_DEBUG_PATH(${VORBIS}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_COMMAND(../../configure --disable-shared --enable-static ${OGG_LINUX_DEBUG})
LINUX_DEBUG_COMMAND(make)
if(LINUX)
	set(ENV{PKG_CONFIG_PATH} "${OGG}/${OS}/${RELEASE_DIR}")
endif()
LINUX_RELEASE_PATH(${VORBIS}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_COMMAND(../../configure --disable-shared --enable-static ${OGG_LINUX_RELEASE})
LINUX_RELEASE_COMMAND(make)



if(RASPBERRY)
	set(ENV{PKG_CONFIG_PATH} "${OGG}/${OS}/${DEBUG_DIR}")
endif()
RASPBERRY_DEBUG_PATH(${VORBIS}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_COMMAND(../../configure --disable-shared --enable-static ${OGG_RASPBERRY_DEBUG})
RASPBERRY_DEBUG_COMMAND(make)
if(RASPBERRY)
	set(ENV{PKG_CONFIG_PATH} "${OGG}/${OS}/${RELEASE_DIR}")
endif()
RASPBERRY_RELEASE_PATH(${VORBIS}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_COMMAND(../../configure --disable-shared --enable-static ${OGG_RASPBERRY_RELEASE})
RASPBERRY_RELEASE_COMMAND(make)



#ANDROID_NDK(${VORBIS_VERSION})
if(ANDROID)
	set(ENV{PKG_CONFIG_PATH} "${OGG}/${OS}/${DEBUG_DIR}")
endif()
ANDROID_DEBUG_PATH(${VORBIS}/${OS}/${DEBUG_DIR})
ANDROID_DEBUG_COMMAND(../../configure --disable-shared --enable-static ${OGG_ANDROID_DEBUG})
ANDROID_DEBUG_COMMAND(make)
if(ANDROID)
	set(ENV{PKG_CONFIG_PATH} "${OGG}/${OS}/${RELEASE_DIR}")
endif()
ANDROID_RELEASE_PATH(${VORBIS}/${OS}/${RELEASE_DIR})
ANDROID_RELEASE_COMMAND(../../configure --disable-shared --enable-static ${OGG_ANDROID_RELEASE})
ANDROID_RELEASE_COMMAND(make)
