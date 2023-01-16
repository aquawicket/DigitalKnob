# https://github.com/guillemj/libmd.git

if(NOT IOSSIM)
	return()
endif()


### DEPEND ###
dk_depend(autotools)


### IMPORT ###
dk_import(https://github.com/guillemj/libmd.git)


### LINK ###
dk_include			(${LIBMD}/include)
WIN_dk_libDebug		(${LIBMD}/${OS}/${DEBUG_DIR}/libmdd.lib)
WIN_dk_libRelease	(${LIBMD}/${OS}/${RELEASE_DIR}/libmd.lib)
UNIX_dk_libDebug	(${LIBMD}/${OS}/${DEBUG_DIR}/liblibmdd.a)
UNIX_dk_libRelease	(${LIBMD}/${OS}/${RELEASE_DIR}/liblibmd.a)


### 3RDPARTY LINK ###
dk_set(LIBMD_CMAKE -DLIBMD_LIBRARY=${LIBMD}/${OS}/${DEBUG_DIR}/libmd.a)


### COMPILE ###
if(ANDROID)
	ANDROID_dk_ndk(${LIBMD})
else()
	DEBUG_dk_setPath		(${LIBMD})
	DEBUG_dk_queueShell		(aclocal)
	DEBUG_dk_setPath		(${LIBMD}/${OS}/${DEBUG_DIR})
	DEBUG_dk_queueShell		(${DKCONFIGURE_BUILD})
	DEBUG_dk_queueShell		(make)
	RELEASE_dk_setPath		(${LIBMD}/${OS}/${RELEASE_DIR})
	RELEASE_dk_queueShell	(${DKCONFIGURE_BUILD})
	RELEASE_dk_queueShell	(make)
endif()
