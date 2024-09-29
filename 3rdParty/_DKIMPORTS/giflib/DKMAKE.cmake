#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
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
#dk_import(https://sourceforge.net/code-snapshots/git/g/gi/giflib/code.git/giflib-code-8bed392c280ad2c237e8bf1beca6f8f68f893e87.zip PATCH)
#dk_import(https://github.com/mirrorer/giflib.git PATCH)
#dk_import(https://git.code.sf.net/p/giflib/code.git PATCH)
#dk_import(https://github.com/nesbox/giflib.git PATCH)
dk_import(https://github.com/nesbox/giflib/archive/refs/heads/master.zip PATCH)

set(GIFLIB_USE_CMAKE ON)
if(GIFLIB_USE_CMAKE)

	### LINK ###
	dk_include			(${GIFLIB_DIR}							GIF_INCLUDE_DIR)
	#dk_include			(${GIFLIB_DIR}/lib						GIF_INCLUDE_DIR)
	dk_include			(${GIFLIB_CONFIG_DIR}					GIF_INCLUDE_DIR2)
	if(WIN AND MSVC)
		dk_libDebug		(${GIFLIB_DEBUG_DIR}/giflibd.lib		GIF_LIBRARY_DEBUG)
		dk_libRelease	(${GIFLIB_RELEASE_DIR}/giflib.lib		GIF_LIBRARY_RELEASE)
	else()
		dk_libDebug		(${GIFLIB_DEBUG_DIR}/libgiflib.a		GIF_LIBRARY_DEBUG)
		dk_libRelease	(${GIFLIB_RELEASE_DIR}/libgiflib.a		GIF_LIBRARY_RELEASE)
	endif()
	
	### 3RDPARTY LINK ###
	dk_append			(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIF_INCLUDE_DIR} -DGIF_INCLUDE_DIR2=${GIF_INCLUDE_DIR2})
	DEBUG_dk_append		(GIFLIB_CMAKE -DGIF_LIBRARY=${GIF_LIBRARY_DEBUG})
	RELEASE_dk_append	(GIFLIB_CMAKE -DGIF_LIBRARY=${GIF_LIBRARY_RELEASE})

	dk_configure		(${GIFLIB_DIR})
	dk_build			(${GIFLIB_DIR} giflib)	
	
	
	
	
	
	
else()
	### LINK ###
	dk_include			(${GIFLIB_DIR}/lib							GIF_INCLUDE_DIR)
	#dk_include			(${GIFLIB}/${triple}						GIF_INCLUDE_DIR2)
	dk_include			(${GIFLIB_CONFIG_DIR}						GIF_INCLUDE_DIR2)
	dk_libDebug			(${GIFLIB_DEBUG_DIR}/lib/.libs/libgif.a		GIF_LIBRARY_DEBUG)
	dk_libRelease		(${GIFLIB_RELEASE_DIR}/lib/.libs/libgif.a	GIF_LIBRARY_RELEASE)

	### 3RDPARTY LINK ###
	DEBUG_dk_set		(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIF_INCLUDE_DIR} -DGIF_INCLUDE_DIR2=${GIF_INCLUDE_DIR2} -DGIF_LIBRARY=${GIF_LIBRARY_DEBUG})
	RELEASE_dk_set		(GIFLIB_CMAKE -DGIF_INCLUDE_DIR=${GIF_INCLUDE_DIR} -DGIF_INCLUDE_DIR2=${GIF_INCLUDE_DIR2} -DGIF_LIBRARY=${GIF_LIBRARY_RELEASE})
	
	### GENERATE / CONFIGURE ###
	dk_cd			(${GIFLIB_DIR})
	dk_depend(bash)
	dk_queueCommand	(${BASH_EXE} -c "autoreconf -f -i")

	string(REPLACE "-std=c17" "" GIFLIB_CONFIGURE "${DKCONFIGURE_BUILD}")
	string(REPLACE "-std=c++1z" "" GIFLIB_CONFIGURE "${GIFLIB_CONFIGURE}")
	string(REPLACE "  " " " GIFLIB_CONFIGURE "${GIFLIB_CONFIGURE}")

	dk_configure		(${GIFLIB})
	if(ANDROID)
		if(MSVC)
			dk_visualStudio		(${GIFLIB} giflib)
		else()
			dk_queueCommand		(make -C lib)
		endif()
	else()
		if(EMSCRIPTEN)
			dk_build			(${GIFLIB})
		else()
			dk_queueCommand		(make -C lib)
		endif()
	endif()
endif()

# FIX for other searchers
#dk_copy(${GIFLIB_DIR}/gif_lib.h ${GIFLIB_DIR}/lib/gif_lib.h)
