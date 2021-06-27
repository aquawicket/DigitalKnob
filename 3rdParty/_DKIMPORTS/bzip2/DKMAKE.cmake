message("FIXME (BZIP2) need to compile for windows")
return()

### VERSION ###
DKSET(BZIP2_VERSION 2-1.0.8)
DKSET(BZIP2 ${3RDPARTY}/bzip${BZIP2_VERSION})

### INSTALL ###
if(WIN)
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
WIN_DEBUG_LIB(${BZIP2}/${OS}/libbz2-static.lib)
WIN_RELEASE_LIB(${BZIP2}/${OS}/libbz2-static.lib)
##WIN_DEBUG_LIB(${BZIP2}/${OS}/libgcc.lib)
##WIN_RELEASE_LIB(${BZIP2}/${OS}/libgcc.lib)
MAC_DEBUG_LIB(${BZIP2}/${OS}/libbz2.a)
MAC_RELEASE_LIB(${BZIP2}/${OS}/libbz2.a)
LINUX_DEBUG_LIB(${BZIP2}/${OS}/libbz2.a)
LINUX_RELEASE_LIB(${BZIP2}/${OS}/libbz2.a)
#ANDROID_DEBUG_LIB(${BZIP2}/${OS}/$(LIBDIR)/libbzip2.a)
#ANDROID_RELEASE_LIB(${BZIP2}/${OS}/$(LIBDIR)/libbzip2.a)
RASPBERRY_DEBUG_LIB(${BZIP2}/${OS}/libbz2.a)
RASPBERRY_RELEASE_LIB(${BZIP2}/${OS}/libbz2.a)


### 3RDPARTY LINK ###
DKSET(BZIP2_WIN
	-DBZIP2_INCLUDE_DIR=${BZIP2}/${OS} 
	-DBZIP2_LIBRARY_DEBUG=${BZIP2}/${OS}/libbz2-static.lib 
	-DBZIP2_LIBRARY_RELEASE=${BZIP2}/${OS}/libbz2-static.lib)
	

### COMPILE ###
if(0)
if(WIN_32)
	if(NOT EXISTS ${BZIP2}/win32/bzip2.c)
		DKCOPY(${3RDPARTY}/bzip2-temp ${BZIP2}/win32 TRUE)
	endif()

WIN32_BASH("#!/bin/bash\;
cd ${BZIP2}/win32\;
export PATH=/${MINGW32}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
make CFLAGS='-static-libgcc'\;
exit\;")

	DKRENAME(${BZIP2}/win32/libbz2.a ${BZIP2}/win32/libbz2.lib)
	DKCOPY(${3RDPARTY}/mingw/mingw32/lib/gcc/i686-w64-mingw32/4.9.2/libgcc.a ${BZIP2}/win32 TRUE)
	DKRENAME(${BZIP2}/win32/libgcc.a ${BZIP2}/win32/libgcc.lib)
endif()
endif()


IF(WIN_64)
	IF(NOT EXISTS ${BZIP2}/win64/bzip2.c)
		DKCOPY(${3RDPARTY}/bzip2-temp ${BZIP2}/win64 TRUE)
	ENDIF()

WIN64_BASH("#!/bin/bash\;
cd ${BZIP2}/win64\;
export PATH=/${MINGW64}/bin:$PATH\;
export PATH=/${MSYS}/bin:$PATH\;
make CFLAGS='-static-libgcc'\;
exit\;")

	DKRENAME(${BZIP2}/win64/libbz2.a ${BZIP2}/win64/libbz2.lib)
	DKCOPY(${3RDPARTY}/mingw/mingw64/lib/gcc/x86_64-w64-mingw32/4.9.2/libgcc.a ${BZIP2}/win64 TRUE)
	DKRENAME(${BZIP2}/win64/libgcc.a ${BZIP2}/win64/libgcc.lib)
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
