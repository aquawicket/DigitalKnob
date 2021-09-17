# https://github.com/xz-mirror/xz
#
# https://tukaani.org/xz/xz-5.2.5.tar.gz
# https://github.com/xz-mirror/xz/archive/refs/tags/v5.2.5.zip

### DEPENDS ###
DKDEPEND(mingw32)
DKDEPEND(mingw64)
DKDEPEND(msys)


### VERSION ###
DKSET(XZ_VERSION 5.2.5)
DKSET(XZ_NAME xz-${XZ_VERSION})
#DKSET(XZ_DL https://github.com/xz-mirror/xz/archive/refs/tags/v${XZ_VERSION}.zip)
DKSET(XZ_DL https://tukaani.org/xz/${XZ_NAME}.tar.gz)
DKSET(XZ ${3RDPARTY}/${XZ_NAME})



### INSTALL ###
DKINSTALL(${XZ_DL} xz ${XZ})



### DKPLUGINS LINK ###
DKDEFINE(LZMA_API_STATIC)
DKINCLUDE(${XZ}/src/liblzma/api)
#WIN_DEBUG_LIB(${XZ}/${OS}/${DEBUG_DIR}/liblzma.lib)
#WIN_RELEASE_LIB(${XZ}/${OS}/${RELEASE_DIR}/liblzma.lib)
WIN_DEBUG_LIB(${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a)
WIN_RELEASE_LIB(${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)
MAC_DEBUG_LIB(${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a)
MAC_RELEASE_LIB(${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)
IOS_DEBUG_LIB(${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a)
IOS_RELEASE_LIB(${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)
LINUX_DEBUG_LIB(${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a)
LINUX_RELEASE_LIB(${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)
RASPBERRY_DEBUG_LIB(${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a)
RASPBERRY_RELEASE_LIB(${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)
ANDROID_DEBUG_LIB(${XZ}/${OS}/obj/local/armeabi-v7a/liblzma.a)
ANDROID_RELEASE_LIB(${XZ}/${OS}/obj/local/armeabi-v7a/liblzma.a)



### 3RDPARTY LINK ###
#DKSET(XZ_WIN -DCMAKE_C_FLAGS=/DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=/DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/liblzma.lib -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/liblzma.lib)
DKSET(XZ_WIN -DCMAKE_C_FLAGS=/DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=/DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)

DKSET(XZ_APPLE -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)

DKSET(XZ_LINUX -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)

DKSET(XZ_RASPBERRY -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)

DKSET(XZ_ANDROID -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/obj/local/armeabi-v7a/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/obj/local/armeabi-v7a/liblzma.a)


### COMPILE with cmake ###
#WIN_PATH(${XZ}/${OS})
#WIN32_COMMAND(${DKCMAKE_WIN32} -DBUILD_SHARED_LIBS=OFF ${XZ})
#WIN64_COMMAND(${DKCMAKE_WIN64} ${XZ})
#WIN_VS(${XZ_NAME} xz.sln liblzma)


### COMPILE with mingw ###
WIN32_PATH(${XZ}/${OS}/${DEBUG_DIR})
WIN32_BASH("#!/bin/bash 
cd /${XZ}/${OS}/${DEBUG_DIR} 
export PATH=/${MINGW32}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static
make 
exit \n")

WIN32_PATH(${XZ}/${OS}/${RELEASE_DIR})
WIN32_BASH("#!/bin/bash 
cd /${XZ}/${OS}/${RELEASE_DIR} 
export PATH=/${MINGW32}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static
make 
exit \n")


# look at xz/windows/build.bash for details
WIN64_PATH(${XZ}/${OS}/${DEBUG_DIR})
WIN64_BASH("#!/bin/bash
cd /${XZ}/${OS}/${DEBUG_DIR}
export PATH=/${MINGW64}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static --prefix= --enable-silent-rules --disable-dependency-tracking --disable-nls --disable-scripts --build=x86_64-w64-mingw32 CFLAGS=-march=x86-64
make
exit \n")

WIN64_PATH(${XZ}/${OS}/${RELEASE_DIR})
WIN64_BASH("#!/bin/bash
cd /${XZ}/${OS}/${RELEASE_DIR}
export PATH=/${MINGW64}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static --prefix= --enable-silent-rules --disable-dependency-tracking --disable-nls --disable-scripts --build=x86_64-w64-mingw32 CFLAGS=-march=x86-64
make
exit \n")


#WIN64_BASH("#!/bin/bash 
#cd /${XZ}
#export PATH=/${MINGW64}/bin:$PATH\;
#export PATH=/${MSYS}/bin:$PATH\;
#windows/build.bash
#exit \n")


#MAC_PATH(${XZ}/${OS})
#MAC64_COMMAND(${DKCMAKE_MAC64} ${XZ})
#MAC_XCODE(${XZ_NAME} liblzma)
MAC_DEBUG_PATH(${XZ}/${OS}/${DEBUG_DIR})
MAC_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
MAC_DEBUG_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")
MAC_RELEASE_PATH(${XZ}/${OS}/${RELEASE_DIR})
MAC_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
MAC_RELEASE_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")


#IOS_PATH(${XZ}/${OS})
#IOS64_COMMAND(${DKCMAKE_IOS64} ${XZ})
#IOS_XCODE(${XZ_NAME} liblzma)


#IOSSIM_PATH(${XZ}/${OS})
#IOSSIM64_COMMAND(${DKCMAKE_IOSSIM64} ${XZ})
#IOSSIM_XCODE_RELEASE(${XZ_NAME} liblzma)
IOSSIM_DEBUG_PATH(${XZ}/${OS}/${DEBUG_DIR})
IOSSIM_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
IOSSIM_DEBUG_COMMAND(make)
IOSSIM_RELEASE_PATH(${XZ}/${OS}/${RELEASE_DIR})
IOSSIM_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
IOSSIM_RELEASE_COMMAND(make)


LINUX_DEBUG_PATH(${XZ}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
#LINUX_DEBUG_COMMAND(${DKCMAKE_LINUX_DEBUG} ${XZ})
LINUX_DEBUG_COMMAND(make)


LINUX_RELEASE_PATH(${XZ}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
#LINUX_RELEASE_COMMAND(${DKCMAKE_LINUX_RELEASE} ${XZ})
LINUX_RELEASE_COMMAND(make)


RASPBERRY_DEBUG_PATH(${XZ}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
#RASPBERRY_DEBUG_COMMAND(${DKCMAKE_RASPBERRY_DEBUG} ${XZ})
RASPBERRY_DEBUG_COMMAND(make)

RASPBERRY_RELEASE_PATH(${XZ}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
#RASPBERRY_RELEASE_COMMAND(${DKCMAKE_RASPBERRY_RELEASE} ${XZ})
RASPBERRY_RELEASE_COMMAND(make)


##ANDROID_NDK(${XZ_NAME})

ANDROID_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
ANDROID_DEBUG_COMMAND(make)
ANDROID_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
ANDROID_RELEASE_COMMAND(make)

ANDROID_PATH(${XZ}/${OS})
ANDROID32_COMMAND(${DKCMAKE_ANDROID32} ${XZ})
ANDROID64_COMMAND(${DKCMAKE_ANDROID64} ${XZ})
ANDROID_VS(${XZ_NAME} xz.sln liblzma)
