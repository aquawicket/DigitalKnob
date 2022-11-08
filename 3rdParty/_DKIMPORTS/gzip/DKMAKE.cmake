# https://git.savannah.gnu.org/cgit/gzip.git
# git://git.savannah.gnu.org/gzip.git


### IMPORT ###
dk_import(git://git.savannah.gnu.org/gzip.git)


### LINK ###
dk_include				(${GZIP})
WIN_dk_libDebug			(${GZIP}/${OS}/${DEBUG_DIR}/lib/.libs/gzip.a)
WIN_dk_libRelease		(${GZIP}/${OS}/${RELEASE_DIR}/lib/.libs/gzip.a)
APPLE_dk_libDebug		(${GZIP}/${OS}/${DEBUG_DIR}/lib/.libs/libgzip.a)
APPLE_dk_libRelease		(${GZIP}/${OS}/${RELEASE_DIR}/lib/.libs/libgzip.a)
LINUX_dk_libDebug		(${GZIP}/${OS}/${DEBUG_DIR}/lib/.libs/libgzip.a)
LINUX_dk_libRelease		(${GZIP}/${OS}/${RELEASE_DIR}/lib/.libs/libgzip.a)
RASPBERRY_dk_libDebug	(${GZIP}/${OS}/${DEBUG_DIR}/lib/.libs/libgzip.a)
RASPBERRY_dk_libRelease	(${GZIP}/${OS}/${RELEASE_DIR}/lib/.libs/libgzip.a)
ANDROID_dk_libDebug		(${GZIP}/${OS}/${DEBUG_DIR}/lib/.libs/libgzip.a)
ANDROID_dk_libRelease	(${GZIP}/${OS}/${RELEASE_DIR}/lib/.libs/libgzip.a)


### 3RDPARTY LINK ###
WIN_DEBUG_dk_set		(GZIP_CMAKE -DGZIP_INCLUDE_DIR=${GZIP} -DGZIP_LIBRARY=${GZIP}/${OS}/${DEBUG_DIR}/lib/.libs/libgzip.a)
WIN_RELEASE_dk_set		(GZIP_CMAKE -DGZIP_INCLUDE_DIR=${GZIP} -DGZIP_LIBRARY=${GZIP}/${OS}/${RELEASE_DIR}/lib/.libs/libgzip.a)
APPLE_DEBUG_dk_set		(GZIP_CMAKE -DGZIP_INCLUDE_DIR=${GZIP} -DGZIP_LIBRARY=${GZIP}/${OS}/${DEBUG_DIR}/lib/.libs/libgzip.a)
APPLE_RELEASE_dk_set	(GZIP_CMAKE -DGZIP_INCLUDE_DIR=${GZIP} -DGZIP_LIBRARY=${GZIP}/${OS}/${RELEASE_DIR}/lib/.libs/libgzip.a)
LINUX_DEBUG_dk_set		(GZIP_CMAKE -DGZIP_INCLUDE_DIR=${GZIP} -DGZIP_LIBRARY=${GZIP}/${OS}/${DEBUG_DIR}/lib/.libs/libgzip.a)
LINUX_RELEASE_dk_set	(GZIP_CMAKE -DGZIP_INCLUDE_DIR=${GZIP} -DGZIP_LIBRARY=${GZIP}/${OS}/${RELEASE_DIR}/lib/.libs/libgzip.a)
RASPBERRY_DEBUG_dk_set	(GZIP_CMAKE -DGZIP_INCLUDE_DIR=${GZIP} -DGZIP_LIBRARY=${GZIP}/${OS}/${DEBUG_DIR}/lib/.libs/libgzip.a)
RASPBERRY_RELEASE_dk_set(GZIP_CMAKE -DGZIP_INCLUDE_DIR=${GZIP} -DGZIP_LIBRARY=${GZIP}/${OS}/${RELEASE_DIR}/lib/.libs/libgzip.a)
ANDROID_DEBUG_dk_set	(GZIP_CMAKE -DGZIP_INCLUDE_DIR=${GZIP} -DGZIP_LIBRARY=${GZIP}/${OS}/${DEBUG_DIR}/lib/.libs/libgzip.a)
ANDROID_RELEASE_dk_set	(GZIP_CMAKE -DGZIP_INCLUDE_DIR=${GZIP} -DGZIP_LIBRARY=${GZIP}/${OS}/${RELEASE_DIR}/lib/.libs/libgzip.a)


### GENERATE / COMPILE ###
WIN_DEBUG_dk_setPath	(${GZIP}/${OS}/${DEBUG_DIR})
WIN_DEBUG_dk_queueMsys	(${DKCONFIGURE_BUILD})
WIN_DEBUG_dk_queueMsys	(make)
WIN_RELEASE_dk_setPath	(${GZIP}/${OS}/${RELEASE_DIR})
WIN_RELEASE_dk_queueMsys(${DKCONFIGURE_BUILD})
WIN_RELEASE_dk_queueMsys(make)

APPLE_DEBUG_dk_setPath			(${GZIP})
APPLE_DEBUG_dk_queueCommand		(autoconf)
APPLE_DEBUG_dk_setPath			(${GZIP}/${OS}/${DEBUG_DIR})
APPLE_DEBUG_dk_queueCommand		(${DKCONFIGURE_BUILD})
APPLE_DEBUG_dk_queueCommand		(make)
APPLE_RELEASE_dk_setPath		(${GZIP}/${OS}/${RELEASE_DIR})
APPLE_RELEASE_dk_queueCommand	(${DKCONFIGURE_BUILD})
APPLE_RELEASE_dk_queueCommand	(make)

LINUX_DEBUG_dk_setPath			(${GZIP}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_dk_queueCommand		(${DKCONFIGURE_BUILD})
LINUX_DEBUG_dk_queueCommand		(make)
LINUX_RELEASE_dk_setPath		(${GZIP}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_dk_queueCommand	(${DKCONFIGURE_BUILD})
LINUX_RELEASE_dk_queueCommand	(make)

RASPBERRY_DEBUG_dk_setPath			(${GZIP}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_dk_queueCommand		(${DKCONFIGURE_BUILD})
RASPBERRY_DEBUG_dk_queueCommand		(make)
RASPBERRY_RELEASE_dk_setPath		(${GZIP}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_dk_queueCommand	(${DKCONFIGURE_BUILD})
RASPBERRY_RELEASE_dk_queueCommand	(make)

ANDROID_DEBUG_dk_setPath	(${GZIP}/${OS}/${DEBUG_DIR})
ANDROID_DEBUG_dk_queueMsys	(${DKCONFIGURE_BUILD})
ANDROID_DEBUG_dk_queueMsys	(make)
ANDROID_RELEASE_dk_setPath	(${GZIP}/${OS}/${RELEASE_DIR})
ANDROID_RELEASE_dk_queueMsys(${DKCONFIGURE_BUILD})
ANDROID_RELEASE_dk_queueMsys(make)
