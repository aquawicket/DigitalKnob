# https://git.savannah.gnu.org/cgit/gzip.git
# git://git.savannah.gnu.org/gzip.git
# https://github.com/kunpengcompute/gzip.git


### IMPORT ###
#dk_import(git://git.savannah.gnu.org/gzip.git)
dk_import(https://github.com/kunpengcompute/gzip.git)


### LINK ###
#DEBUG_dk_include		(${GZIP}/${OS}/${DEBUG_DIR}/lib)
#RELEASE_dk_include		(${GZIP}/${OS}/${RELEASE_DIR}/lib)
WIN_dk_libDebug			(${GZIP}/${OS}/${DEBUG_DIR}/lib/gzip.a)
WIN_dk_libRelease		(${GZIP}/${OS}/${RELEASE_DIR}/lib/gzip.a)
APPLE_dk_libDebug		(${GZIP}/${OS}/${DEBUG_DIR}/lib/libgzip.a)
APPLE_dk_libRelease		(${GZIP}/${OS}/${RELEASE_DIR}/lib/libgzip.a)
LINUX_dk_libDebug		(${GZIP}/${OS}/${DEBUG_DIR}/lib/libgzip.a)
LINUX_dk_libRelease		(${GZIP}/${OS}/${RELEASE_DIR}/lib/libgzip.a)
RASPBERRY_dk_libDebug	(${GZIP}/${OS}/${DEBUG_DIR}/lib/libgzip.a)
RASPBERRY_dk_libRelease	(${GZIP}/${OS}/${RELEASE_DIR}/lib/libgzip.a)
ANDROID_dk_libDebug		(${GZIP}/${OS}/${DEBUG_DIR}/lib/libgzip.a)
ANDROID_dk_libRelease	(${GZIP}/${OS}/${RELEASE_DIR}/lib/libgzip.a)


### 3RDPARTY LINK ###
WIN_DEBUG_dk_set		(GZIP_CMAKE -DGZIP_INCLUDE_DIR=${GZIP} -DGZIP_LIBRARY=${GZIP}/${OS}/${DEBUG_DIR}/lib/libgzip.a)
WIN_RELEASE_dk_set		(GZIP_CMAKE -DGZIP_INCLUDE_DIR=${GZIP} -DGZIP_LIBRARY=${GZIP}/${OS}/${RELEASE_DIR}/lib/libgzip.a)
APPLE_DEBUG_dk_set		(GZIP_CMAKE -DGZIP_INCLUDE_DIR=${GZIP} -DGZIP_LIBRARY=${GZIP}/${OS}/${DEBUG_DIR}/lib/libgzip.a)
APPLE_RELEASE_dk_set	(GZIP_CMAKE -DGZIP_INCLUDE_DIR=${GZIP} -DGZIP_LIBRARY=${GZIP}/${OS}/${RELEASE_DIR}/lib/libgzip.a)
LINUX_DEBUG_dk_set		(GZIP_CMAKE -DGZIP_INCLUDE_DIR=${GZIP} -DGZIP_LIBRARY=${GZIP}/${OS}/${DEBUG_DIR}/lib/libgzip.a)
LINUX_RELEASE_dk_set	(GZIP_CMAKE -DGZIP_INCLUDE_DIR=${GZIP} -DGZIP_LIBRARY=${GZIP}/${OS}/${RELEASE_DIR}/lib/libgzip.a)
RASPBERRY_DEBUG_dk_set	(GZIP_CMAKE -DGZIP_INCLUDE_DIR=${GZIP} -DGZIP_LIBRARY=${GZIP}/${OS}/${DEBUG_DIR}/lib/libgzip.a)
RASPBERRY_RELEASE_dk_set(GZIP_CMAKE -DGZIP_INCLUDE_DIR=${GZIP} -DGZIP_LIBRARY=${GZIP}/${OS}/${RELEASE_DIR}/lib/libgzip.a)
ANDROID_DEBUG_dk_set	(GZIP_CMAKE -DGZIP_INCLUDE_DIR=${GZIP} -DGZIP_LIBRARY=${GZIP}/${OS}/${DEBUG_DIR}/lib/libgzip.a)
ANDROID_RELEASE_dk_set	(GZIP_CMAKE -DGZIP_INCLUDE_DIR=${GZIP} -DGZIP_LIBRARY=${GZIP}/${OS}/${RELEASE_DIR}/lib/libgzip.a)


### GENERATE / COMPILE ###
string(REPLACE "--disable-shared" "" GZIP_CONFIGURE "${DKCONFIGURE_BUILD}")
string(REPLACE "--enable-static" "" GZIP_CONFIGURE "${GZIP_CONFIGURE}")
string(REPLACE "  " " " GZIP_CONFIGURE "${GZIP_CONFIGURE}")

WIN_DEBUG_dk_setPath	(${GZIP}/${OS}/${DEBUG_DIR})
WIN_DEBUG_dk_queueMsys	(${GZIP_CONFIGURE} --disable-dependency-tracking)
WIN_DEBUG_dk_queueMsys	(make)
WIN_RELEASE_dk_setPath	(${GZIP}/${OS}/${RELEASE_DIR})
WIN_RELEASE_dk_queueMsys(${GZIP_CONFIGURE} --disable-dependency-tracking)
WIN_RELEASE_dk_queueMsys(make)

APPLE_dk_setPath				(${GZIP})
APPLE_dk_queueCommand			(chmod 777 configure)
APPLE_dk_queueCommand			(chmod 777 build-aux/git-version-gen)
APPLE_DEBUG_dk_setPath			(${GZIP}/${OS}/${DEBUG_DIR})
APPLE_DEBUG_dk_queueCommand		(${GZIP_CONFIGURE} --disable-dependency-tracking)
APPLE_DEBUG_dk_queueCommand		(make)
APPLE_RELEASE_dk_setPath		(${GZIP}/${OS}/${RELEASE_DIR})
APPLE_RELEASE_dk_queueCommand	(${GZIP_CONFIGURE} --disable-dependency-tracking)
APPLE_RELEASE_dk_queueCommand	(make)

LINUX_dk_setPath				(${GZIP})
LINUX_dk_queueCommand			(chmod 777 configure)
LINUX_dk_queueCommand			(chmod 777 build-aux/git-version-gen)
LINUX_DEBUG_dk_setPath			(${GZIP}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_dk_queueCommand		(${GZIP_CONFIGURE})
LINUX_DEBUG_dk_queueCommand		(make)
LINUX_RELEASE_dk_setPath		(${GZIP}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_dk_queueCommand	(${GZIP_CONFIGURE})
LINUX_RELEASE_dk_queueCommand	(make)

RASPBERRY_dk_setPath				(${GZIP})
RASPBERRY_dk_queueCommand			(chmod 777 configure)
RASPBERRY_dk_queueCommand			(chmod 777 build-aux/git-version-gen)
RASPBERRY_DEBUG_dk_setPath			(${GZIP}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_dk_queueCommand		(${GZIP_CONFIGURE})
RASPBERRY_DEBUG_dk_queueCommand		(make)
RASPBERRY_RELEASE_dk_setPath		(${GZIP}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_dk_queueCommand	(${GZIP_CONFIGURE})
RASPBERRY_RELEASE_dk_queueCommand	(make)

ANDROID_DEBUG_dk_setPath	(${GZIP}/${OS}/${DEBUG_DIR})
ANDROID_DEBUG_dk_queueMsys	(${GZIP_CONFIGURE})
ANDROID_DEBUG_dk_queueMsys	(make)
ANDROID_RELEASE_dk_setPath	(${GZIP}/${OS}/${RELEASE_DIR})
ANDROID_RELEASE_dk_queueMsys(${GZIP_CONFIGURE})
ANDROID_RELEASE_dk_queueMsys(make)
