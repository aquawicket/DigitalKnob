DKDEPEND(mingw32)
DKDEPEND(mingw64)
DKDEPEND(msys)
DKDEPEND(libgcc)

### VERSION ###
DKSET(BZIP2_VERSION 2-1.0.8)
DKSET(BZIP2 ${3RDPARTY}/bzip${BZIP2_VERSION})


### INSTALL ###
if(0)
	## https://github.com/philr/bzip2-windows
	DKINSTALL(https://github.com/philr/bzip2-windows/releases/download/v1.0.8.0/bzip2-dev-1.0.8.0-win-x86.zip bzip2 bzip${BZIP2_VERSION})
	DKCOPY(${BZIP2} ${BZIP2}/${OS} TRUE)
else()
	DKINSTALL(ftp://sourceware.org/pub/bzip2/bzip${BZIP2_VERSION}.tar.gz bzip2 bzip${BZIP2_VERSION})
	if(NOT EXISTS ${3RDPARTY}/bzip2-temp)
		DKCOPY(${BZIP2} ${3RDPARTY}/bzip2-temp TRUE)
	endif()
endif()


### DKPLUGINS LINK ###
DKINCLUDE(${BZIP2})
##WIN_DEBUG_LIB(${BZIP2}/${OS}/libgcc.a)
##WIN_RELEASE_LIB(${BZIP2}/${OS}/libgcc.a)
#WIN_DEBUG_LIB(${BZIP2}/${OS}/libbz2-static.lib)
#WIN_RELEASE_LIB(${BZIP2}/${OS}/libbz2-static.lib)
WIN_DEBUG_LIB(${BZIP2}/${OS}/libbz2.a)
WIN_RELEASE_LIB(${BZIP2}/${OS}/libbz2.a)
MAC_DEBUG_LIB(${BZIP2}/${OS}/libbz2.a)
MAC_RELEASE_LIB(${BZIP2}/${OS}/libbz2.a)
LINUX_DEBUG_LIB(${BZIP2}/${OS}/libbz2.a)
LINUX_RELEASE_LIB(${BZIP2}/${OS}/libbz2.a)
RASPBERRY_DEBUG_LIB(${BZIP2}/${OS}/libbz2.a)
RASPBERRY_RELEASE_LIB(${BZIP2}/${OS}/libbz2.a)
ANDROID_DEBUG_LIB(${BZIP2}/${OS}/libbz2.a)
ANDROID_RELEASE_LIB(${BZIP2}/${OS}/libbz2.a)


### 3RDPARTY LINK ###
DKSET(BZIP2_WIN -DBZIP2_INCLUDE_DIR=${BZIP2}/${OS} -DBZIP2_LIBRARY_DEBUG=${BZIP2}/${OS}/libbz2.a -DBZIP2_LIBRARY_RELEASE=${BZIP2}/${OS}/libbz2.a)
DKSET(BZIP2_APPLE -DBZIP2_INCLUDE_DIR=${BZIP2}/${OS} -DBZIP2_LIBRARY_DEBUG=${BZIP2}/${OS}/libbz2.a -DBZIP2_LIBRARY_RELEASE=${BZIP2}/${OS}/libbz2.a)
DKSET(BZIP2_LINUX -DBZIP2_INCLUDE_DIR=${BZIP2}/${OS} -DBZIP2_LIBRARY_DEBUG=${BZIP2}/${OS}/libbz2.a -DBZIP2_LIBRARY_RELEASE=${BZIP2}/${OS}/libbz2.a)
DKSET(BZIP2_RASPBERRY -DBZIP2_INCLUDE_DIR=${BZIP2}/${OS} -DBZIP2_LIBRARY_DEBUG=${BZIP2}/${OS}/libbz2.a -DBZIP2_LIBRARY_RELEASE=${BZIP2}/${OS}/libbz2.a)
DKSET(BZIP2_ANDROID -DBZIP2_INCLUDE_DIR=${BZIP2}/${OS} -DBZIP2_LIBRARY_DEBUG=${BZIP2}/${OS}/libbz2.a -DBZIP2_LIBRARY_RELEASE=${BZIP2}/${OS}/libbz2.a)
	

### COMPILE ###
if(WIN_32)
	if(NOT EXISTS ${BZIP2}/${OS}/bzip2.c)
		DKCOPY(${3RDPARTY}/bzip2-temp ${BZIP2}/${OS} TRUE)
	endif()

WIN32_BASH("#!/bin/bash\;
cd ${BZIP2}/${OS}\;
export PATH=/${MINGW32}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
make CFLAGS='-static-libgcc'\;
exit\;")

	##DKRENAME(${BZIP2}/${OS}/libbz2.a ${BZIP2}/${OS}/libbz2.lib)
	##TODO: look at _DKIMPORTS/libgcc
	DKCOPY(${3RDPARTY}/mingw/mingw32/lib/gcc/i686-w64-mingw32/4.9.2/libgcc.a ${BZIP2}/${OS} TRUE)
	##DKRENAME(${BZIP2}/${OS}/libgcc.a ${BZIP2}/${OS}/libgcc.lib)
endif()


IF(WIN_64)
	IF(NOT EXISTS ${BZIP2}/${OS}/bzip2.c)
		DKCOPY(${3RDPARTY}/bzip2-temp ${BZIP2}/${OS} TRUE)
	ENDIF()

WIN64_BASH("#!/bin/bash\;
cd ${BZIP2}/${OS}\;
export PATH=/${MINGW64}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
make CFLAGS='-m64 -static-libgcc'\;
exit\;")

	##DKRENAME(${BZIP2}/${OS}/libbz2.a ${BZIP2}/${OS}/libbz2.lib)
	DKCOPY(${3RDPARTY}/mingw/mingw64/lib/gcc/x86_64-w64-mingw32/4.9.2/libgcc.a ${BZIP2}/${OS} TRUE)
	##DKRENAME(${BZIP2}/${OS}/libgcc.a ${BZIP2}/${OS}/libgcc.lib)
ENDIF()

IF(MAC_64)
	IF(NOT EXISTS ${BZIP2}/${OS}/bzip2.c)
		DKCOPY(${3RDPARTY}/bzip2-temp ${BZIP2}/${OS} TRUE)
	ENDIF()
	DKSETPATH(${BZIP2}/${OS})
	MAC_COMMAND(make "CXXFLAGS=-arch x86_64" "CFLAGS=-arch x86_64" "LDFLAGS=-arch x86_64")
ENDIF()

IF(LINUX)
	IF(NOT EXISTS ${BZIP2}/${OS}/bzip2.c)
		DKCOPY(${3RDPARTY}/bzip2-temp ${BZIP2}/${OS} TRUE)
	ENDIF()
	DKSETPATH(${BZIP2}/${OS})
	LINUX_COMMAND(make)
ENDIF()


IF(RASPBERRY)
	IF(NOT EXISTS ${BZIP2}/${OS}/bzip2.c)
		DKCOPY(${3RDPARTY}/bzip2-temp ${BZIP2}/${OS} TRUE)
	ENDIF()
	DKSETPATH(${BZIP2}/${OS})
	RASPBERRY_COMMAND(make)
ENDIF()


IF(ANDROID)
	IF(NOT EXISTS ${BZIP2}/${OS}/bzip2.c)
		DKCOPY(${3RDPARTY}/bzip2-temp ${BZIP2}/${OS} TRUE)
	ENDIF()
	DKSETPATH(${BZIP2}/${OS})
	ANDROID_COMMAND(make)
ENDIF()
