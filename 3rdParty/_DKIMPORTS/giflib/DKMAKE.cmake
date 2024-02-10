# http://giflib.sourceforge.net
# https://github.com/mirrorer/giflib
# https://github.com/mirrorer/giflib.git
# https://github.com/mirrorer/giflib/archive/fa37672085ce4b3d62c51627ab3c8cf2dda8009a.zip
# https://sourceforge.net/projects/giflib/files/giflib-5.1.1.tar.gz
# https://stackoverflow.com/a/34102586/688352  #'aclocal-1.15' is missing on your system

### DEPEND ###
WIN_dk_depend(msys2)
dk_depend(autotools)
dk_depend(gcc)


### IMPORT ###
dk_import(https://github.com/mirrorer/giflib.git PATCH)

set(GIFLIB_USE_CMAKE ON)
if(GIFLIB_USE_CMAKE)

	### LINK ###
	dk_include			(${GIFLIB}/lib										GIF_INCLUDE_DIR)
	dk_include			(${GIFLIB}/${OS}									GIF_INCLUDE_DIR2)
	UNIX_dk_libDebug	(${GIFLIB}/${OS}/${DEBUG_DIR}/libgiflib.a			GIF_LIBRARY_DEBUG)
	UNIX_dk_libRelease	(${GIFLIB}/${OS}/${RELEASE_DIR}/libgiflib.a			GIF_LIBRARY_RELEASE)
	WIN_dk_libDebug		(${GIFLIB}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a	GIF_LIBRARY_DEBUG)
	WIN_dk_libRelease	(${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a	GIF_LIBRARY_RELEASE)
	
	### 3RDPARTY LINK ###
	dk_set				(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIF_INCLUDE_DIR} -DGIF_INCLUDE_DIR2=${GIF_INCLUDE_DIR2} -DGIF_LIBRARY=${GIF_LIBRARY_RELEASE})
	
	### GENERATE / CONFIGURE ###
	if(WIN)
		#dk_setPath				(${GIFLIB})
		
		if(MSYS)
			#dk_queueCommand	(export ACLOCAL_PATH=${MSYS2}/usr/share/aclocal && autoreconf -f -i)
			dk_queueCommand		(export ACLOCAL_PATH=${MSYS2}/usr/share/aclocal && ../../autoreconf -f -i)
		else()
			#dk_queueCommand	(autoreconf -f -i)
			dk_queueCommand		(../../autoreconf -f -i)
		endif()

		string					(REPLACE "-std=c17" 	""	GIFLIB_CONFIGURE "${DKCONFIGURE_BUILD}")
		string					(REPLACE "-std=c++1z" 	"" 	GIFLIB_CONFIGURE "${GIFLIB_CONFIGURE}")
		string					(REPLACE "  " 			" " GIFLIB_CONFIGURE "${GIFLIB_CONFIGURE}")
	
		
		#DEBUG_dk_setPath		(${GIFLIB}/${OS}/${DEBUG_DIR})
		DEBUG_dk_queueCommand	(${GIFLIB_CONFIGURE})
		DEBUG_dk_queueCommand	(make -C lib)
		#RELEASE_dk_setPath		(${GIFLIB}/${OS}/${RELEASE_DIR})
		RELEASE_dk_queueCommand	(../../configure)
		RELEASE_dk_queueCommand	(make -C lib)
	else()
		### GENERATE ###
		dk_queueCommand			(${DKCMAKE_BUILD} ${GIFLIB})
	
		### COMPILE ###
		dk_build				(${GIFLIB} giflib)
	endif()
	
else()
	### LINK ###
	dk_include					(${GIFLIB}/lib)
	if(MSVC)
		ANDROID_dk_libDebug		(${GIFLIB}/${OS}/${DEBUG_DIR}/libgiflib.a)
		ANDROID_dk_libRelease	(${GIFLIB}/${OS}/${RELEASE_DIR}/libgiflib.a)
		WIN_dk_libDebug			(${GIFLIB}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a)
		WIN_dk_libRelease		(${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a)
	elseif(APPLE)
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
	dk_set						(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIF_INCLUDE_DIR} -DGIF_INCLUDE_DIR2=${GIF_INCLUDE_DIR2} -DGIF_LIBRARY=${GIF_LIBRARY_RELEASE})	
	dk_setPath					(${GIFLIB})
	
	if(MSYS)
		dk_queueCommand	(export ACLOCAL_PATH=${MSYS2}/usr/share/aclocal && autoreconf -f -i)
	else()
		dk_queueCommand	(autoreconf -f -i)
	endif()
	
	string(REPLACE "-std=c17" "" GIFLIB_CONFIGURE "${DKCONFIGURE_BUILD}")
	string(REPLACE "-std=c++1z" "" GIFLIB_CONFIGURE "${GIFLIB_CONFIGURE}")
	string(REPLACE "  " " " GIFLIB_CONFIGURE "${GIFLIB_CONFIGURE}")

	if(ANDROID)
		if(MSVC)
			dk_queueCommand(${DKCMAKE_BUILD} ${GIFLIB})
			dk_visualStudio(${GIFLIB} giflib)
		else()
			DEBUG_dk_setPath		(${GIFLIB}/${OS}/${DEBUG_DIR})
			DEBUG_dk_queueCommand	(${GIFLIB_CONFIGURE})
			DEBUG_dk_queueCommand	(make -C lib)
			RELEASE_dk_setPath		(${GIFLIB}/${OS}/${RELEASE_DIR})
			RELEASE_dk_queueCommand	(${GIFLIB_CONFIGURE})
			RELEASE_dk_queueCommand	(make -C lib)
		endif()
	else()
		if(EMSCRIPTEN)
			dk_queueCommand	(${DKCMAKE_BUILD} ${GIFLIB})
			dk_build(${GIFLIB})
		else()
			DEBUG_dk_setPath		(${GIFLIB}/${OS}/${DEBUG_DIR})
			DEBUG_dk_queueCommand	(${GIFLIB_CONFIGURE})
			DEBUG_dk_queueCommand	(make -C lib)
			RELEASE_dk_setPath		(${GIFLIB}/${OS}/${RELEASE_DIR})
			RELEASE_dk_queueCommand	(${GIFLIB_CONFIGURE})
			RELEASE_dk_queueCommand	(make -C lib)
		endif()
	endif()
endif()