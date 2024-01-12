# https://github.com/xz-mirror/xz.git
# https://tukaani.org/xz/xz-5.2.5.tar.gz
# https://github.com/xz-mirror/xz/archive/refs/tags/v5.2.5.zip


### IMPORT ###
dk_import(https://github.com/xz-mirror/xz.git)


#dkFileReplace("${XZ}/src/liblzma/api/lzma.h" "__declspec(dllimport)" "")
#dkFileReplace("${XZ}/src/liblzma/common/common.h" "__declspec(dllexport)" "")
#dkFileReplace("${XZ}/src/liblzma/api/lzma.h" "__cdecl" "")

### autotools ###
#dk_set(XZ_VERSION 5.2.5)
#dk_set(XZ_DL https://tukaani.org/xz/${XZ_FOLDER}.tar.gz)
#dk_set(XZ_NAME xz-${XZ_VERSION})
#dk_set(XZ ${3RDPARTY}/${XZ_FOLDER})
#dk_import(${XZ_DL} ${XZ})

#if(NOT WIN)
### LINK ###
dk_define			(LZMA_API_STATIC)
dk_include			(${XZ}/src/liblzma/api)

if(MSVC)
	dk_libDebug		(${XZ}/${OS}/${DEBUG_DIR}/liblzma.lib)
	dk_libRelease	(${XZ}/${OS}/${RELEASE_DIR}/liblzma.lib)
else()
	dk_libDebug		(${XZ}/${OS}/${DEBUG_DIR}/liblzma.a)
	dk_libRelease	(${XZ}/${OS}/${RELEASE_DIR}/liblzma.a)
endif()



### 3RDPARTY LINK ###
if(MSVC)
	dk_set	(XZ_CMAKE -DCMAKE_C_FLAGS=/DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=/DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/liblzma.lib -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/liblzma.lib)
else()
	dk_set	(XZ_CMAKE "-DCMAKE_C_FLAGS=-DLZMA_API_STATIC" "-DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC" -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/liblzma.a)
endif()



### GENERATE ###
if(MSVC)
	dk_queueCommand(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=/DLZMA_API_STATIC" "-DCMAKE_CXX_FLAGS=/DLZMA_API_STATIC" ${XZ})
else()
	dk_queueCommand(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=-DLZMA_API_STATIC" "-DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC" ${XZ})
endif()



### COMPILE ###
if(MSVC)
	list(APPEND DEBUG_LINK_FLAGS /ignore:4217)
	list(APPEND RELEASE_LINK_FLAGS /ignore:4217)
endif()
dk_build(${XZ} liblzma)


#FIXME
dk_return()
#else()

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
ANDROID_dk_set	(XZ_CMAKE -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/obj/local/armeabi-v7a/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/obj/local/armeabi-v7a/liblzma.a)
APPLE_dk_set	(XZ_CMAKE -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)
LINUX_dk_set	(XZ_CMAKE -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)
RASPBERRY_dk_set(XZ_CMAKE -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)
WIN_dk_set		(XZ_CMAKE -DCMAKE_C_FLAGS=/DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=/DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${XZ}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${XZ}/${OS}/${DEBUG_DIR}/src/liblzma/.libs/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${XZ}/${OS}/${RELEASE_DIR}/src/liblzma/.libs/liblzma.a)


### GENERATE / COMPILE ###
ANDROID_dk_setPath				(${XZ}/${OS})
ANDROID_dk_queueCommand			(${DKCMAKE_BUILD} ${XZ})
ANDROID_dk_visualStudio			(${XZ} liblzma)

dk_setPath						(${XZ})
dk_queueCommand					(autoreconf -f -i)
		
UNIX_DEBUG_dk_setPath			(${XZ}/${OS}/${DEBUG_DIR})
UNIX_DEBUG_dk_queueCommand		(${DKCONFIGURE_BUILD})
UNIX_DEBUG_dk_queueCommand		(make)
UNIX_RELEASE_dk_setPath			(${XZ}/${OS}/${RELEASE_DIR})
UNIX_RELEASE_dk_queueCommand	(${DKCONFIGURE_BUILD})
UNIX_RELEASE_dk_queueCommand	(make)

WIN32_DEBUG_dk_setPath			(${XZ}/${OS}/${DEBUG_DIR})
WIN32_DEBUG_dk_queueCommand		(${DKCONFIGURE_BUILD})
WIN32_DEBUG_dk_queueCommand		(make)
WIN32_RELEASE_dk_setPath		(${XZ}/${OS}/${RELEASE_DIR})
WIN32_RELEASE_dk_queueCommand	(${DKCONFIGURE_BUILD})
WIN32_RELEASE_dk_queueCommand	(make)

# look at xz/windows/build.bash for details
WIN64_DEBUG_dk_setPath			(${XZ}/${OS}/${DEBUG_DIR})
WIN64_DEBUG_dk_queueCommand		(${DKCONFIGURE_BUILD} --prefix= --enable-silent-rules --disable-dependency-tracking --disable-nls --disable-scripts)
WIN64_DEBUG_dk_queueCommand		(make)
WIN64_RELEASE_dk_setPath		(${XZ}/${OS}/${RELEASE_DIR})
WIN64_DEBUG_dk_queueCommand		(${DKCONFIGURE_BUILD}  --prefix= --enable-silent-rules --disable-dependency-tracking --disable-nls --disable-scripts)
WIN64_RELEASE_dk_queueCommand	(make)

#endif()