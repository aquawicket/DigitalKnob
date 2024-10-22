#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ z264 ############
dk_load(dk_builder)
# https://code.videolan.org/videolan/x264.git

### DEPENDS ###
dk_depend(msys2)
dk_depend(nasm)

### IMPORT ###
dk_import(https://code.videolan.org/videolan/x264/-/archive/80c1c47c/x264-80c1c47c.zip)

### LINK ###
dk_include		(${X264}/include)
dk_include		(${X264}/${triple})
dk_libDebug		(${X264_DEBUG_DIR}/libx264.a)
dk_libRelease	(${X264_RELEASE_DIR}/libx264.a)

### GENERATE / COMPILE ###
if(DEBUG)
	dk_cd(${X264}/${triple}/${DEBUG_DIR})
	if(EMSCRIPTEN)
		dk_queueCommand	(${EMCONFIGURE} ../../configure --host=i686-pc-linux-gnu --enable-static --disable-asm --disable-cli) #--extra-cflags="-s USE_PTHREADS=1"
		dk_queueCommand	(${EMMAKE} make)
	else()
		dk_queueCommand	(../../configure --disable-asm)
		dk_build        (${X264})
	endif()
endif()

if(RELEASE)
	RELEASE_dk_cd		(${X264}/${triple}/${RELEASE_DIR})
	if(EMSCRIPTEN)
		dk_queueCommand	(${EMCONFIGURE} ../../configure --host=i686-pc-linux-gnu --enable-static --disable-asm --disable-cli)
		dk_queueCommand	(${EMMAKE} make)
	else()
		dk_queueCommand	(../../configure --disable-asm)
		dk_build		(${X264})
	endif()
endif()
