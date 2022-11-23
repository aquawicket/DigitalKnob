# http://giflib.sourceforge.net
# https://github.com/mirrorer/giflib
# https://github.com/mirrorer/giflib.git
# https://github.com/mirrorer/giflib/archive/fa37672085ce4b3d62c51627ab3c8cf2dda8009a.zip
# https://sourceforge.net/projects/giflib/files/giflib-5.1.1.tar.gz


### DEPEND ###
WIN32_dk_depend(mingw32)
WIN64_dk_depend(mingw64)
WIN_dk_depend(msys)
#WIN_dk_depend(msys2)
MAC_dk_depend(autotools)


### IMPORT ###
#dk_import(https://github.com/mirrorer/giflib/archive/fa37672085ce4b3d62c51627ab3c8cf2dda8009a.zip PATCH)
dk_import(https://github.com/mirrorer/giflib.git PATCH)


### LINK ###
dk_include				(${GIFLIB}/lib)
WIN_dk_libDebug			(${GIFLIB}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a)
WIN_dk_libRelease		(${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
APPLE_dk_libDebug		(${GIFLIB}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a)
APPLE_dk_libRelease		(${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
LINUX_dk_libDebug		(${GIFLIB}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a)
LINUX_dk_libRelease		(${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
RASPBERRY_dk_libDebug	(${GIFLIB}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a)
RASPBERRY_dk_libRelease	(${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
ANDROID_dk_libDebug		(${GIFLIB}/${OS}/${DEBUG_DIR}/libgiflib.a)
ANDROID_dk_libRelease	(${GIFLIB}/${OS}/${RELEASE_DIR}/libgiflib.a)


### 3RDPARTY LINK ###
WIN_dk_set		(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIFLIB}/lib -DGIF_INCLUDE_DIR2=${GIFLIB}/${OS} -DGIF_LIBRARY=${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
APPLE_dk_set	(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIFLIB}/lib -DGIF_INCLUDE_DIR2=${GIFLIB}/${OS} -DGIF_LIBRARY=${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
LINUX_dk_set	(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIFLIB}/lib -DGIF_INCLUDE_DIR2=${GIFLIB}/${OS} -DGIF_LIBRARY=${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
RASPBERRY_dk_set(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIFLIB}/lib -DGIF_INCLUDE_DIR2=${GIFLIB}/${OS} -DGIF_LIBRARY=${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
ANDROID_dk_set	(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIFLIB}/lib -DGIF_INCLUDE_DIR2=${GIFLIB}/${OS} -DGIF_LIBRARY=${GIFLIB}/${OS}/${RELEASE_DIR}/libgiflib.a)	


### GENERATE / COMPILE ###
if(NOT WIN_HOST)
	dk_setPath		(${GIFLIB})
	dk_queueShell	(autoreconf -f -i)
endif()

if(NOT ANDROID)
	DEBUG_dk_setPath	(${GIFLIB}/${OS}/${DEBUG_DIR})
	DEBUG_dk_queueShell	(${DKCONFIGURE_BUILD})
	DEBUG_dk_queueShell	(make -C lib)
	RELEASE_dk_setPath		(${GIFLIB}/${OS}/${RELEASE_DIR})
	RELEASE_dk_queueShell	(${DKCONFIGURE_BUILD})
	RELEASE_dk_queueShell	(make -C lib)
else()
	#ANDROID_dk_setPath		(${GIFLIB}/${BUILD_DIR})
	ANDROID_dk_queueCommand(${DKCMAKE_BUILD} ${GIFLIB})
	ANDROID_dk_visualStudio(${GIFLIB_FOLDER} giflib)
endif()
