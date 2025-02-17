#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ z264 ############
# https://code.videolan.org/videolan/x264.git
dk_load			(dk_builder)

### DEPENDS ###
dk_depend		(msys2)
dk_depend		(nasm)

### IMPORT ###
dk_import		(https://code.videolan.org/videolan/x264/-/archive/80c1c47c/x264-80c1c47c.zip)

### LINK ###
dk_include		(${X264}/include)
dk_include		(${X264}/${target_triple})
dk_libDebug		(${X264_DEBUG_DIR}/libx264.a)
dk_libRelease	(${X264_RELEASE_DIR}/libx264.a)

### GENERATE / COMPILE ###
if(EMSCRIPTEN)
	dk_configure(${X264} --disable-asm --host=i686-pc-linux-gnu --enable-static --disable-cli) #--extra-cflags="-s USE_PTHREADS=1"
else()
	dk_configure(${X264} --disable-asm)
endif()
dk_build        (${X264})
