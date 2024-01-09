# https://www.sourceware.org/bzip2
# https://gitlab.com/bzip2/bzip2
# https://github.com/kiyolee/bzip2-win-build
# https://github.com/kiyolee/bzip2-win-build/archive/refs/tags/v1.0.8.zip
# https://gitlab.com/bzip2/bzip2/-/archive/bzip2-1.0.8/bzip2-bzip2-1.0.8.zip


### DEPEND ###
dk_depend(libgcc)
dk_depend(msys2)


### IMPORT ###
UNIX_dk_import	(ftp://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz)
WIN_dk_import	(https://github.com/kiyolee/bzip2-win-build/archive/refs/tags/v1.0.8.zip)
if(NOT EXISTS ${BZIP2}/copy)
	dk_copy(${BZIP2} ${BZIP2}/copy OVERWRITE)
endif()


### LINK ###
dk_include(${BZIP2})
if(MSVC)
	WIN32_dk_libDebug	(${BZIP2}/${OS}/${DEBUG_DIR}/libbz2-static.lib)
	WIN32_dk_libRelease	(${BZIP2}/${OS}/${RELEASE_DIR}/libbz2-static.lib)
	WIN64_dk_libDebug	(${BZIP2}/${OS}/x64/${DEBUG_DIR}/libbz2-static.lib)
	WIN64_dk_libRelease	(${BZIP2}/${OS}/x64/${RELEASE_DIR}/libbz2-static.lib)
else()
	dk_libDebug	(${BZIP2}/${OS}/libbz2.a)
	dk_libRelease	(${BZIP2}/${OS}/libbz2.a)
endif()


### 3RDPARTY LINK ###
if(MSVC)
	WIN_dk_set	(BZIP2_CMAKE -DBZIP2_INCLUDE_DIR=${BZIP2} -DBZIP2_LIBRARY_DEBUG=${BZIP2}/${OS}/${DEBUG_DIR}/libbz2-static.lib -DBZIP2_LIBRARY_RELEASE=${BZIP2}/${OS}/${RELEASE_DIR}/libbz2-static.lib)
else()
	UNIX_dk_set	(BZIP2_CMAKE -DBZIP2_INCLUDE_DIR=${BZIP2}/${OS} -DBZIP2_LIBRARY_DEBUG=${BZIP2}/${OS}/libbz2.a -DBZIP2_LIBRARY_RELEASE=${BZIP2}/${OS}/libbz2.a)
endif()

	

### COMPILE ###
if(MSVC)
	if(WIN_32)
		dk_define	(BZ_NO_STDIO)
		dk_copy		(${BZIP2}/build-VS2019 ${BZIP2}/${OS})
		dk_setPath	(${BZIP2}/${OS})
		dk_build	(${BZIP2} libbz2-static)
	endif()

	if(WIN_64)
		dk_copy		(${BZIP2}/win32/bzip2.rc ${BZIP2}/${OS}/bzip2.rc) #copy project files that came with bzip
		dk_copy		(${BZIP2}/win32/bzip2recover.rc ${BZIP2}/${OS}/bzip2recover.rc)
		dk_copy		(${BZIP2}/win32/bzip2_version.h ${BZIP2}/${OS}/bzip2_version.h)
		dk_copy		(${BZIP2}/win32/libbz2.rc ${BZIP2}/${OS}/libbz2.rc)
		dk_copy		(${BZIP2}/build-VS2019 ${BZIP2}/${OS})
		dk_setPath	(${BZIP2}/${OS})
		dk_build	(${BZIP2} libbz2-static x64)
	endif()
else()
	if(NOT EXISTS ${BZIP2}/${OS}/bzip2.c)
		dk_copy		(${BZIP2}/copy ${BZIP2}/${OS} OVERWRITE)
	endif()
	dk_setPath		(${BZIP2}/${OS})
	dk_queueCommand	(make)
endif()


