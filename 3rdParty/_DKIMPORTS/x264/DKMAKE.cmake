# https://code.videolan.org/videolan/x264.git


### DEPENDS ###
#dk_depend(mingw32)
#dk_depend(mingw64)
dk_depend(msys)
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
DEBUG_dk_setPath		(${X264}/${OS}/${DEBUG_DIR})
#DEBUG_dk_queueShell	(${DKCONFIGURE_BUILD} --host=i686-pc-linux-gnu --disable-asm --disable-cli --extra-cflags="-s USE_PTHREADS=1")
if(EMSCRIPTEN)
	DEBUG_dk_queueShell		(${EMCONFIGURE} ../../configure --host=i686-pc-linux-gnu --disable-asm)
else()
	DEBUG_dk_queueShell		(../../configure --disable-asm)
endif()
DEBUG_dk_queueShell		(make)
RELEASE_dk_setPath		(${X264}/${OS}/${RELEASE_DIR})
#RELEASE_dk_queueShell	(${DKCONFIGURE_BUILD} --host=i686-pc-linux-gnu --disable-asm --disable-cli --extra-cflags="-s USE_PTHREADS=1")
if(EMSCRIPTEN)
	DEBUG_dk_queueShell		(${EMCONFIGURE} ../../configure --host=i686-pc-linux-gnu --disable-asm)
else()
	RELEASE_dk_queueShell	(../../configure --disable-asm)
endif()
RELEASE_dk_queueShell	(make)
