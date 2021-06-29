## https://github.com/xz-mirror/xz

if(LINUX_32)
	return()
endif()

### DEPENDS ###
IF(WIN_32)
	#DKDEPEND(mingw32)
ENDIF()
IF(WIN_64)
	#DKDEPEND(mingw64)
ENDIF()
IF(WIN)
	#DKDEPEND(msys)
ENDIF()


### VERSION ###
DKSET(XZ_VERSION 5.2.5)
DKSET(XZ ${3RDPARTY}/xz-${XZ_VERSION})



### INSTALL ###
## https://github.com/xz-mirror/xz/archive/refs/tags/v5.2.5.zip
## DKINSTALL(https://astuteinternet.dl.sourceforge.net/project/lzmautils/xz-${XZ_VERSION}.tar.gz xz xz-${XZ_VERSION})
DKINSTALL(https://github.com/xz-mirror/xz/archive/refs/tags/v${XZ_VERSION}.zip xz xz-${XZ_VERSION})



### DKPLUGINS LINK ###
DKDEFINE(LZMA_API_STATIC)
DKINCLUDE(${XZ}/src/liblzma/api)
WIN_DEBUG_LIB(${XZ}/${OS}/${DEBUG}/liblzma.lib)
WIN_RELEASE_LIB(${XZ}/${OS}/${RELEASE}/liblzma.lib)
MAC_DEBUG_LIB(${XZ}/${OS}/${DEBUG}/liblzma.a)
MAC_RELEASE_LIB(${XZ}/${OS}/${RELEASE}/liblzma.a)
#MAC_DEBUG_LIB(${XZ}/${OS}/${DEBUG}/src/liblzma/.libs/liblzma.a)
#MAC_RELEASE_LIB(${XZ}/${OS}/${RELEASE}/src/liblzma/.libs/liblzma.a)
LINUX_DEBUG_LIB(${XZ}/${OS}/${DEBUG}/liblzma.a)
LINUX_RELEASE_LIB(${XZ}/${OS}/${RELEASE}/liblzma.a)
#LINUX_DEBUG_LIB(${XZ}/${OS}/${DEBUG}/src/liblzma/.libs/liblzma.a)
#LINUX_RELEASE_LIB(${XZ}/${OS}/${RELEASE}/src/liblzma/.libs/liblzma.a)
RASPBERRY_DEBUG_LIB(${XZ}/${OS}/${DEBUG}/liblzma.a)
RASPBERRY_RELEASE_LIB(${XZ}/${OS}/${RELEASE}/liblzma.a)
#RASPBERRY_DEBUG_LIB(${XZ}/${OS}/${DEBUG}/src/liblzma/.libs/liblzma.a)
#RASPBERRY_RELEASE_LIB(${XZ}/${OS}/${RELEASE}/src/liblzma/.libs/liblzma.a)
ANDROID_DEBUG_LIB(${XZ}/${OS}/obj/local/armeabi-v7a/liblzma.a)
ANDROID_RELEASE_LIB(${XZ}/${OS}/obj/local/armeabi-v7a/liblzma.a)



### 3RDPARTY LINK ###
DKSET(XZ_WIN -DCMAKE_C_FLAGS=/DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG}/liblzma.lib -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE}/liblzma.lib)
DKSET(XZ_APPLE -DCMAKE_C_FLAGS=/DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG}/liblzma.lib -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE}/liblzma.lib)
DKSET(XZ_LINUX -DCMAKE_C_FLAGS=/DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG}/liblzma.lib -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE}/liblzma.lib)
DKSET(XZ_RASPBERRY -DCMAKE_C_FLAGS=/DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG}/liblzma.lib -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE}/liblzma.lib)



### COMPILE ###
WIN_PATH(${XZ}/${OS})
WIN32_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A Win32 "-DCMAKE_C_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo" "-DCMAKE_C_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_C_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" ${XZ})
WIN64_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A x64 "-DCMAKE_C_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo" "-DCMAKE_C_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_C_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" ${XZ})
WIN_VS(xz-${XZ_VERSION} xz.sln liblzma)

#DKSETPATH(${XZ}/win32/${DEBUG})
#WIN32_BASH("#!/bin/bash\;
#cd ${XZ}/win32/${DEBUG}\;
#export PATH=/${MINGW32}/bin:$PATH\;
#export PATH=/${MSYS}/bin:$PATH\;
#../../configure --disable-shared --enable-static\;
#make\;
#exit\;")
#DKRENAME(${XZ}/win32/${DEBUG}/src/liblzma/.libs/liblzma.a ${XZ}/win32/${DEBUG}/src/liblzma/.libs/liblzma.lib)
#DKSETPATH(${XZ}/win32/${RELEASE})
#WIN32_BASH("#!/bin/bash\;
#cd ${XZ}/win32/${RELEASE}\;
#export PATH=/${MINGW32}/bin:$PATH\;
#export PATH=/${MSYS}/bin:$PATH\;
#../../configure --disable-shared --enable-static\;
#make\;
#exit\;")
#DKRENAME(${XZ}/win32/${RELEASE}/src/liblzma/.libs/liblzma.a ${XZ}/win32/${RELEASE}/src/liblzma/.libs/liblzma.lib)


