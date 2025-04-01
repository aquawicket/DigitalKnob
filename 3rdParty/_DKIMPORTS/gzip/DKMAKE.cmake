#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ gzip ############
# https://git.savannah.gnu.org/cgit/gzip.git
# git://git.savannah.gnu.org/gzip.git
# https://github.com/kunpengcompute/gzip.git

dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/kunpengcompute/gzip/archive/6a3ebab7e475fb5ca9b01c344eb45c27ea81ef89.zip)

### LINK ###
dk_include			(${GZIP_DIR}				GZIP_INCLUDE_DIR)
dk_include			(${GZIP_BUILD_DIR}/lib		GZIP_INCLUDE_DIR2)

# libversion
UNIX_dk_libDebug	(${GZIP_DEBUG_DIR}/libver.a			VER_DEBUG_LIBRARY)
UNIX_dk_libRelease	(${GZIP_RELEASE_DIR}/libver.a		VER_RELEASE_LIBRARY)
WIN_dk_libDebug		(${GZIP_DEBUG_DIR}/ver.a			VER_DEBUG_LIBRARY)
WIN_dk_libRelease	(${GZIP_RELEASE_DIR}/ver.a			VER_RELEASE_LIBRARY)

# libgzip
UNIX_dk_libDebug	(${GZIP_DEBUG_DIR}/lib/libgzip.a	GZIP_DEBUG_LIBRARY)
UNIX_dk_libRelease	(${GZIP_RELEASE_DIR}/lib/libgzip.a	GZIP_RELEASE_LIBRARY)
WIN_dk_libDebug		(${GZIP_DEBUG_DIR}/lib/gzip.a		GZIP_DEBUG_LIBRARY)
WIN_dk_libRelease	(${GZIP_RELEASE_DIR}/lib/gzip.a		GZIP_RELEASE_LIBRARY)
DEBUG_dk_set		(GZIP_LIBRARY						${GZIP_DEBUG_LIBRARY})
RELEASE_dk_set		(GZIP_LIBRARY						${GZIP_RELEASE_LIBRARY})

### 3RDPARTY LINK ###
dk_set(GZIP_CMAKE 
	-DGZIP_INCLUDE_DIR=${GZIP_INCLUDE_DIR} 
	-DGZIP_LIBRARY=${GZIP_LIBRARY})

### GENERATE / COMPILE ###
string(REPLACE "--disable-shared" 	"" 	DKCONFIGURE_BUILD "${DKCONFIGURE_BUILD}")
string(REPLACE "--enable-static" 	"" 	DKCONFIGURE_BUILD "${DKCONFIGURE_BUILD}")
string(REPLACE "  " 				" " DKCONFIGURE_BUILD "${DKCONFIGURE_BUILD}")


ANDROID_dk_configure			(${GZIP_DIR})
ANDROID_dk_build				(${GZIP_DIR})

#APPLE_dk_cd					(${GZIP_DIR})
APPLE_dk_queueCommand			(chmod 777 configure)
APPLE_dk_queueCommand			(chmod 777 build-aux/git-version-gen)
APPLE_dk_queueCommand			(chmod 777 build-aux/install-sh)
#APPLE_DEBUG_dk_cd				(${GZIP_DEBUG_DIR})
APPLE_DEBUG_dk_configure		(${GZIP_DIR} --disable-dependency-tracking "CFLAGS=-I${GZIP}/include -I${GZIP_DEBUG_DIR}/lib")
#APPLE_DEBUG_dk_queueCommand	(make version)
#APPLE_DEBUG_dk_queueCommand	(make gzip)
#APPLE_RELEASE_dk_cd			(${GZIP_RELEASE_DIR})
APPLE_RELEASE_dk_queueCommand	(${GZIP_CONFIGURE} --disable-dependency-tracking "CFLAGS=-I${GZIP}/include -I${GZIP_RELEASE_DIR}/lib")
#APPLE_RELEASE_dk_queueCommand	(make version)
#APPLE_RELEASE_dk_queueCommand	(make gzip)
APPLE_dk_build					(${GZIP_DIR})

#EMSCRIPTEN_dk_cd				(${GZIP})
EMSCRIPTEN_dk_queueCommand		(chmod 777 configure)
EMSCRIPTEN_dk_queueCommand		(chmod 777 build-aux/git-version-gen)
EMSCRIPTEN_dk_queueCommand		(chmod 777 build-aux/install-sh)
#EMSCRIPTEN_DEBUG_dk_cd			(${GZIP_DEBUG_DIR})
EMSCRIPTEN_DEBUG_dk_configure	(${GZIP_DIR})
#EMSCRIPTEN_RELEASE_dk_cd		(${GZIP_RELEASE_DIR})
EMSCRIPTEN_RELEASE_dk_configure	(${GZIP_DIR})
EMSCRIPTEN_dk_build				(${GZIP_DIR})

#LINUX_dk_cd					(${GZIP_DIR})
LINUX_dk_queueCommand			(chmod 777 configure)
LINUX_dk_queueCommand			(chmod 777 build-aux/git-version-gen)
LINUX_dk_queueCommand			(chmod 777 build-aux/install-sh)
#LINUX_DEBUG_dk_cd				(${GZIP_DEBUG_DIR})
LINUX_DEBUG_dk_configure		(${GZIP_DIR})
#LINUX_RELEASE_dk_cd			(${GZIP_RELEASE_DIR})
LINUX_RELEASE_dk_configure		(${GZIP_DIR})
LINUX_dk_build					(${GZIP_DIR})

#RASPBERRY_dk_cd				(${GZIP_DIR})
RASPBERRY_dk_queueCommand		(chmod 777 configure)
RASPBERRY_dk_queueCommand		(chmod 777 build-aux/git-version-gen)
RASPBERRY_dk_queueCommand		(chmod 777 build-aux/install-sh)
#RASPBERRY_DEBUG_dk_cd			(${GZIP_DEBUG_DIR})
RASPBERRY_DEBUG_dk_configure	(${GZIP_DIR})
#RASPBERRY_RELEASE_dk_cd		(${GZIP_RELEASE_DIR})
RASPBERRY_RELEASE_dk_configure	(${GZIP_DIR})
RASPBERRY_dk_build				(${GZIP_DIR})

#WIN_dk_cd						(${GZIP_DIR})
#WIN_dk_queueCommand			(touch aclocal.m4 configure Makefile.am Makefile.in)
#WIN_DEBUG_dk_cd				(${GZIP_DEBUG_DIR})
WIN_DEBUG_dk_configure			(${GZIP_DIR} --disable-dependency-tracking CFLAGS="-I${GZIP}/include -I${GZIP_DEBUG_DIR}/lib")
#WIN_RELEASE_dk_cd				(${GZIP_RELEASE_DIR})
WIN_RELEASE_dk_configure		(${GZIP_DIR} --disable-dependency-tracking CFLAGS="-I${GZIP}/include -I${GZIP_RELEASE_DIR}/lib")

WIN_dk_build					(${GZIP_DIR} gzip)
