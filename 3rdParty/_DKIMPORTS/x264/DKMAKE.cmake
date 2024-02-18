# https://code.videolan.org/videolan/x264.git


### DEPENDS ###
dk_depend(msys2)
dk_depend(nasm)


### IMPORT ###
dk_import(https://code.videolan.org/videolan/x264.git)


### LINK ###
dk_include		(${X264}/include)
dk_include		(${X264}/${OS})
dk_libDebug		(${X264}/${OS}/${DEBUG_DIR}/libx264.a)
dk_libRelease	(${X264}/${OS}/${RELEASE_DIR}/libx264.a)


### GENERATE / COMPILE ###
DEBUG_dk_setPath			(${X264}/${OS}/${DEBUG_DIR})
if(EMSCRIPTEN)
	DEBUG_dk_queueCommand	(${EMCONFIGURE} ../../configure --host=i686-pc-linux-gnu --enable-static --disable-asm --disable-cli) #--extra-cflags="-s USE_PTHREADS=1"
	DEBUG_dk_queueCommand	(${EMMAKE} make)
else()
	DEBUG_dk_queueCommand	(../../configure --disable-asm)
	DEBUG_dk_build			(${X264})
endif()

RELEASE_dk_setPath			(${X264}/${OS}/${RELEASE_DIR})
if(EMSCRIPTEN)
	RELEASE_dk_queueCommand	(${EMCONFIGURE} ../../configure --host=i686-pc-linux-gnu --enable-static --disable-asm --disable-cli)
	RELEASE_dk_queueCommand	(${EMMAKE} make)
else()
	RELEASE_dk_queueCommand	(../../configure --disable-asm)
	RELEASE_dk_build		(${X264})
endif()

