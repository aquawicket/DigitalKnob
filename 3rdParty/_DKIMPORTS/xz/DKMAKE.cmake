# https://github.com/xz-mirror/xz.git
# https://tukaani.org/xz/xz-5.2.5.tar.gz
# https://github.com/xz-mirror/xz/archive/refs/tags/v5.2.5.zip


#dk_import(https://github.com/xz-mirror/xz/archive/20e7a33e2d59c6a814447d3991f21e2702174b20.zip)
dk_import(https://github.com/xz-mirror/xz.git)


### autotools ###
#dk_depend(mingw32)
#dk_depend(mingw64)
#dk_depend(msys2)
#dk_set(XZ_VERSION 5.2.5)
#dk_set(XZ_DL https://tukaani.org/xz/${XZ_FOLDER}.tar.gz)
#dk_set(XZ_NAME xz-${XZ_VERSION})
#dk_set(XZ ${3RDPARTY}/${XZ_FOLDER})
#dk_import(${XZ_DL} ${XZ})


### LINK ###
dk_define				(LZMA_API_STATIC)
dk_include				(${XZ}/src/liblzma/api)
WIN_dk_libDebug			(${XZ}/${OS}/${DEBUG_DIR}/liblzma.lib)
WIN_dk_libRelease		(${XZ}/${OS}/${RELEASE_DIR}/liblzma.lib)
UNIX_dk_libDebug		(${XZ}/${OS}/${DEBUG_DIR}/liblzma.a)
UNIX_dk_libRelease		(${XZ}/${OS}/${RELEASE_DIR}/liblzma.a)


### 3RDPARTY LINK ###
WIN_dk_set	(XZ_CMAKE -DCMAKE_C_FLAGS=/DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=/DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/liblzma.lib -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/liblzma.lib)
UNIX_dk_set	(XZ_CMAKE -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/liblzma.a)


### GENERATE ###
#if(IOSSIM)
#	IOSSIM_dk_queueCommand(${DKCMAKE_BUILD} -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_SYSROOT=iphonesimulator -DCMAKE_OSX_ARCHITECTURES=x86_64 ${XZ})
#else()
	dk_queueCommand(${DKCMAKE_BUILD} ${XZ})
#endif()


### COMPILE ###
dk_build(${XZ} liblzma)


#FIXME
return()

################## autotools #################################################
#WIN_dk_libDebug(${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a)
#WIN_dk_libRelease(${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)
#MAC_dk_libDebug(${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a)
#MAC_dk_libRelease(${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)
#IOS_dk_libDebug(${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a)
#IOS_dk_libRelease(${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)
#IOSSIM_dk_libDebug(${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a)
#IOSSIM_dk_libRelease(${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)
#LINUX_dk_libDebug(${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a)
#LINUX_dk_libRelease(${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)
#RASPBERRY_dk_libDebug(${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a)
#RASPBERRY_dk_libRelease(${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)
#ANDROID_dk_libDebug(${XZ}/${OS}/obj/local/armeabi-v7a/liblzma.a)
#ANDROID_dk_libRelease(${XZ}/${OS}/obj/local/armeabi-v7a/liblzma.a)

### 3RDPARTY LINK ###
WIN_dk_set		(XZ_CMAKE -DCMAKE_C_FLAGS=/DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=/DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)
APPLE_dk_set	(XZ_CMAKE -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)
LINUX_dk_set	(XZ_CMAKE -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)
RASPBERRY_dk_set(XZ_CMAKE -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)
ANDROID_dk_set	(XZ_CMAKE -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/obj/local/armeabi-v7a/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/obj/local/armeabi-v7a/liblzma.a)


### GENERATE / COMPILE ###
WIN32_DEBUG_dk_setPath		(${XZ}/${OS}/${DEBUG_DIR})
WIN32_DEBUG_dk_queueShell	(${DKCONFIGURE_BUILD})
WIN32_DEBUG_dk_queueShell	(make)
WIN32_RELEASE_dk_setPath	(${XZ}/${OS}/${RELEASE_DIR})
WIN32_RELEASE_dk_queueShell	(${DKCONFIGURE_BUILD})
WIN32_RELEASE_dk_queueShell	(make)

# look at xz/windows/build.bash for details
WIN64_DEBUG_dk_setPath		(${XZ}/${OS}/${DEBUG_DIR})
WIN64_DEBUG_dk_queueShell	(${DKCONFIGURE_BUILD} --prefix= --enable-silent-rules --disable-dependency-tracking --disable-nls --disable-scripts)
WIN64_DEBUG_dk_queueShell	(make)
WIN64_RELEASE_dk_setPath	(${XZ}/${OS}/${RELEASE_DIR})
WIN64_DEBUG_dk_queueShell	(${DKCONFIGURE_BUILD}  --prefix= --enable-silent-rules --disable-dependency-tracking --disable-nls --disable-scripts)
WIN64_RELEASE_dk_queueShell	(make)

UNIX_DEBUG_dk_setPath		(${XZ}/${OS}/${DEBUG_DIR})
UNIX_DEBUG_dk_queueShell	(${DKCONFIGURE_BUILD})
UNIX_DEBUG_dk_queueShell	(make)
UNIX_RELEASE_dk_setPath		(${XZ}/${OS}/${RELEASE_DIR})
UNIX_RELEASE_dk_queueShell	(${DKCONFIGURE_BUILD})
UNIX_RELEASE_dk_queueShell	(make)

ANDROID_dk_setPath		(${XZ}/${OS})
ANDROID_dk_queueCommand	(${DKCMAKE_BUILD} ${XZ})
ANDROID_dk_visualStudio	(${XZ} liblzma)
