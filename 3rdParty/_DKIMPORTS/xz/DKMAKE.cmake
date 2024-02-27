# https://github.com/tukaani-project/xz.git
# https://github.com/tukaani-project/xz/releases/download/v5.4.6/xz-5.4.6.tar.gz


### IMPORT ###
#dk_import(https://github.com/tukaani-project/xz.git)
dk_import(https://github.com/tukaani-project/xz/releases/download/v5.4.6/xz-5.4.6.tar.gz)


#dk_fileReplace("${XZ}/src/liblzma/api/lzma.h" "__declspec(dllimport)" "")
#dk_fileReplace("${XZ}/src/liblzma/common/common.h" "__declspec(dllexport)" "")
#dk_fileReplace("${XZ}/src/liblzma/api/lzma.h" "__cdecl" "")

### autotools ###
#dk_set(XZ_VERSION 5.2.5)
#dk_set(XZ_DL https://tukaani.org/xz/${XZ_FOLDER}.tar.gz)
#dk_set(XZ_NAME xz-${XZ_VERSION})
#dk_set(XZ ${3RDPARTY}/${XZ_FOLDER})
#dk_import(${XZ_DL} ${XZ})

#if(NOT WIN)
### LINK ###
dk_define			(LZMA_API_STATIC)
dk_include			(${XZ}/src/liblzma/api 						LIBLZMA_INCLUDE_DIR)

if(MSVC)
	dk_libDebug		(${XZ}/${OS}/${DEBUG_DIR}/liblzma.lib		LIBLZMA_LIBRARY_DEBUG)
	dk_libRelease	(${XZ}/${OS}/${RELEASE_DIR}/liblzma.lib		LIBLZMA_LIBRARY_RELEASE)
else()
	dk_libDebug		(${XZ}/${OS}/${DEBUG_DIR}/liblzma.a			LIBLZMA_LIBRARY_DEBUG)
	dk_libRelease	(${XZ}/${OS}/${RELEASE_DIR}/liblzma.a		LIBLZMA_LIBRARY_RELEASE)
endif()



### 3RDPARTY LINK ###
if(MSVC)
	dk_set	(XZ_CMAKE -DCMAKE_C_FLAGS=/DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=/DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${LIBLZMA_INCLUDE_DIR} -DLIBLZMA_LIBRARY_DEBUG=${LIBLZMA_LIBRARY_DEBUG} -DLIBLZMA_LIBRARY_RELEASE=${LIBLZMA_LIBRARY_RELEASE})
else()
	DEBUG_dk_set	(XZ_CMAKE "-DCMAKE_C_FLAGS=-DLZMA_API_STATIC" "-DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC" -DLIBLZMA_INCLUDE_DIR=${LIBLZMA_INCLUDE_DIR} -DLIBLZMA_LIBRARY=${LIBLZMA_LIBRARY_DEBUG} -DLIBLZMA_HAS_AUTO_DECODER=ON -DLIBLZMA_HAS_EASY_ENCODER=ON -DLIBLZMA_HAS_LZMA_PRESET=ON)
	RELEASE_dk_set	(XZ_CMAKE "-DCMAKE_C_FLAGS=-DLZMA_API_STATIC" "-DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC" -DLIBLZMA_INCLUDE_DIR=${LIBLZMA_INCLUDE_DIR} -DLIBLZMA_LIBRARY=${LIBLZMA_LIBRARY_RELEASE} -DLIBLZMA_HAS_AUTO_DECODER=ON -DLIBLZMA_HAS_EASY_ENCODER=ON -DLIBLZMA_HAS_LZMA_PRESET=ON)
endif()

# TODO
# BUILD_SHARED_LIBS "Build liblzma as a shared library instead of static"
# LIBLZMA_HAS_AUTO_DECODER
# LIBLZMA_HAS_EASY_ENCODER
# LIBLZMA_HAS_LZMA_PRESET
# ENABLE_SMALL "Reduce code size at expense of speed. This may be useful together with CMAKE_BUILD_TYPE=MinSizeRel."
# MICROLZMA_ENCODER "MicroLZMA encoder (needed by specific applications only)" ON
# MICROLZMA_DECODER "MicroLZMA decoder (needed by specific applications only)" ON
# LZIP_DECODER "Support lzip decoder" ON
# ALLOW_ATTR_IFUNC "Allow use of __attribute__((__ifunc__())) if supported by the system" ON
# CREATE_XZ_SYMLINKS "Create unxz and xzcat symlinks" ON
# CREATE_LZMA_SYMLINKS "Create lzma, unlzma, and lzcat symlinks" ON

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
UNIX_DEBUG_dk_build				(${XZ})
UNIX_RELEASE_dk_setPath			(${XZ}/${OS}/${RELEASE_DIR})
UNIX_RELEASE_dk_queueCommand	(${DKCONFIGURE_BUILD})
UNIX_RELEASE_dk_build			(${XZ})

WIN_X86_DEBUG_dk_setPath			(${XZ}/${OS}/${DEBUG_DIR})
WIN_X86_DEBUG_dk_queueCommand		(${DKCONFIGURE_BUILD})
WIN_X86_DEBUG_dk_build			(${XZ})
WIN_X86_RELEASE_dk_setPath		(${XZ}/${OS}/${RELEASE_DIR})
WIN_X86_RELEASE_dk_queueCommand	(${DKCONFIGURE_BUILD})
WIN_X86_RELEASE_dk_build			(${XZ})

# look at xz/windows/build.bash for details
WIN_X86_64_DEBUG_dk_setPath			(${XZ}/${OS}/${DEBUG_DIR})
WIN_X86_64_DEBUG_dk_queueCommand		(${DKCONFIGURE_BUILD} --prefix= --enable-silent-rules --disable-dependency-tracking --disable-nls --disable-scripts)
WIN_X86_64_DEBUG_dk_build			(${XZ})
WIN_X86_64_RELEASE_dk_setPath		(${XZ}/${OS}/${RELEASE_DIR})
WIN_X86_64_DEBUG_dk_queueCommand		(${DKCONFIGURE_BUILD}  --prefix= --enable-silent-rules --disable-dependency-tracking --disable-nls --disable-scripts)
WIN_X86_64_RELEASE_dk_build			(${XZ})

#endif()