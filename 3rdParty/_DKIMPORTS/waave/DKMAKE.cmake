# https://sourceforge.net/projects/waave
# https://sourceforge.net/projects/waave/files/waave/waave-3.01.tar.gz


### DEPEND ###
dk_depend(ffmpeg-dev)
dk_depend(ffmpeg-shared)
dk_depend(ffmpeg-static)
dk_depend(sdl)


### IMPORT ###
dk_import(https://sourceforge.net/projects/waave/files/waave/waave-3.01.tar.gz PATCH)
#dk_import(git://git.code.sf.net/p/waave/code)


### LINK ###
dk_include				(${WAAVE}/src)
WIN_dk_libDebug			(${WAAVE}/${OS}/${DEBUG_DIR}/waave.lib)
WIN_dk_libRelease		(${WAAVE}/${OS}/${RELEASE_DIR}/waave.lib)
APPLE_dk_libDebug		(${WAAVE}/${OS}/${DEBUG_DIR}/libwaave.a)
APPLE_dk_libRelease		(${WAAVE}/${OS}/${RELEASE_DIR}/libwaave.a)
LINUX_dk_libDebug		(${WAAVE}/${OS}/${DEBUG_DIR}/libwaave.a)
LINUX_dk_libRelease		(${WAAVE}/${OS}/${RELEASE_DIR}/libwaave.a)
ANDROID_dk_libDebug		(${WAAVE}/${OS}/${DEBUG_DIR}/libwaave.a)
ANDROID_dk_libRelease	(${WAAVE}/${OS}/${RELEASE_DIR}/libwaave.a)


### GENERATE ###
dk_setPath					(${WAAVE}/${BUILD_DIR})
WIN_dk_queueCommand			(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=/I${FFMPEG-DEV}/include" ${FFMPEG-DEV_CMAKE} ${SDL_CMAKE} ${WAAVE})
APPLE_dk_queueCommand		(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=/I${FFMPEG-DEV}/include" ${FFMPEG-DEV_CMAKE} ${SDL_CMAKE} ${WAAVE})
LINUX_dk_queueCommand		(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=/I${FFMPEG-DEV}/include" ${FFMPEG-DEV_CMAKE} ${SDL_CMAKE} ${WAAVE})
RASPBERRY_dk_queueCommand	(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=/I${FFMPEG-DEV}/include" ${FFMPEG-DEV_CMAKE} ${SDL_CMAKE} ${WAAVE})
ANDROID_dk_queueCommand		(${DKCMAKE_BUILD} "-DCMAKE_C_FLAGS=/I${FFMPEG-DEV}/include" ${FFMPEG-DEV_CMAKE} ${SDL_CMAKE} ${WAAVE})


### COMPILE ###
dk_visualStudio	(${WAAVE_NAME} waave)	# windows, android
dk_xcode		(${WAAVE_NAME} waave)	# mac, ios, iossim
dk_make			(${WAAVE_NAME} waave)	# linux, raspberry
