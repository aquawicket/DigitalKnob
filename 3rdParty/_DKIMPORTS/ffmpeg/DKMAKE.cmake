#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://git.ffmpeg.org/ffmpeg.git
# https://trac.ffmpeg.org/wiki/CompilationGuide
# https://ffmpeg.org/platform.html#Microsoft-Visual-C_002b_002b-or-Intel-C_002b_002b-Compiler-for-Windows
# https://www.roxlu.com/2019/062/compiling-ffmpeg-with-x264-on-windows-10-using-msvc
# https://itnext.io/build-ffmpeg-webassembly-version-ffmpeg-js-part-2-compile-with-emscripten-4c581e8c9a16

#dk_set(ENABLE_dk_debugFunc 1)

### DEPENDS ###
dk_depend(core_media)
RASPBERRY_dk_depend(libatomic)
dk_depend(libgcc)
dk_depend(libmingwex)
dk_depend(secur32)
dk_depend(security)
dk_depend(video_toolbox)
dk_depend(ws2_32)
dk_depend(x264)
dk_depend(xz)
dk_depend(zlib)

#FIXME:  WIN_X86 - 9 unresolved externals

### IMPORT ###
dk_import(https://git.ffmpeg.org/ffmpeg.git)


### LINK ###
dk_include			(${FFMPEG_DIR})
DEBUG_dk_include	(${FFMPEG_CONFIG_DIR})

# libavdevice
dk_libDebug			(${FFMPEG_DEBUG_DIR}/libavdevice/libavdevice.a)
dk_libRelease		(${FFMPEG_RELEASE_DIR}/libavdevice/libavdevice.a)

# libswresample
dk_libDebug			(${FFMPEG_DEBUG_DIR}/libswresample/libswresample.a)
dk_libRelease		(${FFMPEG_RELEASE_DIR}/libswresample/libswresample.a)

# libavfilter
dk_libDebug			(${FFMPEG_DEBUG_DIR}/libavfilter/libavfilter.a)
dk_libRelease		(${FFMPEG_RELEASE_DIR}/libavfilter/libavfilter.a)

# libavutil
dk_libDebug			(${FFMPEG_DEBUG_DIR}/libavutil/libavutil.a)
dk_libRelease		(${FFMPEG_RELEASE_DIR}/libavutil/libavutil.a)

# libswscale
dk_libDebug			(${FFMPEG_DEBUG_DIR}/libswscale/libswscale.a)
dk_libRelease		(${FFMPEG_RELEASE_DIR}/libswscale/libswscale.a)

# libavcodec
dk_libDebug			(${FFMPEG_DEBUG_DIR}/libavcodec/libavcodec.a)
dk_libRelease		(${FFMPEG_RELEASE_DIR}/libavcodec/libavcodec.a)

# libavformat
dk_libDebug			(${FFMPEG_DEBUG_DIR}/libavformat/libavformat.a)
dk_libRelease		(${FFMPEG_RELEASE_DIR}/libavformat/libavformat.a)


### GENERATE / COMPILE ###
EMSCRIPTEN_DEBUG_dk_configure(${FFMPEG_DIR}
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
	--ar=${EMAR}
	--ranlib=${EMRANLIB}
	--cc=${EMCC}
	--cxx=${EMPP}
	--objcc=${EMCC}
	--dep-cc=${EMCC})
IOS_ARM32_DEBUG_dk_configure(${FFMPEG_DIR} --pkg-config-flags=--static --disable-shared --enable-static --arch=armv7 --disable-x86asm --disable-iconv)

IOS_ARM64_DEBUG_dk_configure(${FFMPEG_DIR}
	--pkg-config-flags=--static
	--disable-shared
	--enable-static
	--target-os=darwin
	--arch=arm64
	--enable-cross-compile
	--disable-programs
	--disable-doc
	--enable-pic
	--disable-x86asm
	--disable-iconv
	--cc=${XCODE_CLANG}
	--cxx=${XCODE_CLANGXX}
	--extra-cflags="-arch arm64 -DIOS -DIOS_ARM64 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOS_SYSROOT}")

IOSSIM_X86_DEBUG_dk_configure(${FFMPEG_DIR} --pkg-config-flags=--static --disable-shared --enable-static --arch=i686 --disable-x86asm --disable-iconv)

IOSSIM_X86_64_DEBUG_dk_queueCommand(${FFMPEG_DIR}
	--pkg-config-flags=--static
	--disable-shared
	--enable-static
	--arch=x86_64
	--enable-cross-compile
	--disable-programs
	--disable-doc
	--enable-pic
	--disable-x86asm
	--disable-iconv
	--cc=${XCODE_CLANG}
	--cxx=${XCODE_CLANGXX}
	--extra-cflags="-arch x86_64 -DIOS -DIOS_ARM64 -DIOSSIM -DIOSSIM_X86_64 -mios-version-min=${IOS_MIN_SDK} -isysroot ${IOSSIM_SYSROOT}")


LINUX_X86_DEBUG_dk_configure		(${FFMPEG_DIR} --pkg-config-flags=--static --disable-shared --enable-static --arch=i686 --disable-x86asm --disable-iconv)
LINUX_X86_64_DEBUG_dk_configure		(${FFMPEG_DIR} --pkg-config-flags=--static --disable-shared --enable-static --arch=x86_64 --disable-x86asm --disable-iconv)
MAC_X86_DEBUG_dk_configure			(${FFMPEG_DIR} --pkg-config-flags=--static --disable-shared --enable-static --arch=i686 --disable-x86asm --disable-iconv)
MAC_X86_64_DEBUG_dk_configure		(${FFMPEG_DIR} --pkg-config-flags=--static --disable-shared --enable-static --arch=x86_64 --disable-x86asm --disable-iconv)
RASPBERRY_ARM32_DEBUG_dk_configure	(${FFMPEG_DIR} --pkg-config-flags=--static --disable-shared --enable-static --arch=i686 --disable-x86asm --disable-iconv)
RASPBERRY_ARM64_DEBUG_dk_configure	(${FFMPEG_DIR} --pkg-config-flags=--static --disable-shared --enable-static --arch=x86_64 --disable-x86asm --disable-iconv)
WIN_X86_DEBUG_dk_configure			(${FFMPEG_DIR} --pkg-config-flags=--static --disable-shared --enable-static --disable-sdl2 --target-os=mingw32)
#WIN_X86_DEBUG_dk_configure			(${FFMPEG_DIR} --pkg-config-flags=--static --disable-shared --enable-static --toolchain=msvc) # --cc=\${MSVC_CL}
WIN_X86_64_DEBUG_dk_configure		(${FFMPEG_DIR} --pkg-config-flags=--static --disable-shared --enable-static --target-os=mingw64) # --cc=${CLANG_C_COMPILER} --cxx=${CLANG_CXX_COMPILER})


DEBUG_dk_build(${FFMPEG_DIR})






EMSCRIPTEN_RELEASE_dk_configure(${FFMPEG_DIR}
	--pkg-config-flags=--static 
	--disable-shared 
	--enable-static
	--disable-debug
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
	--ar=${EMAR}
	--ranlib=${EMRANLIB}
	--cc=${EMCC}
	--cxx=${EMPP}
	--objcc=${EMCC}
	--dep-cc=${EMCC})


IOS_ARM32_RELEASE_dk_configure		(${FFMPEG_DIR} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=arm --disable-x86asm --disable-iconv)
IOS_ARM64_RELEASE_dk_configure		(${FFMPEG_DIR} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=arm64 --disable-x86asm --disable-iconv)
IOSSIM_X86_RELEASE_dk_configure		(${FFMPEG_DIR} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=i686 --disable-x86asm --disable-iconv)
IOSSIM_X86_64_RELEASE_dk_configure	(${FFMPEG_DIR} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=x86_64 --disable-x86asm --disable-iconv)
LINUX_X86_RELEASE_dk_configure		(${FFMPEG_DIR} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=i686 --disable-x86asm --disable-iconv)
LINUX_X86_64_RELEASE_dk_configure	(${FFMPEG_DIR} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=x86_64 --disable-x86asm --disable-iconv)
MAC_X86_RELEASE_dk_configure		(${FFMPEG_DIR} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=i686 --disable-x86asm --disable-iconv)
MAC_X86_64_RELEASE_dk_configure		(${FFMPEG_DIR} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=x86_64 --disable-x86asm --disable-iconv)
RASPBERRY_ARM32_RELEASE_dk_configure(${FFMPEG_DIR} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=i686 --disable-x86asm --disable-iconv)
RASPBERRY_ARM64_RELEASE_dk_configure(${FFMPEG_DIR} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=x86_64 --disable-x86asm --disable-iconv)
WIN_X86_RELEASE_dk_configure		(${FFMPEG_DIR} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --disable-sdl2 --target-os=mingw32)
#WIN_X86_RELEASE_dk_configure		(${FFMPEG_DIR} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --toolchain=msvc)
WIN_X86_64_RELEASE_dk_configure		(${FFMPEG_DIR} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --target-os=mingw64)

RELEASE_dk_build(${FFMPEG_DIR})

