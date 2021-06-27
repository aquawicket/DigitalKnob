## https://github.com/xz-mirror/xz

### DEPENDS ###
IF(WIN_32)
	DKDEPEND(mingw32)
ENDIF()
IF(WIN_64)
	DKDEPEND(mingw64)
ENDIF()
IF(WIN)
	DKDEPEND(msys)
ENDIF()

### VERSION ###
DKSET(XZ_VERSION 5.2.5)

### INSTALL ###
## https://github.com/xz-mirror/xz/archive/refs/tags/v5.2.5.zip
## DKINSTALL(https://astuteinternet.dl.sourceforge.net/project/lzmautils/xz-${XZ_VERSION}.tar.gz xz xz-${XZ_VERSION})
DKINSTALL(https://github.com/xz-mirror/xz/archive/refs/tags/v${XZ_VERSION}.zip xz xz-${XZ_VERSION})
DKSET(XZ ${3RDPARTY}/xz-${XZ_VERSION})


### LINK ###
DKINCLUDE(${XZ}/src/liblzma/api)
DKDEFINE(LZMA_API_STATIC)
WIN_DEBUG_LIB(${XZ}/${OS}/Debug/liblzma.lib)
WIN_RELEASE_LIB(${XZ}/${OS}/Release/liblzma.lib)
MAC_DEBUG_LIB(${XZ}/${OS}/${DEBUG}/src/liblzma/.libs/liblzma.a)
MAC_RELEASE_LIB(${XZ}/${OS}/${RELEASE}/src/liblzma/.libs/liblzma.a)
LINUX_DEBUG_LIB(${XZ}/${OS}/Debug/src/liblzma/.libs/liblzma.a)
LINUX_RELEASE_LIB(${XZ}/${OS}/Release/src/liblzma/.libs/liblzma.a)
## ANDROID_DEBUG_LIB(${XZ}/${OS}/obj/local/armeabi-v7a/liblzma.a)
## ANDROID_RELEASE_LIB(${XZ}/${OS}/obj/local/armeabi-v7a/liblzma.a)
RASPBERRY_DEBUG_LIB(${XZ}/${OS}/Debug/src/liblzma/.libs/liblzma.a)
RASPBERRY_RELEASE_LIB(${XZ}/${OS}/Release/src/liblzma/.libs/liblzma.a)

### COMPILE ###
DKSETPATH(${XZ}/${OS})
WIN32_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A Win32 "-DCMAKE_C_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo" "-DCMAKE_C_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_C_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" ${XZ})
WIN32_VS_DEBUG(xz-${XZ_VERSION} xz.sln liblzma)
WIN32_VS_RELEASE(xz-${XZ_VERSION} xz.sln liblzma)

DKSETPATH(${XZ}/${OS})
WIN64_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A x64 "-DCMAKE_C_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo" "-DCMAKE_C_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_C_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" ${XZ})
WIN64_VS_DEBUG(xz-${XZ_VERSION} xz.sln liblzma)
WIN64_VS_RELEASE(xz-${XZ_VERSION} xz.sln liblzma)

#DKSETPATH(${XZ}/win32/Debug)
#WIN32_BASH("#!/bin/bash\;
#cd ${XZ}/win32/Debug\;
#export PATH=/${MINGW32}/bin:$PATH\;
#export PATH=/${MSYS}/bin:$PATH\;
#../../configure --disable-shared --enable-static\;
#make\;
#exit\;")
#DKRENAME(${XZ}/win32/Debug/src/liblzma/.libs/liblzma.a ${XZ}/win32/Debug/src/liblzma/.libs/liblzma.lib)

#DKSETPATH(${XZ}/win32/Release)
#WIN32_BASH("#!/bin/bash\;
#cd ${XZ}/win32/Release\;
#export PATH=/${MINGW32}/bin:$PATH\;
#export PATH=/${MSYS}/bin:$PATH\;
#../../configure --disable-shared --enable-static\;
#make\;
#exit\;")
#DKRENAME(${XZ}/win32/Release/src/liblzma/.libs/liblzma.a ${XZ}/win32/Release/src/liblzma/.libs/liblzma.lib)


DKSETPATH(${XZ}/win64/Debug)
WIN64_BASH("#!/bin/bash\;
cd ${XZ}/win64/Debug\;
export PATH=/${MINGW64}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static --build=x86_64-w64-mingw32\;
make\;
exit\;")
DKRENAME(${XZ}/win64/Debug/src/liblzma/.libs/liblzma.a ${XZ}/win64/Debug/src/liblzma/.libs/liblzma.lib)

DKSETPATH(${XZ}/win64/Release)
WIN64_BASH("#!/bin/bash\;
cd ${XZ}/win64/Release\;
export PATH=/${MINGW64}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
../../configure --disable-shared --enable-static --build=x86_64-w64-mingw32\;
make\;
exit\;")
DKRENAME(${XZ}/win64/Release/src/liblzma/.libs/liblzma.a ${XZ}/win64/Release/src/liblzma/.libs/liblzma.lib)

DKSETPATH(${XZ}/${OS}/Debug)
MAC_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
MAC_DEBUG_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")

DKSETPATH(${XZ}/${OS}/Release)
MAC_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
MAC_RELEASE_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")


## DKSETPATH(${XZ}/${OS}/Debug)
## IOSSIM_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
## IOSSIM_DEBUG_COMMAND(make)

## DKSETPATH(${XZ}/${OS}/Release)
## IOSSIM_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
## IOSSIM_RELEASE_COMMAND(make)


DKSETPATH(${XZ}/${OS}/Debug)
LINUX_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
LINUX_DEBUG_COMMAND(make)

DKSETPATH(${XZ}/${OS}/Release)
LINUX_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
LINUX_RELEASE_COMMAND(make)


## ANDROID_NDK_DEBUG(xz-${XZ_VERSION})
## ANDROID_NDK_RELEASE(xz-${XZ_VERSION})


DKSETPATH(${XZ}/${OS}/Debug)
RASPBERRY_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
RASPBERRY_DEBUG_COMMAND(make)

DKSETPATH(${XZ}/${OS}/Release)
RASPBERRY_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
RASPBERRY_RELEASE_COMMAND(make)



### INJECT ###
DKSET(XZ_WIN32 -DCMAKE_C_FLAGS=/DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/Debug/liblzma.lib -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/Release/liblzma.lib)