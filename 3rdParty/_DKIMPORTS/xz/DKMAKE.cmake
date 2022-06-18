# https://github.com/xz-mirror/xz
#
# https://tukaani.org/xz/xz-5.2.5.tar.gz
# https://github.com/xz-mirror/xz/archive/refs/tags/v5.2.5.zip




### cmake ###
dk_import(https://github.com/xz-mirror/xz/archive/20e7a33e2d59c6a814447d3991f21e2702174b20.zip)


### autotools ###
#dk_depend(mingw32)
#dk_depend(mingw64)
#dk_depend(msys2)
#dk_set(XZ_VERSION 5.2.5)
#dk_set(XZ_DL https://tukaani.org/xz/${XZ_NAME}.tar.gz)
#dk_set(XZ_NAME xz-${XZ_VERSION})
#dk_set(XZ ${3RDPARTY}/${XZ_NAME})
#dk_install(${XZ_DL} xz ${XZ})



dk_define(LZMA_API_STATIC)
dk_include(${XZ}/src/liblzma/api)

############## cmake #########################################
WIN_dk_libDebug(${XZ}/${OS}/${DEBUG_DIR}/liblzma.lib)
WIN_dk_libRelease(${XZ}/${OS}/${RELEASE_DIR}/liblzma.lib)
MAC_dk_libDebug(${XZ}/${OS}/${DEBUG_DIR}/liblzma.a)
MAC_dk_libRelease(${XZ}/${OS}/${RELEASE_DIR}/liblzma.a)
IOS_dk_libDebug(${XZ}/${OS}/${DEBUG_DIR}/liblzma.a)
IOS_dk_libRelease(${XZ}/${OS}/${RELEASE_DIR}/liblzma.a)
IOSSIM_dk_libDebug(${XZ}/${OS}/${DEBUG_DIR}/liblzma.a)
IOSSIM_dk_libRelease(${XZ}/${OS}/${RELEASE_DIR}/liblzma.a)
LINUX_dk_libDebug(${XZ}/${OS}/${DEBUG_DIR}/liblzma.a)
LINUX_dk_libRelease(${XZ}/${OS}/${RELEASE_DIR}/liblzma.a)
RASPBERRY_dk_libDebug(${XZ}/${OS}/${DEBUG_DIR}/liblzma.a)
RASPBERRY_dk_libRelease(${XZ}/${OS}/${RELEASE_DIR}/liblzma.a)
ANDROID_dk_libDebug(${XZ}/${OS}/${DEBUG_DIR}/liblzma.a)
ANDROID_dk_libRelease(${XZ}/${OS}/${RELEASE_DIR}/liblzma.a)

### 3RDPARTY LINK ###
WIN_dk_set		(XZ_CMAKE -DCMAKE_C_FLAGS=/DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=/DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/liblzma.lib -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/liblzma.a)
APPLE_dk_set		(XZ_CMAKE -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/liblzma.a)
LINUX_dk_set		(XZ_CMAKE -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/liblzma.a)
RASPBERRY_dk_set	(XZ_CMAKE -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/liblzma.a)
ANDROID_dk_set	(XZ_CMAKE -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG}/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${DEBUG}/liblzma.a)

dk_setPath(${XZ}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} ${XZ})
dk_VisualStudio(${XZ_NAME} xz.sln liblzma)
#WIN_dk_VisualStudio(${XZ_NAME} xz.sln liblzma)
dk_xcode(${XZ_NAME} liblzma)
#MAC_dk_xcode(${XZ_NAME} liblzma)
#IOS_dk_xcode(${XZ_NAME} liblzma)
#IOSSIM_dk_xcode(${XZ_NAME} liblzma)
LINUX_dk_queueCommand(make liblzma)
RASPBERRY_dk_queueCommand(make liblzma)
#ANDROID_dk_VisualStudio(${XZ_NAME} xz.sln liblzma)	
############################################################


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
WIN_dk_set(XZ_CMAKE -DCMAKE_C_FLAGS=/DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=/DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)
APPLE_dk_set(XZ_CMAKE -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)
LINUX_dk_set(XZ_CMAKE -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)
RASPBERRY_dk_set(XZ_CMAKE -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)
ANDROID_dk_set(XZ_CMAKE -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/obj/local/armeabi-v7a/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/obj/local/armeabi-v7a/liblzma.a)


