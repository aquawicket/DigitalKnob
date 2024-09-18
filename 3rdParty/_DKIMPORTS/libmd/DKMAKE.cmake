include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/guillemj/libmd.git

if(NOT IOSSIM)
	dk_undepend(libmd)
	dk_return()
endif()


### DEPEND ###
dk_depend(autotools)


### IMPORT ###
#dk_import(https://github.com/guillemj/libmd.git)
dk_import(https://github.com/guillemj/libmd/archive/refs/heads/main.zip)


### LINK ###
dk_include			(${LIBMD}/include)
UNIX_dk_libDebug	(${LIBMD}/${triple}/${DEBUG_DIR}/liblibmdd.a)
UNIX_dk_libRelease	(${LIBMD}/${triple}/${RELEASE_DIR}/liblibmd.a)
WIN_dk_libDebug		(${LIBMD}/${triple}/${DEBUG_DIR}/libmdd.lib)
WIN_dk_libRelease	(${LIBMD}/${triple}/${RELEASE_DIR}/libmd.lib)


### 3RDPARTY LINK ###
dk_set(LIBMD_CMAKE -DLIBMD_LIBRARY=${LIBMD}/${triple}/${DEBUG_DIR}/libmd.a)


### COMPILE ###
if(ANDROID)
	ANDROID_dk_ndk(${LIBMD})
else()
	DEBUG_dk_cd		(${LIBMD})
	DEBUG_dk_queueCommand	(aclocal)
	
	#DEBUG_dk_cd		(${LIBMD}/${triple}/${DEBUG_DIR})
	#DEBUG_dk_queueCommand	(${DKCONFIGURE_BUILD})
	#RELEASE_dk_cd		(${LIBMD}/${triple}/${RELEASE_DIR})
	#RELEASE_dk_queueCommand	(${DKCONFIGURE_BUILD})
	dk_configure			(${LIBMD_DIR})
	
	
	dk_build				(${LIBMD_DIR})
endif()
