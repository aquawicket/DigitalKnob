# http://giflib.sourceforge.net
# https://github.com/mirrorer/giflib
# https://github.com/mirrorer/giflib.git
# https://github.com/mirrorer/giflib/archive/fa37672085ce4b3d62c51627ab3c8cf2dda8009a.zip
# https://sourceforge.net/projects/giflib/files/giflib-5.1.1.tar.gz
# https://stackoverflow.com/a/34102586/688352  #'aclocal-1.15' is missing on your system


### DEPEND ###
MAC_dk_depend(autotools)
#WIN_dk_depend(msys)		# migrated to msys2
WIN_dk_depend(msys2)


### IMPORT ###
dk_import(https://github.com/mirrorer/giflib.git PATCH)


### LINK ###
dk_include					(${GIFLIB}/lib)
if(VISUAL_STUDIO_IDE)
	ANDROID_dk_libDebug		(${GIFLIB}/${OS}/${DEBUG_DIR}/libgiflib.a)
	ANDROID_dk_libRelease	(${GIFLIB}/${OS}/${RELEASE_DIR}/libgiflib.a)
	WIN_dk_libDebug			(${GIFLIB}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a)
	WIN_dk_libRelease		(${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
elseif(XCODE_IDE)
	dk_libDebug				(${GIFLIB}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a)
	dk_libRelease			(${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
else()
	if(EMSCRIPTEN)
		dk_libDebug			(${GIFLIB}/${OS}/${DEBUG_DIR}/libgiflib.a)
		dk_libRelease		(${GIFLIB}/${OS}/${RELEASE_DIR}/libgiflib.a)
	else()
		dk_libDebug			(${GIFLIB}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a)
		dk_libRelease		(${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
	endif()
endif()


### 3RDPARTY LINK ###
ANDROID_dk_set		(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIFLIB}/lib -DGIF_INCLUDE_DIR2=${GIFLIB}/${OS} -DGIF_LIBRARY=${GIFLIB}/${OS}/${RELEASE_DIR}/libgiflib.a)	
APPLE_dk_set		(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIFLIB}/lib -DGIF_INCLUDE_DIR2=${GIFLIB}/${OS} -DGIF_LIBRARY=${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
EMSCRIPTEN_dk_set	(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIFLIB}/lib -DGIF_INCLUDE_DIR2=${GIFLIB}/${OS} -DGIF_LIBRARY=${GIFLIB}/${OS}/${RELEASE_DIR}/libgiflib.a)
LINUX_dk_set		(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIFLIB}/lib -DGIF_INCLUDE_DIR2=${GIFLIB}/${OS} -DGIF_LIBRARY=${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
RASPBERRY_dk_set	(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIFLIB}/lib -DGIF_INCLUDE_DIR2=${GIFLIB}/${OS} -DGIF_LIBRARY=${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
WIN_dk_set			(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIFLIB}/lib -DGIF_INCLUDE_DIR2=${GIFLIB}/${OS} -DGIF_LIBRARY=${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)


### GENERATE / COMPILE ###
#if(NOT WIN_HOST AND NOT EMSCRIPTEN)
#if(NOT VISUAL_STUDIO_IDE)
	dk_setPath		(${GIFLIB})
	dk_queueShell	(autoreconf -f -i)
#endif()

string(REPLACE "-std=c17" "" GIFLIB_CONFIGURE "${DKCONFIGURE_BUILD}")
string(REPLACE "-std=c++1z" "" GIFLIB_CONFIGURE "${GIFLIB_CONFIGURE}")
string(REPLACE "  " " " GIFLIB_CONFIGURE "${GIFLIB_CONFIGURE}")

if(ANDROID)
	if(VISUAL_STUDIO_IDE)
		dk_queueCommand(${DKCMAKE_BUILD} ${GIFLIB})
		dk_visualStudio(${GIFLIB} giflib)
	else()
		DEBUG_dk_setPath		(${GIFLIB}/${OS}/${DEBUG_DIR})
		DEBUG_dk_queueShell		(${GIFLIB_CONFIGURE})
		DEBUG_dk_queueShell		(make -C lib)
		RELEASE_dk_setPath		(${GIFLIB}/${OS}/${RELEASE_DIR})
		RELEASE_dk_queueShell	(${GIFLIB_CONFIGURE})
		RELEASE_dk_queueShell	(make -C lib)
	endif()
else()
	if(EMSCRIPTEN)
		dk_queueCommand	(${DKCMAKE_BUILD} ${GIFLIB})
		dk_build(${GIFLIB})
	else()
		DEBUG_dk_setPath		(${GIFLIB}/${OS}/${DEBUG_DIR})
		DEBUG_dk_queueShell		(${GIFLIB_CONFIGURE})
		DEBUG_dk_queueShell		(make -C lib)
		RELEASE_dk_setPath		(${GIFLIB}/${OS}/${RELEASE_DIR})
		RELEASE_dk_queueShell	(${GIFLIB_CONFIGURE})
		RELEASE_dk_queueShell	(make -C lib)
	endif()
endif()
