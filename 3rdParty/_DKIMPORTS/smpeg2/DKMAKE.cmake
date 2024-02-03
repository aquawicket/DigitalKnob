## https://www.libsdl.org/projects/smpeg/release/smpeg2-2.0.0.tar.gz


### DEPEND ###
dk_depend(sdl)


### IMPORT ###
dk_import(https://www.libsdl.org/projects/smpeg/release/smpeg2-2.0.0.tar.gz PATCH)


### LINK ###
dk_include				(${SMPEG2})
if(MSVC)
	WIN_dk_libDebug		(${SMPEG2}/${OS}/lib/${DEBUG_DIR}/libsmpeg2.lib)
	WIN_dk_libRelease	(${SMPEG2}/${OS}/lib/${RELEASE_DIR}/libsmpeg2.lib)
elseif(APPLE)
	APPLE_dk_libDebug	(${SMPEG2}/${OS}/lib/${DEBUG_DIR}/libsmpeg2.a)
	APPLE_dk_libRelease	(${SMPEG2}/${OS}/lib/${RELEASE_DIR}/libsmpeg2.a)
else()
	dk_libDebug			(${SMPEG2}/${OS}/${DEBUG_DIR}/lib/libsmpeg2.a)
	dk_libRelease		(${SMPEG2}/${OS}/${RELEASE_DIR}/lib/libsmpeg2.a)
endif()



### 3RDPARTY LINK ###
dk_set(SMPEG2_CMAKE -DSMPEG_INCLUDE_DIR=${SMPEG2})
	
	
### GENERATE ###
if(MSVC OR ANDROID)
	dk_queueCommand		(${DKCMAKE_BUILD} ${SDL_CMAKE} ${SMPEG2})
else()
	dk_queueCommand		(${DKCMAKE_BUILD} ${SDL_CMAKE} -DCMAKE_CXX_FLAGS=-Wno-narrowing ${SMPEG2})
endif()



### COMPILE ###
dk_build(${SMPEG2} SMPEG)