#DKSETPATH(${XZ}/win64/${DEBUG})
#WIN64_BASH("#!/bin/bash\;
#cd ${XZ}/win64/${DEBUG}\;
#export PATH=/${MINGW64}/bin:$PATH\;
#export PATH=/${MSYS}/bin:$PATH\;
#../../configure --disable-shared --enable-static --build=x86_64-w64-mingw32\;
#make\;
#exit\;")
#DKRENAME(${XZ}/win64/${DEBUG}/src/liblzma/.libs/liblzma.a ${XZ}/win64/${DEBUG}/src/liblzma/.libs/liblzma.lib)
#DKSETPATH(${XZ}/win64/${RELEASE})
#WIN64_BASH("#!/bin/bash\;
#cd ${XZ}/win64/${RELEASE}\;
#export PATH=/${MINGW64}/bin:$PATH\;
#export PATH=/${MSYS}/bin:$PATH\;
#../../configure --disable-shared --enable-static --build=x86_64-w64-mingw32\;
#make\;
#exit\;")
#DKRENAME(${XZ}/win64/${RELEASE}/src/liblzma/.libs/liblzma.a ${XZ}/win64/${RELEASE}/src/liblzma/.libs/liblzma.lib)


MAC64_PATH(${XZ}/${OS})
MAC64_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DCMAKE_OSX_ARCHITECTURES=x86_64 ${XZ})
MAC64_XCODE_DEBUG(xz-${XZ_VERSION} liblzma)
MAC64_XCODE_RELEASE(xz-${XZ_VERSION} liblzma)
#DKSETPATH(${XZ}/${OS}/${DEBUG})
#MAC_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
#MAC_DEBUG_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")
#DKSETPATH(${XZ}/${OS}/${RELEASE})
#MAC_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
#MAC_RELEASE_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")


IOS_PATH(${XZ}/${OS})
IOS_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/iOS.cmake -DIOS_PLATFORM=OS ${XZ})
IOS_XCODE_DEBUG(xz-${XZ_VERSION} liblzma)
IOS_XCODE_RELEASE(xz-${XZ_VERSION} liblzma)


IOSSIM64_PATH(${XZ}/${OS})
IOSSIM64_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/iOS.cmake -DIOS_PLATFORM=SIMULATOR64 ${XZ})
IOSSIM64_XCODE_DEBUG(xz-${XZ_VERSION} liblzma)
IOSSIM64_XCODE_RELEASE(xz-${XZ_VERSION} liblzma)
## DKSETPATH(${XZ}/${OS}/${DEBUG})
## IOSSIM_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
## IOSSIM_DEBUG_COMMAND(make)
## DKSETPATH(${XZ}/${OS}/${RELEASE})
## IOSSIM_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
## IOSSIM_RELEASE_COMMAND(make)


LINUX_DEBUG_PATH(${XZ}/${OS}/${DEBUG})
LINUX_DEBUG_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG ${XZ})
LINUX_DEBUG_COMMAND(make liblzma)
LINUX_RELEASE_PATH(${XZ}/${OS}/${RELEASE})
LINUX_RELEASE_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE ${XZ})
LINUX_RELEASE_COMMAND(make liblzma)
#DKSETPATH(${XZ}/${OS}/${DEBUG})
#LINUX_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
#LINUX_DEBUG_COMMAND(make)
#DKSETPATH(${XZ}/${OS}/${RELEASE})
#LINUX_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
#LINUX_RELEASE_COMMAND(make)


RASPBERRY_DEBUG_PATH(${XZ}/${OS}/${DEBUG})
RASPBERRY_DEBUG_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG -S ${XZ} -B ${XZ}/${OS}/${DEBUG})
RASPBERRY_DEBUG_COMMAND(make liblzma)
RASPBERRY_RELEASE_PATH(${XZ}/${OS}/${RELEASE})
RASPBERRY_RELEASE_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE ${XZ})
RASPBERRY_RELEASE_COMMAND(make liblzma)
#DKSETPATH(${XZ}/${OS}/${DEBUG})
#RASPBERRY_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
#RASPBERRY_DEBUG_COMMAND(make)
#DKSETPATH(${XZ}/${OS}/${RELEASE})
#RASPBERRY_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
#RASPBERRY_RELEASE_COMMAND(make)


ANDROID_NDK_DEBUG(xz-${XZ_VERSION})
ANDROID_NDK_RELEASE(xz-${XZ_VERSION})