### COMPILE ###
WIN32_DEBUG_dk_setPath(${XZ}/${OS}/${DEBUG_DIR})
WIN32_DEBUG_dk_msys(${DKCONFIGURE_BUILD})
WIN32_DEBUG_dk_msys(make)
WIN32_RELEASE_dk_setPath(${XZ}/${OS}/${RELEASE_DIR})
WIN32_RELEASE_dk_msys(${DKCONFIGURE_BUILD})
WIN32_RELEASE_dk_msys(make)


# look at xz/windows/build.bash for details
WIN64_DEBUG_dk_setPath(${XZ}/${OS}/${DEBUG_DIR})
WIN64_DEBUG_dk_msys(${DKCONFIGURE_BUILD} --prefix= --enable-silent-rules --disable-dependency-tracking --disable-nls --disable-scripts)
WIN64_DEBUG_dk_msys(make)
WIN64_RELEASE_dk_setPath(${XZ}/${OS}/${RELEASE_DIR})
WIN64_DEBUG_dk_msys(${DKCONFIGURE_BUILD}  --prefix= --enable-silent-rules --disable-dependency-tracking --disable-nls --disable-scripts)
WIN64_RELEASE_dk_msys(make)


MAC_DEBUG_dk_setPath(${XZ}/${OS}/${DEBUG_DIR})
MAC_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
MAC_DEBUG_dk_queueCommand(make)
MAC_RELEASE_dk_setPath(${XZ}/${OS}/${RELEASE_DIR})
MAC_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
MAC_RELEASE_dk_queueCommand(make)


IOS_DEBUG_dk_setPath(${XZ}/${OS}/${DEBUG_DIR})
IOS_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
IOS_DEBUG_dk_queueCommand(make)
IOS_RELEASE_dk_setPath(${XZ}/${OS}/${RELEASE_DIR})
IOS_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
IOS_RELEASE_dk_queueCommand(make)



IOSSIM_DEBUG_dk_setPath(${XZ}/${OS}/${DEBUG_DIR})
IOSSIM_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
IOSSIM_DEBUG_dk_queueCommand(make)
IOSSIM_RELEASE_dk_setPath(${XZ}/${OS}/${RELEASE_DIR})
IOSSIM_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
IOSSIM_RELEASE_dk_queueCommand(make)


LINUX_DEBUG_dk_setPath(${XZ}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
LINUX_DEBUG_dk_queueCommand(make)
LINUX_RELEASE_dk_setPath(${XZ}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
LINUX_RELEASE_dk_queueCommand(make)


RASPBERRY_DEBUG_dk_setPath(${XZ}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_dk_queueCommand(${DKCONFIGURE_BUILD})
RASPBERRY_DEBUG_dk_queueCommand(make)
RASPBERRY_RELEASE_dk_setPath(${XZ}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_dk_queueCommand(${DKCONFIGURE_BUILD})
RASPBERRY_RELEASE_dk_queueCommand(make)


ANDROID_DEBUG_dk_msys(${DKCONFIGURE_BUILD})
ANDROID_DEBUG_dk_msys(make)
ANDROID_RELEASE_dk_msys(${DKCONFIGURE_BUILD})
ANDROID_RELEASE_dk_msys(make)

ANDROID_dk_setPath(${XZ}/${OS})
ANDROID_dk_queueCommand(${DKCMAKE_BUILD} ${XZ})
ANDROID_dk_VisualStudio(${XZ_NAME} xz.sln liblzma)


############################################################################