## https://www.libsdl.org/projects/smpeg/release/smpeg2-2.0.0.tar.gz

dk_depend(sdl)


dk_import(https://www.libsdl.org/projects/smpeg/release/smpeg2-2.0.0.tar.gz PATCH)


### DKPLUGINS LINK ###
dk_include(${SMPEG2})
WIN_dk_libDebug			(${SMPEG2}/${OS}/lib/${DEBUG_DIR}/libsmpeg2.lib)
WIN_dk_libRelease		(${SMPEG2}/${OS}/lib/${RELEASE_DIR}/libsmpeg2.lib)
APPLE_dk_libDebug		(${SMPEG2}/${OS}/lib/${DEBUG_DIR}/libsmpeg2.a)
APPLE_dk_libRelease		(${SMPEG2}/${OS}/lib/${RELEASE_DIR}/libsmpeg2.a)
LINUX_dk_libDebug		(${SMPEG2}/${OS}/${DEBUG_DIR}/lib/libsmpeg2.a)
LINUX_dk_libRelease		(${SMPEG2}/${OS}/${RELEASE_DIR}/lib/libsmpeg2.a)
RASPBERRY_dk_libDebug	(${SMPEG2}/${OS}/${DEBUG_DIR}/lib/libsmpeg2.a)
RASPBERRY_dk_libRelease	(${SMPEG2}/${OS}/${RELEASE_DIR}/lib/libsmpeg2.a)
ANDROID_dk_libDebug		(${SMPEG2}/${OS}/${DEBUG_DIR}/lib/libsmpeg2.a)
ANDROID_dk_libRelease	(${SMPEG2}/${OS}/${RELEASE_DIR}/lib/libsmpeg2.a)


### 3RDPARTY LINK ###
dk_set			(SMPEG2_CMAKE -DSMPEG_INCLUDE_DIR=${SMPEG2})
#WIN_dk_set		(SMPEG2_CMAKE -DSMPEG_INCLUDE_DIR=${SMPEG2})
#APPLE_dk_set	(SMPEG2_CMAKE -DSMPEG_INCLUDE_DIR=${SMPEG2})
#LINUX_dk_set	(SMPEG2_CMAKE -DSMPEG_INCLUDE_DIR=${SMPEG2})
#RASPBERRY_dk_set(SMPEG2_CMAKE -DSMPEG_INCLUDE_DIR=${SMPEG2})
#ANDROID_dk_set	(SMPEG2_CMAKE -DSMPEG_INCLUDE_DIR=${SMPEG2})
	
	
### COMPILE ###
dk_setPath(${SMPEG2}/${BUILD_DIR})

WIN_dk_queueCommand		(${DKCMAKE_BUILD} ${SDL_CMAKE} ${SMPEG2})
MAC_dk_queueCommand		(${DKCMAKE_BUILD} -DCMAKE_CXX_FLAGS=-Wno-narrowing ${SDL_CMAKE} ${SMPEG2})
IOS_dk_queueCommand		(${DKCMAKE_BUILD} -DCMAKE_CXX_FLAGS=-Wno-narrowing ${SDL_CMAKE} ${SMPEG2})
IOSSIM_dk_queueCommand	(${DKCMAKE_BUILD} -DCMAKE_CXX_FLAGS=-Wno-narrowing ${SDL_CMAKE} ${SMPEG2})
LINUX_dk_queueCommand	(${DKCMAKE_BUILD} -DCMAKE_CXX_FLAGS=-Wno-narrowing ${SDL_CMAKE} ${SMPEG2})
RASPBERRY_dk_queueCommand(${DKCMAKE_BUILD} -DCMAKE_CXX_FLAGS=-Wno-narrowing ${SDL_CMAKE} ${SMPEG2})
ANDROID_dk_queueCommand	(${DKCMAKE_BUILD} ${SDL_CMAKE} ${SMPEG2})


VS				(${SMPEG2_NAME} SMPEG.sln SMPEG)
#WIN_VS				(${SMPEG2_NAME} SMPEG.sln SMPEG)
XCODE			(${SMPEG2_NAME} SMPEG)
#MAC_XCODE			(${SMPEG2_NAME} SMPEG)
#IOS_XCODE			(${SMPEG2_NAME} SMPEG)
#IOSSIM_XCODE		(${SMPEG2_NAME} SMPEG)
LINUX_dk_queueCommand	(make SMPEG)
RASPBERRY_dk_queueCommand(make SMPEG)
#ANDROID_VS			(${SMPEG2_NAME} SMPEG.sln SMPEG)
