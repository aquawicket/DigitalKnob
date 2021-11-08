# https://www.sourceware.org/bzip2
# https://github.com/kiyolee/bzip2-win-build
# https://github.com/philr/bzip2-windows
#
# ftp://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz
# https://github.com/kiyolee/bzip2-win-build/archive/refs/tags/v1.0.8.zip

DKDEPEND(mingw32)
DKDEPEND(mingw64)
DKDEPEND(msys)
DKDEPEND(libgcc)

### VERSION ###
DKSET(BZIP2_VERSION 1.0.8)
DKSET(BZIP2_NAME bzip2-${BZIP2_VERSION})
WIN_DKSET(BZIP2_DL https://github.com/kiyolee/bzip2-win-build/archive/refs/tags/v${BZIP2_VERSION}.zip)
LINUX_DKSET(BZIP2_DL ftp://sourceware.org/pub/bzip2/${BZIP2_NAME}.tar.gz)
DKSET(BZIP2 ${3RDPARTY}/${BZIP2_NAME})


### INSTALL ###
DKINSTALL(${BZIP2_DL} bzip2 ${BZIP2})
if(NOT EXISTS ${BZIP2}/copy)
	DKCOPY(${BZIP2} ${BZIP2}/copy TRUE)
endif()




### DKPLUGINS LINK ###
DKINCLUDE(${BZIP2})
#WIN_DEBUG_LIB(${BZIP2}/${OS}/libbz2.a)
#WIN_RELEASE_LIB(${BZIP2}/${OS}/libbz2.a)
WIN_DEBUG_LIB(${BZIP2}/${OS}/${DEBUG_DIR}/libbz2-static.lib)
WIN_RELEASE_LIB(${BZIP2}/${OS}/${RELEASE_DIR}/libbz2-static.lib)
MAC_DEBUG_LIB(${BZIP2}/${OS}/libbz2.a)
MAC_RELEASE_LIB(${BZIP2}/${OS}/libbz2.a)
LINUX_DEBUG_LIB(${BZIP2}/${OS}/libbz2.a)
LINUX_RELEASE_LIB(${BZIP2}/${OS}/libbz2.a)
RASPBERRY_DEBUG_LIB(${BZIP2}/${OS}/libbz2.a)
RASPBERRY_RELEASE_LIB(${BZIP2}/${OS}/libbz2.a)
ANDROID_DEBUG_LIB(${BZIP2}/${OS}/libbz2.a)
ANDROID_RELEASE_LIB(${BZIP2}/${OS}/libbz2.a)



### 3RDPARTY LINK ###
DKSET(BZIP2_WIN -DBZIP2_INCLUDE_DIR=${BZIP2} -DBZIP2_LIBRARY_DEBUG=${BZIP2}/${OS}/${DEBUG_DIR}/libbz2-static.lib -DBZIP2_LIBRARY_RELEASE=${BZIP2}/${OS}/${RELEASE_DIR}/libbz2-static.lib) #-DBZIP2_LIBRARIES=${BZIP2}/${OS}/${RELEASE_DIR}/libbz2-static.lib)
DKSET(BZIP2_APPLE -DBZIP2_INCLUDE_DIR=${BZIP2}/${OS} -DBZIP2_LIBRARY_DEBUG=${BZIP2}/${OS}/libbz2.a -DBZIP2_LIBRARY_RELEASE=${BZIP2}/${OS}/libbz2.a)
DKSET(BZIP2_LINUX -DBZIP2_INCLUDE_DIR=${BZIP2}/${OS} -DBZIP2_LIBRARY_DEBUG=${BZIP2}/${OS}/libbz2.a -DBZIP2_LIBRARY_RELEASE=${BZIP2}/${OS}/libbz2.a)
DKSET(BZIP2_RASPBERRY -DBZIP2_INCLUDE_DIR=${BZIP2}/${OS} -DBZIP2_LIBRARY_DEBUG=${BZIP2}/${OS}/libbz2.a -DBZIP2_LIBRARY_RELEASE=${BZIP2}/${OS}/libbz2.a)
DKSET(BZIP2_ANDROID -DBZIP2_INCLUDE_DIR=${BZIP2}/${OS} -DBZIP2_LIBRARY_DEBUG=${BZIP2}/${OS}/libbz2.a -DBZIP2_LIBRARY_RELEASE=${BZIP2}/${OS}/libbz2.a)
	


### COMPILE ###
if(WIN_32)
	DKCOPY(${BZIP2}/build-VS2019 ${BZIP2}/${OS} TRUE)
	WIN32_PATH(${BZIP2}/${OS})
	WIN32_VS(${BZIP2_NAME} bzip2.sln libbz2-static)
	#WIN32_VS(${BZIP2_NAME} bzip2.sln bzip2-static)
#	WIN32_MSYS(make "CFLAGS=-static-libgcc")
#	DKCOPY(${MINGW32}/lib/gcc/i686-w64-mingw32/${MINGW32_VERSION}/libgcc.a ${BZIP2}/${OS} TRUE)
endif()


IF(WIN_64)
	DKCOPY(${BZIP2}/win32 ${BZIP2}/${OS} TRUE) #copy project files that came with bzip
	DKCOPY(${BZIP2}/build-VS2019 ${BZIP2}/${OS} TRUE)
	WIN64_PATH(${BZIP2}/${OS})
	WIN64_VS(${BZIP2_NAME} bzip2.sln libbz2-static x64)
	#WIN32_VS(${BZIP2_NAME} bzip2.sln bzip2-static)
#	WIN64_MSYS(make "CFLAGS=-m64 -static-libgcc")
#	DKCOPY(${MINGW64}/lib/gcc/x86_64-w64-mingw32/${MINGW32_VERSION}/libgcc.a ${BZIP2}/${OS} TRUE)
ENDIF()


IF(MAC_64)
	if(NOT EXISTS ${BZIP2}/${OS}/bzip2.c)
		DKCOPY(${BZIP2}/copy ${BZIP2}/${OS} TRUE)
	endif()
	MAC_PATH(${BZIP2}/${OS})
	MAC_COMMAND(make)
ENDIF()


IF(LINUX)
	if(NOT EXISTS ${BZIP2}/${OS}/bzip2.c)
		DKCOPY(${BZIP2}/copy ${BZIP2}/${OS} TRUE)
	endif()
	LINUX_PATH(${BZIP2}/${OS})
	LINUX_COMMAND(make)
ENDIF()


IF(RASPBERRY)
	if(NOT EXISTS ${BZIP2}/${OS}/bzip2.c)
		DKCOPY(${BZIP2}/copy ${BZIP2}/${OS} TRUE)
	endif()
	RASPBERRY_PATH(${BZIP2}/${OS})
	RASPBERRY_COMMAND(make)
ENDIF()


IF(ANDROID)
	if(NOT EXISTS ${BZIP2}/${OS}/bzip2.c)
		DKCOPY(${BZIP2}/copy ${BZIP2}/${OS} TRUE)
	endif()
	ANDROID_PATH(${BZIP2}/${OS})
	ANDROID_COMMAND(make)
ENDIF()
