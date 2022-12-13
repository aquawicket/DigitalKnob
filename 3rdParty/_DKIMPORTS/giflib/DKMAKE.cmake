# http://giflib.sourceforge.net
# https://github.com/mirrorer/giflib
# https://github.com/mirrorer/giflib.git
# https://github.com/mirrorer/giflib/archive/fa37672085ce4b3d62c51627ab3c8cf2dda8009a.zip
# https://sourceforge.net/projects/giflib/files/giflib-5.1.1.tar.gz


### DEPEND ###
#WIN32_dk_depend(mingw32)
#WIN64_dk_depend(mingw64)
#WIN_dk_depend(msys)
#WIN_dk_depend(msys2)
MAC_dk_depend(autotools)


### IMPORT ###
#dk_import(https://github.com/mirrorer/giflib/archive/fa37672085ce4b3d62c51627ab3c8cf2dda8009a.zip PATCH)
dk_import(https://github.com/mirrorer/giflib.git PATCH)


### LINK ###
dk_include				(${GIFLIB}/lib)
if(VISUAL_STUDIO_IDE)
	WIN_dk_libDebug			(${GIFLIB}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a)
	WIN_dk_libRelease		(${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
	ANDROID_dk_libDebug		(${GIFLIB}/${OS}/${DEBUG_DIR}/libgiflib.a)
	ANDROID_dk_libRelease	(${GIFLIB}/${OS}/${RELEASE_DIR}/libgiflib.a)
elseif(XCODE_IDE)
	dk_libDebug		(${GIFLIB}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a)
	dk_libRelease	(${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
else()
	dk_libDebug		(${GIFLIB}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a)
	dk_libRelease	(${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
endif()


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

string(REPLACE "-std=c17" "" GIFLIB_CONFIGURE "${DKCONFIGURE_BUILD}")
string(REPLACE "-std=c++1z" "" GIFLIB_CONFIGURE "${GIFLIB_CONFIGURE}")
string(REPLACE "  " " " GIFLIB_CONFIGURE "${GIFLIB_CONFIGURE}")

if(NOT ANDROID)
	DEBUG_dk_setPath	(${GIFLIB}/${OS}/${DEBUG_DIR})
	DEBUG_dk_queueShell	(${GIFLIB_CONFIGURE})
	DEBUG_dk_queueShell	(make -C lib)
	RELEASE_dk_setPath		(${GIFLIB}/${OS}/${RELEASE_DIR})
	RELEASE_dk_queueShell	(${GIFLIB_CONFIGURE})
	RELEASE_dk_queueShell	(make -C lib)
else()
	if(VISUAL_STUDIO_IDE)
		ANDROID_dk_queueCommand(${DKCMAKE_BUILD} ${GIFLIB})
		ANDROID_dk_visualStudio(${GIFLIB_FOLDER} giflib)
	elseif(XCODE_IDE)
		ANDROID_dk_queueCommand(${DKCMAKE_BUILD} ${GIFLIB})
		ANDROID_dk_xcode(${GIFLIB_FOLDER} giflib)
	else()
		ANDROID_DEBUG_dk_setPath		(${GIFLIB}/${OS}/${DEBUG_DIR})
		ANDROID_DEBUG_dk_queueShell		(${GIFLIB_CONFIGURE})
		ANDROID_DEBUG_dk_queueShell		(make -C lib)
		ANDROID_RELEASE_dk_setPath		(${GIFLIB}/${OS}/${RELEASE_DIR})
		ANDROID_RELEASE_dk_queueShell	(${GIFLIB_CONFIGURE})
		ANDROID_RELEASE_dk_queueShell	(make -C lib)
	endif()
endif()
