#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


dk_validate(Target_Config  "dk_Target_Config()")
# https://git.ffmpeg.org/ffmpeg.git
# https://trac.ffmpeg.org/wiki/CompilationGuide
# https://ffmpeg.org/platform.html#Microsoft-Visual-C_002b_002b-or-Intel-C_002b_002b-Compiler-for-Windows
# https://www.roxlu.com/2019/062/compiling-ffmpeg-with-x264-on-windows-10-using-msvc
# https://itnext.io/build-ffmpeg-webassembly-version-ffmpeg-js-part-2-compile-with-emscripten-4c581e8c9a16

#dk_set(ENABLE_dk_debugFunc 1)

### DEPENDS ###
dk_depend(core_media)
if(Raspberry)
	dk_depend(libatomic)
endif()
dk_depend(libgcc)
dk_depend(libmingwex)
dk_depend(secur32)
dk_depend(security)
dk_depend(video_toolbox)
dk_depend(ws2_32)
dk_depend(x264)
dk_depend(xz)
dk_depend(zlib)

#FIXME:  Windows_X86 - 9 unresolved externals

### IMPORT ###
dk_import(https://git.ffmpeg.org/ffmpeg.git)


### LINK ###
dk_include			(${FFMPEG})
Debug_dk_include	(${FFMPEG.Config_Dir})

# libavdevice
dk_libDebug			(${FFMPEG.Debug_Dir}/libavdevice/libavdevice.a)
dk_libRelease		(${FFMPEG.Release_Dir}/libavdevice/libavdevice.a)

# libswresample
dk_libDebug			(${FFMPEG.Debug_Dir}/libswresample/libswresample.a)
dk_libRelease		(${FFMPEG.Release_Dir}/libswresample/libswresample.a)

# libavfilter
dk_libDebug			(${FFMPEG.Debug_Dir}/libavfilter/libavfilter.a)
dk_libRelease		(${FFMPEG.Release_Dir}/libavfilter/libavfilter.a)

# libavutil
dk_libDebug			(${FFMPEG.Debug_Dir}/libavutil/libavutil.a)
dk_libRelease		(${FFMPEG.Release_Dir}/libavutil/libavutil.a)

# libswscale
dk_libDebug			(${FFMPEG.Debug_Dir}/libswscale/libswscale.a)
dk_libRelease		(${FFMPEG.Release_Dir}/libswscale/libswscale.a)

# libavcodec
dk_libDebug			(${FFMPEG.Debug_Dir}/libavcodec/libavcodec.a)
dk_libRelease		(${FFMPEG.Release_Dir}/libavcodec/libavcodec.a)

# libavformat
dk_libDebug			(${FFMPEG.Debug_Dir}/libavformat/libavformat.a)
dk_libRelease		(${FFMPEG.Release_Dir}/libavformat/libavformat.a)


### GENERATE / COMPILE ###
Emscripten_Debug_dk_configure(${FFMPEG}
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
Ios_ARM32_Debug_dk_configure(${FFMPEG} --pkg-config-flags=--static --disable-shared --enable-static --arch=armv7 --disable-x86asm --disable-iconv)

Ios_ARM64_Debug_dk_configure(${FFMPEG}
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

Iossim_X86_Debug_dk_configure(${FFMPEG} --pkg-config-flags=--static --disable-shared --enable-static --arch=i686 --disable-x86asm --disable-iconv)

Iossim_X86_64_Debug_dk_exec(${FFMPEG}
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


Linux_X86_Debug_dk_configure		(${FFMPEG} --pkg-config-flags=--static --disable-shared --enable-static --arch=i686 --disable-x86asm --disable-iconv)
Linux_X86_64_Debug_dk_configure		(${FFMPEG} --pkg-config-flags=--static --disable-shared --enable-static --arch=x86_64 --disable-x86asm --disable-iconv)
Mac_X86_Debug_dk_configure			(${FFMPEG} --pkg-config-flags=--static --disable-shared --enable-static --arch=i686 --disable-x86asm --disable-iconv)
Mac_X86_64_Debug_dk_configure		(${FFMPEG} --pkg-config-flags=--static --disable-shared --enable-static --arch=x86_64 --disable-x86asm --disable-iconv)
Raspberry_Arm32_Debug_dk_configure	(${FFMPEG} --pkg-config-flags=--static --disable-shared --enable-static --arch=i686 --disable-x86asm --disable-iconv)
Raspberry_Arm64_Debug_dk_configure	(${FFMPEG} --pkg-config-flags=--static --disable-shared --enable-static --arch=x86_64 --disable-x86asm --disable-iconv)
Windows_X86_Debug_dk_configure			(${FFMPEG} --pkg-config-flags=--static --disable-shared --enable-static --disable-sdl2 --target-os=mingw32)
#Windows_X86_Debug_dk_configure			(${FFMPEG} --pkg-config-flags=--static --disable-shared --enable-static --toolchain=msvc) # --cc=\${MSVC_CL}
Windows_X86_64_Debug_dk_configure		(${FFMPEG} --pkg-config-flags=--static --disable-shared --enable-static --target-os=mingw64) # --cc=${CLANG_C_COMPILER} --cxx=${CLANG_CXX_COMPILER})


if(Debug)
	dk_build()
endif()





Emscripten_Release_dk_configure(${FFMPEG}
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


Ios_Arm32_Release_dk_configure		(${FFMPEG} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=arm --disable-x86asm --disable-iconv)
Ios_Arm64_Release_dk_configure		(${FFMPEG} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=arm64 --disable-x86asm --disable-iconv)
Iossim_X86_Release_dk_configure		(${FFMPEG} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=i686 --disable-x86asm --disable-iconv)
Iossim_X86_64_Release_dk_configure	(${FFMPEG} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=x86_64 --disable-x86asm --disable-iconv)
Linux_X86_Release_dk_configure		(${FFMPEG} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=i686 --disable-x86asm --disable-iconv)
Linux_X86_64_Release_dk_configure	(${FFMPEG} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=x86_64 --disable-x86asm --disable-iconv)
Mac_X86_Release_dk_configure		(${FFMPEG} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=i686 --disable-x86asm --disable-iconv)
Mac_X86_64_Release_dk_configure		(${FFMPEG} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=x86_64 --disable-x86asm --disable-iconv)
Raspberry_Arm32_Release_dk_configure(${FFMPEG} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=i686 --disable-x86asm --disable-iconv)
Raspberry_Arm64_Release_dk_configure(${FFMPEG} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=x86_64 --disable-x86asm --disable-iconv)
Windows_X86_Release_dk_configure	(${FFMPEG} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --disable-sdl2 --target-os=mingw32)
#Windows_X86_Release_dk_configure	(${FFMPEG} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --toolchain=msvc)
Windows_X86_64_Release_dk_configure	(${FFMPEG} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --target-os=mingw64)



if(Release)
	dk_build()
endif()

