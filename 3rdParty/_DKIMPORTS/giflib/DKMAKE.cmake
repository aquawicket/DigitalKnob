# http://giflib.sourceforge.net
# https://github.com/mirrorer/giflib
# https://github.com/mirrorer/giflib.git
# https://github.com/mirrorer/giflib/archive/fa37672085ce4b3d62c51627ab3c8cf2dda8009a.zip
# https://sourceforge.net/projects/giflib/files/giflib-5.1.1.tar.gz
# https://stackoverflow.com/a/34102586/688352  #'aclocal-1.15' is missing on your system

### DEPEND ###
WIN_dk_depend(msys2)
dk_depend(autotools)
#dk_depend(gcc)


### IMPORT ###
#dk_import(https://github.com/mirrorer/giflib.git PATCH)
#dk_import(https://sourceforge.net/code-snapshots/git/g/gi/giflib/code.git/giflib-code-8bed392c280ad2c237e8bf1beca6f8f68f893e87.zip)
dk_import(https://git.code.sf.net/p/giflib/code.git PATCH)

set(GIFLIB_USE_CMAKE ON)
if(GIFLIB_USE_CMAKE)

	### LINK ###
	dk_include			(${GIFLIB}/lib										GIF_INCLUDE_DIR)
	dk_include			(${GIFLIB}/${OS}									GIF_INCLUDE_DIR2)
	dk_libDebug			(${GIFLIB}/${OS}/${DEBUG_DIR}/libgiflib.a			GIF_LIBRARY_DEBUG)
	dk_libRelease		(${GIFLIB}/${OS}/${RELEASE_DIR}/libgiflib.a			GIF_LIBRARY_RELEASE)
	
	### 3RDPARTY LINK ###
	DEBUG_dk_set		(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIF_INCLUDE_DIR} -DGIF_INCLUDE_DIR2=${GIF_INCLUDE_DIR2} -DGIF_LIBRARY=${GIF_LIBRARY_DEBUG})
	RELEASE_dk_set		(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIF_INCLUDE_DIR} -DGIF_INCLUDE_DIR2=${GIF_INCLUDE_DIR2} -DGIF_LIBRARY=${GIF_LIBRARY_RELEASE})

	dk_configure		(${GIFLIB})
	dk_build			(${GIFLIB} giflib)	
else()
	### LINK ###
	dk_include			(${GIFLIB}/lib										GIF_INCLUDE_DIR)
	dk_include			(${GIFLIB}/${OS}									GIF_INCLUDE_DIR2)
	dk_libDebug			(${GIFLIB}/${OS}/${DEBUG_DIR}/lib/.libs/libgif.a	GIF_LIBRARY_DEBUG)
	dk_libRelease		(${GIFLIB}/${OS}/${RELEASE_DIR}/lib/.libs/libgif.a	GIF_LIBRARY_RELEASE)

	### 3RDPARTY LINK ###
	DEBUG_dk_set		(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIF_INCLUDE_DIR} -DGIF_INCLUDE_DIR2=${GIF_INCLUDE_DIR2} -DGIF_LIBRARY=${GIF_LIBRARY_DEBUG})
	RELEASE_dk_set		(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIF_INCLUDE_DIR} -DGIF_INCLUDE_DIR2=${GIF_INCLUDE_DIR2} -DGIF_LIBRARY=${GIF_LIBRARY_RELEASE})
	
	### GENERATE / CONFIGURE ###
	dk_setPath			(${GIFLIB})
	dk_queueCommand		(bash -c "autoreconf -f -i")

	string(REPLACE "-std=c17" "" GIFLIB_CONFIGURE "${DKCONFIGURE_BUILD}")
	string(REPLACE "-std=c++1z" "" GIFLIB_CONFIGURE "${GIFLIB_CONFIGURE}")
	string(REPLACE "  " " " GIFLIB_CONFIGURE "${GIFLIB_CONFIGURE}")

	if(ANDROID)
		if(MSVC)
			dk_queueCommand		(${DKCMAKE_BUILD} ${GIFLIB})
			dk_visualStudio		(${GIFLIB} giflib)
		else()
			dk_configure		(${GIFLIB})
			dk_queueCommand		(make -C lib)
		endif()
	else()
		if(EMSCRIPTEN)
			dk_queueCommand		(${DKCMAKE_BUILD} ${GIFLIB})
			dk_build			(${GIFLIB})
		else()
			dk_configure		(${GIFLIB})
			dk_queueCommand		(make -C lib)
		endif()
	endif()
endif()

# FIX for other searchers
dk_copy(${GIFLIB}/gif_lib.h ${GIFLIB}/lib/gif_lib.h)