# http://giflib.sourceforge.net
# https://github.com/mirrorer/giflib
# https://github.com/mirrorer/giflib.git
# https://github.com/mirrorer/giflib/archive/fa37672085ce4b3d62c51627ab3c8cf2dda8009a.zip
# https://sourceforge.net/projects/giflib/files/giflib-5.1.1.tar.gz


### DEPEND ###
WIN32_dk_depend(mingw32)
WIN64_dk_depend(mingw64)
WIN_dk_depend(msys)
MAC_dk_depend(autotools)


### IMPORT ###
#dk_import(https://github.com/mirrorer/giflib/archive/fa37672085ce4b3d62c51627ab3c8cf2dda8009a.zip PATCH)
dk_import(https://github.com/mirrorer/giflib.git PATCH)


### LINK ###
dk_include				(${GIFLIB}/lib)
WIN32_dk_include		(${MINGW32}/i686-w64-mingw32/include)
WIN64_dk_include		(${MINGW64}/x86_64-w64-mingw32/include)
#WIN_dk_libDebug		(${GIFLIB}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a)
#WIN_dk_libRelease		(${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
#APPLE_dk_libDebug		(${GIFLIB}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a)
#APPLE_dk_libRelease	(${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
#LINUX_dk_libDebug		(${GIFLIB}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a)
#LINUX_dk_libRelease	(${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
#RASPBERRY_dk_libDebug	(${GIFLIB}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a)
#RASPBERRY_dk_libRelease(${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
#ANDROID_dk_libDebug	(${GIFLIB}/${OS}/${DEBUG_DIR}/libgiflib.a)
#ANDROID_dk_libRelease	(${GIFLIB}/${OS}/${RELEASE_DIR}/libgiflib.a)
dk_libDebug				(${GIFLIB}/${OS}/${DEBUG_DIR}/libgiflib.a)
dk_libRelease			(${GIFLIB}/${OS}/${RELEASE_DIR}/libgiflib.a)


### 3RDPARTY LINK ###
WIN_dk_set		(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIFLIB}/lib -DGIF_INCLUDE_DIR2=${GIFLIB}/${OS} -DGIF_LIBRARY=${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
APPLE_dk_set	(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIFLIB}/lib -DGIF_INCLUDE_DIR2=${GIFLIB}/${OS} -DGIF_LIBRARY=${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
LINUX_dk_set	(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIFLIB}/lib -DGIF_INCLUDE_DIR2=${GIFLIB}/${OS} -DGIF_LIBRARY=${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
RASPBERRY_dk_set(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIFLIB}/lib -DGIF_INCLUDE_DIR2=${GIFLIB}/${OS} -DGIF_LIBRARY=${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
ANDROID_dk_set	(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIFLIB}/lib -DGIF_INCLUDE_DIR2=${GIFLIB}/${OS} -DGIF_LIBRARY=${GIFLIB}/${OS}/${RELEASE_DIR}/libgiflib.a)	


### GENERATE ###
#DEBUG_dk_setPath					(${GIFLIB}/${OS}/${DEBUG_DIR})
#RELEASE_dk_setPath					(${GIFLIB}/${OS}/${RELEASE_DIR})
#ANDROID_dk_setPath					(${GIFLIB}/${BUILD_DIR})

dk_setPath							(${GIFLIB}/${BUILD_DIR})
dk_queueCommand						(${DKCMAKE_BUILD} ${GIFLIB})

#WIN_DEBUG_dk_msys					(${DKCONFIGURE_BUILD})
#WIN_RELEASE_dk_msys				(${DKCONFIGURE_BUILD})
#APPLE_DEBUG_dk_queueCommand		(${DKCONFIGURE_BUILD})
#APPLE_RELEASE_dk_queueCommand		(${DKCONFIGURE_BUILD})
#LINUX_DEBUG_dk_queueCommand		(${DKCONFIGURE_BUILD})
#LINUX_RELEASE_dk_queueCommand		(${DKCONFIGURE_BUILD})
#RASPBERRY_DEBUG_dk_queueCommand	(${DKCONFIGURE_BUILD})
#RASPBERRY_RELEASE_dk_queueCommand	(${DKCONFIGURE_BUILD})
#ANDROID_dk_queueCommand			(${DKCMAKE_BUILD} ${GIFLIB})


### COMPILE ###
#WIN_DEBUG_dk_msys					(make -C lib)
#WIN_RELEASE_dk_msys				(make -C lib)
#APPLE_DEBUG_dk_queueCommand		(make -C lib)
#APPLE_RELEASE_dk_queueCommand		(make -C lib)
#LINUX_DEBUG_dk_queueCommand		(make -C lib)
#LINUX_RELEASE_dk_queueCommand		(make -C lib)
#RASPBERRY_DEBUG_dk_queueCommand	(make -C lib)
#RASPBERRY_RELEASE_dk_queueCommand	(make -C lib)
#ANDROID_dk_visualStudio			(${GIFLIB_NAME} giflib)

WIN32_dk_visualStudio		(${GIFLIB_NAME} "-DCMAKE_C_FLAGS=-I${MINGW32}/i686-w64-mingw32/include" giflib)
WIN64_dk_visualStudio		(${GIFLIB_NAME} "-DCMAKE_C_FLAGS=-I${MINGW64}/x86_64-w64-mingw32/include" giflib)
ANDROID_dk_visualStudio		(${GIFLIB_NAME} giflib)
dk_xcode					(${GIFLIB_NAME} giflib)
dk_make						(${GIFLIB_NAME} giflib)
