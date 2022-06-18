# https://www.sourceware.org/bzip2
# https://gitlab.com/bzip2/bzip2
# https://github.com/kiyolee/bzip2-win-build
# https://github.com/kiyolee/bzip2-win-build/archive/refs/tags/v1.0.8.zip
# https://gitlab.com/bzip2/bzip2/-/archive/bzip2-1.0.8/bzip2-bzip2-1.0.8.zip
if(WIN)
	return()
endif()


dk_depend(mingw32)
dk_depend(mingw64)
dk_depend(msys2)
dk_depend(libgcc)


WIN_DKIMPORT		(https://github.com/kiyolee/bzip2-win-build/archive/refs/tags/v1.0.8.zip)
LINUX_DKIMPORT		(ftp://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz)
RASPBERRY_DKIMPORT	(ftp://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz)
ANDROID_DKIMPORT	(ftp://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz)

#dk_set(BZIP2_VERSION 1.0.8)
#dk_set(BZIP2_NAME bzip2-${BZIP2_VERSION})
#WIN_dk_set(BZIP2_DL https://github.com/kiyolee/bzip2-win-build/archive/refs/tags/v1.0.8.zip)
#LINUX_dk_set(BZIP2_DL ftp://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz)
#RASPBERRY_dk_set(BZIP2_DL ftp://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz)
#ANDROID_dk_set(BZIP2_DL ftp://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz)
#dk_set(BZIP2 ${3RDPARTY}/${BZIP2_NAME})
#dk_install(${BZIP2_DL} bzip2 ${BZIP2})


if(NOT EXISTS ${BZIP2}/copy)
	dk_copy(${BZIP2} ${BZIP2}/copy TRUE)
endif()


### DKPLUGINS LINK ###
dk_include(${BZIP2})
WIN32_DEBUG_DKLIB(${BZIP2}/${OS}/${DEBUG_DIR}/libbz2-static.lib)
WIN32_RELEASE_DKLIB(${BZIP2}/${OS}/${RELEASE_DIR}/libbz2-static.lib)
WIN64_DEBUG_DKLIB(${BZIP2}/${OS}/x64/${DEBUG_DIR}/libbz2-static.lib)
WIN64_RELEASE_DKLIB(${BZIP2}/${OS}/x64/${RELEASE_DIR}/libbz2-static.lib)
MAC_DEBUG_DKLIB(${BZIP2}/${OS}/libbz2.a)
MAC_RELEASE_DKLIB(${BZIP2}/${OS}/libbz2.a)
LINUX_DEBUG_DKLIB(${BZIP2}/${OS}/libbz2.a)
LINUX_RELEASE_DKLIB(${BZIP2}/${OS}/libbz2.a)
RASPBERRY_DEBUG_DKLIB(${BZIP2}/${OS}/libbz2.a)
RASPBERRY_RELEASE_DKLIB(${BZIP2}/${OS}/libbz2.a)
ANDROID_DEBUG_DKLIB(${BZIP2}/${OS}/libbz2.a)
ANDROID_RELEASE_DKLIB(${BZIP2}/${OS}/libbz2.a)



### 3RDPARTY LINK ###
WIN_dk_set(BZIP2_CMAKE -DBZIP2_INCLUDE_DIR=${BZIP2} -DBZIP2_LIBRARY_DEBUG=${BZIP2}/${OS}/${DEBUG_DIR}/libbz2-static.lib -DBZIP2_LIBRARY_RELEASE=${BZIP2}/${OS}/${RELEASE_DIR}/libbz2-static.lib)
APPLE_dk_set(BZIP2_CMAKE -DBZIP2_INCLUDE_DIR=${BZIP2}/${OS} -DBZIP2_LIBRARY_DEBUG=${BZIP2}/${OS}/libbz2.a -DBZIP2_LIBRARY_RELEASE=${BZIP2}/${OS}/libbz2.a)
LINUX_dk_set(BZIP2_CMAKE -DBZIP2_INCLUDE_DIR=${BZIP2}/${OS} -DBZIP2_LIBRARY_DEBUG=${BZIP2}/${OS}/libbz2.a -DBZIP2_LIBRARY_RELEASE=${BZIP2}/${OS}/libbz2.a)
RASPBERRY_dk_set(BZIP2_CMAKE -DBZIP2_INCLUDE_DIR=${BZIP2}/${OS} -DBZIP2_LIBRARY_DEBUG=${BZIP2}/${OS}/libbz2.a -DBZIP2_LIBRARY_RELEASE=${BZIP2}/${OS}/libbz2.a)
ANDROID_dk_set(BZIP2_CMAKE -DBZIP2_INCLUDE_DIR=${BZIP2}/${OS} -DBZIP2_LIBRARY_DEBUG=${BZIP2}/${OS}/libbz2.a -DBZIP2_LIBRARY_RELEASE=${BZIP2}/${OS}/libbz2.a)
	


### COMPILE ###
if(WIN_32)
	dk_define(BZ_NO_STDIO)
	dk_copy(${BZIP2}/build-VS2019 ${BZIP2}/${OS} FALSE)
	WIN32_dk_setPath(${BZIP2}/${OS})
	WIN32_dk_VisualStudio(${BZIP2_NAME} bzip2.sln libbz2-static)
endif()


if(WIN_64)
	dk_copy(${BZIP2}/win32/bzip2.rc ${BZIP2}/${OS}/bzip2.rc FALSE) #copy project files that came with bzip
	dk_copy(${BZIP2}/win32/bzip2recover.rc ${BZIP2}/${OS}/bzip2recover.rc FALSE)
	dk_copy(${BZIP2}/win32/bzip2_version.h ${BZIP2}/${OS}/bzip2_version.h FALSE)
	dk_copy(${BZIP2}/win32/libbz2.rc ${BZIP2}/${OS}/libbz2.rc FALSE)
	dk_copy(${BZIP2}/build-VS2019 ${BZIP2}/${OS} FALSE)
	WIN64_dk_setPath(${BZIP2}/${OS})
	WIN64_dk_VisualStudio(${BZIP2_NAME} bzip2.sln libbz2-static x64)
endif()


if(MAC_64)
	if(NOT EXISTS ${BZIP2}/${OS}/bzip2.c)
		dk_copy(${BZIP2}/copy ${BZIP2}/${OS} TRUE)
	endif()
	MAC_dk_setPath(${BZIP2}/${OS})
	MAC_dk_queueCommand(make)
endif()


if(LINUX)
	if(NOT EXISTS ${BZIP2}/${OS}/bzip2.c)
		dk_copy(${BZIP2}/copy ${BZIP2}/${OS} TRUE)
	endif()
	LINUX_dk_setPath(${BZIP2}/${OS})
	LINUX_dk_queueCommand(make)
endif()


if(RASPBERRY)
	if(NOT EXISTS ${BZIP2}/${OS}/bzip2.c)
		dk_copy(${BZIP2}/copy ${BZIP2}/${OS} TRUE)
	endif()
	RASPBERRY_dk_setPath(${BZIP2}/${OS})
	RASPBERRY_dk_queueCommand(make)
endif()


if(ANDROID)
	if(NOT EXISTS ${BZIP2}/${OS}/bzip2.c)
		dk_copy(${BZIP2}/copy ${BZIP2}/${OS} TRUE)
	endif()
	ANDROID_dk_setPath(${BZIP2}/${OS})
	ANDROID_dk_queueCommand(make)
endif()
