## https://www.libsdl.org/projects/smpeg/release/smpeg2-2.0.0.tar.gz


### DEPEND ###
dk_depend(sdl)


### IMPORT ###
dk_import(https://www.libsdl.org/projects/smpeg/release/smpeg2-2.0.0.tar.gz PATCH)


### LINK ###
dk_include				(${SMPEG2})
ANDROID_dk_libDebug		(${SMPEG2}/${OS}/${DEBUG_DIR}/lib/libsmpeg2.a)
ANDROID_dk_libRelease	(${SMPEG2}/${OS}/${RELEASE_DIR}/lib/libsmpeg2.a)
APPLE_dk_libDebug		(${SMPEG2}/${OS}/lib/${DEBUG_DIR}/libsmpeg2.a)
APPLE_dk_libRelease		(${SMPEG2}/${OS}/lib/${RELEASE_DIR}/libsmpeg2.a)
EMSCRIPTEN_dk_libDebug	(${SMPEG2}/${OS}/${DEBUG_DIR}/lib/libsmpeg2.a)
EMSCRIPTEN_dk_libRelease(${SMPEG2}/${OS}/${RELEASE_DIR}/lib/libsmpeg2.a)
LINUX_dk_libDebug		(${SMPEG2}/${OS}/${DEBUG_DIR}/lib/libsmpeg2.a)
LINUX_dk_libRelease		(${SMPEG2}/${OS}/${RELEASE_DIR}/lib/libsmpeg2.a)
RASPBERRY_dk_libDebug	(${SMPEG2}/${OS}/${DEBUG_DIR}/lib/libsmpeg2.a)
RASPBERRY_dk_libRelease	(${SMPEG2}/${OS}/${RELEASE_DIR}/lib/libsmpeg2.a)
WIN_dk_libDebug			(${SMPEG2}/${OS}/lib/${DEBUG_DIR}/libsmpeg2.lib)
WIN_dk_libRelease		(${SMPEG2}/${OS}/lib/${RELEASE_DIR}/libsmpeg2.lib)


### 3RDPARTY LINK ###
dk_set(SMPEG2_CMAKE -DSMPEG_INCLUDE_DIR=${SMPEG2})
	
	
### GENERATE ###
ANDROID_dk_queueCommand		(${DKCMAKE_BUILD} ${SDL_CMAKE} ${SMPEG2})
APPLE_dk_queueCommand		(${DKCMAKE_BUILD} -DCMAKE_CXX_FLAGS=-Wno-narrowing ${SDL_CMAKE} ${SMPEG2})
EMSCRIPTEN_dk_queueCommand	(${DKCMAKE_BUILD} -DCMAKE_CXX_FLAGS=-Wno-narrowing ${SDL_CMAKE} ${SMPEG2})
LINUX_dk_queueCommand		(${DKCMAKE_BUILD} -DCMAKE_CXX_FLAGS=-Wno-narrowing ${SDL_CMAKE} ${SMPEG2})
RASPBERRY_dk_queueCommand	(${DKCMAKE_BUILD} -DCMAKE_CXX_FLAGS=-Wno-narrowing ${SDL_CMAKE} ${SMPEG2})
WIN_dk_queueCommand			(${DKCMAKE_BUILD} ${SDL_CMAKE} ${SMPEG2})


### COMPILE ###
dk_build(${SMPEG2} SMPEG)
