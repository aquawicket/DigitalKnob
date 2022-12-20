# https://git.savannah.gnu.org/cgit/gzip.git
# git://git.savannah.gnu.org/gzip.git
# https://github.com/kunpengcompute/gzip.git


### IMPORT ###
#dk_import(git://git.savannah.gnu.org/gzip.git)
dk_import(https://github.com/kunpengcompute/gzip.git)


### LINK ###
#DEBUG_dk_include		(${GZIP}/${OS}/${DEBUG_DIR}/lib)
#RELEASE_dk_include		(${GZIP}/${OS}/${RELEASE_DIR}/lib)

# libversion
WIN_dk_libDebug			(${GZIP}/${OS}/${DEBUG_DIR}/ver.a)
WIN_dk_libRelease		(${GZIP}/${OS}/${RELEASE_DIR}/ver.a)
UNIX_dk_libDebug		(${GZIP}/${OS}/${DEBUG_DIR}/libver.a)
UNIX_dk_libRelease		(${GZIP}/${OS}/${RELEASE_DIR}/libver.a)

# libgzip
WIN_dk_libDebug			(${GZIP}/${OS}/${DEBUG_DIR}/lib/gzip.a)
WIN_dk_libRelease		(${GZIP}/${OS}/${RELEASE_DIR}/lib/gzip.a)
UNIX_dk_libDebug		(${GZIP}/${OS}/${DEBUG_DIR}/lib/libgzip.a)
UNIX_dk_libRelease		(${GZIP}/${OS}/${RELEASE_DIR}/lib/libgzip.a)


### 3RDPARTY LINK ###
DEBUG_dk_set	(GZIP_CMAKE -DGZIP_INCLUDE_DIR=${GZIP} -DGZIP_LIBRARY=${GZIP}/${OS}/${DEBUG_DIR}/lib/libgzip.a)
RELEASE_dk_set	(GZIP_CMAKE -DGZIP_INCLUDE_DIR=${GZIP} -DGZIP_LIBRARY=${GZIP}/${OS}/${RELEASE_DIR}/lib/libgzip.a)


### GENERATE / COMPILE ###
string(REPLACE "--disable-shared" "" GZIP_CONFIGURE "${DKCONFIGURE_BUILD}")
string(REPLACE "--enable-static" "" GZIP_CONFIGURE "${GZIP_CONFIGURE}")
string(REPLACE "  " " " GZIP_CONFIGURE "${GZIP_CONFIGURE}")

WIN_dk_setPath				(${GZIP})
WIN_dk_queueShell			(touch aclocal.m4 configure Makefile.am Makefile.in)
WIN_DEBUG_dk_setPath		(${GZIP}/${OS}/${DEBUG_DIR})
WIN_DEBUG_dk_queueShell		(${GZIP_CONFIGURE} --disable-dependency-tracking CFLAGS="-I${GZIP}/include -I${GZIP}/${OS}/${DEBUG_DIR}/lib")
WIN_DEBUG_dk_queueShell		(make gzip)
WIN_RELEASE_dk_setPath		(${GZIP}/${OS}/${RELEASE_DIR})
WIN_RELEASE_dk_queueShell	(${GZIP_CONFIGURE} --disable-dependency-tracking CFLAGS="-I${GZIP}/include -I${GZIP}/${OS}/${RELEASE_DIR}/lib")
WIN_RELEASE_dk_queueShell	(make gzip)

APPLE_dk_setPath			(${GZIP})
APPLE_dk_queueShell			(chmod 777 configure)
APPLE_dk_queueShell			(chmod 777 build-aux/git-version-gen)
APPLE_dk_queueShell			(chmod 777 build-aux/install-sh)
APPLE_DEBUG_dk_setPath		(${GZIP}/${OS}/${DEBUG_DIR})
APPLE_DEBUG_dk_queueShell	(${GZIP_CONFIGURE} --disable-dependency-tracking "CFLAGS=-I${GZIP}/include -I${GZIP}/${OS}/${DEBUG_DIR}/lib")
#APPLE_DEBUG_dk_queueShell	(make version)
#APPLE_DEBUG_dk_queueShell	(make gzip)
APPLE_DEBUG_dk_queueShell	(make)
APPLE_RELEASE_dk_setPath	(${GZIP}/${OS}/${RELEASE_DIR})
APPLE_RELEASE_dk_queueShell	(${GZIP_CONFIGURE} --disable-dependency-tracking "CFLAGS=-I${GZIP}/include -I${GZIP}/${OS}/${RELEASE_DIR}/lib")
#APPLE_RELEASE_dk_queueShell(make version)
#APPLE_RELEASE_dk_queueShell(make gzip)
APPLE_RELEASE_dk_queueShell	(make)

LINUX_dk_setPath			(${GZIP})
LINUX_dk_queueShell			(chmod 777 configure)
LINUX_dk_queueShell			(chmod 777 build-aux/git-version-gen)
LINUX_dk_queueShell			(chmod 777 build-aux/install-sh)
LINUX_DEBUG_dk_setPath		(${GZIP}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_dk_queueShell	(${GZIP_CONFIGURE})
LINUX_DEBUG_dk_queueShell	(make)
LINUX_RELEASE_dk_setPath	(${GZIP}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_dk_queueShell	(${GZIP_CONFIGURE})
LINUX_RELEASE_dk_queueShell	(make)

RASPBERRY_dk_setPath			(${GZIP})
RASPBERRY_dk_queueShell			(chmod 777 configure)
RASPBERRY_dk_queueShell			(chmod 777 build-aux/git-version-gen)
RASPBERRY_dk_queueShell			(chmod 777 build-aux/install-sh)
RASPBERRY_DEBUG_dk_setPath		(${GZIP}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_dk_queueShell	(${GZIP_CONFIGURE})
RASPBERRY_DEBUG_dk_queueShell	(make)
RASPBERRY_RELEASE_dk_setPath	(${GZIP}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_dk_queueShell	(${GZIP_CONFIGURE})
RASPBERRY_RELEASE_dk_queueShell	(make)

ANDROID_DEBUG_dk_setPath		(${GZIP}/${OS}/${DEBUG_DIR})
ANDROID_DEBUG_dk_queueShell		(${GZIP_CONFIGURE})
ANDROID_DEBUG_dk_queueShell		(make)
ANDROID_RELEASE_dk_setPath		(${GZIP}/${OS}/${RELEASE_DIR})
ANDROID_RELEASE_dk_queueShell	(${GZIP_CONFIGURE})
ANDROID_RELEASE_dk_queueShell	(make)
