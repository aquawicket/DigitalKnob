# https://git.ffmpeg.org/ffmpeg.git
# https://trac.ffmpeg.org/wiki/CompilationGuide
# https://www.roxlu.com/2019/062/compiling-ffmpeg-with-x264-on-windows-10-using-msvc
# https://itnext.io/build-ffmpeg-webassembly-version-ffmpeg-js-part-2-compile-with-emscripten-4c581e8c9a16

### DEPENDS ###
dk_depend(core_media)
#dk_depend(libiconv)
dk_depend(security)
dk_depend(video_toolbox)
dk_depend(x264)
dk_depend(xz)
dk_depend(zlib)


### IMPORT ###
dk_import(https://git.ffmpeg.org/ffmpeg.git)


### LINK ###
dk_include			(${FFMPEG})
DEBUG_dk_include	(${FFMPEG}/${OS}/${DEBUG_DIR})
RELEASE_dk_include	(${FFMPEG}/${OS}/${RELEASE_DIR})

# libavdevice
dk_libDebug		(${FFMPEG}/${OS}/${DEBUG_DIR}/libavdevice/libavdevice.a)
dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libavdevice/libavdevice.a)

# libswresample
dk_libDebug		(${FFMPEG}/${OS}/${DEBUG_DIR}/libswresample/libswresample.a)
dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libswresample/libswresample.a)

# libavfilter
dk_libDebug		(${FFMPEG}/${OS}/${DEBUG_DIR}/libavfilter/libavfilter.a)
dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libavfilter/libavfilter.a)

# libavutil
dk_libDebug		(${FFMPEG}/${OS}/${DEBUG_DIR}/libavutil/libavutil.a)
dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libavutil/libavutil.a)

# libswscale
dk_libDebug		(${FFMPEG}/${OS}/${DEBUG_DIR}/libswscale/libswscale.a)
dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libswscale/libswscale.a)

# libavcodec
dk_libDebug		(${FFMPEG}/${OS}/${DEBUG_DIR}/libavcodec/libavcodec.a)
dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libavcodec/libavcodec.a)

# libavformat
dk_libDebug		(${FFMPEG}/${OS}/${DEBUG_DIR}/libavformat/libavformat.a)
dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libavformat/libavformat.a)


### GENERATE / COMPILE ###
set(USE_MSYS2 1)
DEBUG_dk_setPath				(${FFMPEG}/${OS}/${DEBUG_DIR})
if(EMSCRIPTEN)
	DEBUG_dk_queueshell(${EMCONFIGURE} ../../configure
		--pkg-config-flags=--static 
		--disable-shared 
		--enable-static 
		--disable-x86asm 
		--disable-iconv 
		--target-os=none 
		--arch=x86_32 
		--enable-cross-compile
		--disable-inline-asm
		--disable-stripping
		--disable-programs
		--disable-doc
		#--extra-cflags="-s USE_PTHREADS"
		#--extra-cxxflags="-s USE_PTHREADS"
		#--extra-ldflags="-s USE_PTHREADS -s INITIAL_MEMORY=33554432"
		--nm="llvm-nm"
		--ar=emar
		--ranlib=emranlib
		--cc=emcc
		--cxx=em++
		--objcc=emcc
		--dep-cc=emcc)
	DEBUG_dk_queueShell(${EMMAKE} make)
else()
	#DEBUG_dk_queueshell		(${DKCONFIGURE_BUILD})
	#DEBUG_dk_queueshell		(../../configure --disable-x86asm)
	#DEBUG_dk_queueshell		(../../configure --pkg-config-flags=--static --disable-shared --enable-static --arch=x86 --target-os=mingw32 --cross-prefix=i686-w64-mingw32-)
	UNIX_DEBUG_dk_queueshell	(../../configure --pkg-config-flags=--static --disable-shared --enable-static --disable-x86asm --disable-iconv)
	WIN32_DEBUG_dk_queueshell	(../../configure --pkg-config-flags=--static --disable-shared --enable-static --target-os=mingw32)
	WIN64_DEBUG_dk_queueshell	(../../configure --pkg-config-flags=--static --disable-shared --enable-static --target-os=mingw64)
	DEBUG_dk_queueshell			(make)
endif()

RELEASE_dk_setPath				(${FFMPEG}/${OS}/${RELEASE_DIR})
if(EMSCRIPTEN)
	RELEASE_dk_queueshell(${EMCONFIGURE} ../../configure 
		--pkg-config-flags=--static 
		--disable-shared 
		--enable-static 
		--disable-x86asm 
		--disable-iconv
		--target-os=none 
		--arch=x86_32 
		--enable-cross-compile
		--disable-inline-asm
		--disable-stripping
		--disable-programs
		--disable-doc
		#--extra-cflags="-s USE_PTHREADS"
		#--extra-cxxflags="-s USE_PTHREADS"
		#--extra-ldflags="-s USE_PTHREADS -s INITIAL_MEMORY=33554432"
		--nm="llvm-nm"
		--ar=emar
		--ranlib=emranlib
		--cc=emcc
		--cxx=em++
		--objcc=emcc
		--dep-cc=emcc)
	RELEASE_dk_queueShell(${EMMAKE} make)
else()
	#RELEASE_dk_queueshell		(${DKCONFIGURE_BUILD})
	#RELEASE_dk_queueshell		(../../configure --disable-x86asm)
	#RELEASE_dk_queueshell		(../../configure --pkg-config-flags=--static --disable-shared --enable-static --arch=x86 --target-os=mingw32 --cross-prefix=i686-w64-mingw32-)
	UNIX_RELEASE_dk_queueshell	(../../configure --pkg-config-flags=--static --disable-shared --enable-static --disable-x86asm --disable-iconv)
	WIN32_RELEASE_dk_queueshell	(../../configure --pkg-config-flags=--static --disable-shared --enable-static --target-os=mingw32)
	WIN64_RELEASE_dk_queueshell	(../../configure --pkg-config-flags=--static --disable-shared --enable-static --target-os=mingw64)
	RELEASE_dk_queueshell		(make)
endif()
set(USE_MSYS2 0)