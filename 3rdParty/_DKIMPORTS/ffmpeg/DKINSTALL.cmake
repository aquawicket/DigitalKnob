#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ ffmpeg ############
# https://git.ffmpeg.org/ffmpeg.git
# https://trac.ffmpeg.org/wiki/CompilationGuide
# https://ffmpeg.org/platform.html#Microsoft-Visual-C_002b_002b-or-Intel-C_002b_002b-Compiler-for-Windows
# https://www.roxlu.com/2019/062/compiling-ffmpeg-with-x264-on-windows-10-using-msvc
# https://itnext.io/build-ffmpeg-webassembly-version-ffmpeg-js-part-2-compile-with-emscripten-4c581e8c9a16
# https://github.com/FFmpeg/FFmpeg/archive/0bc54cddb1050c3c55bc65adbd3c8aa90d7eb457.zip
# https://ffmpeg.org/releases/ffmpeg-8.0.tar.xz

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

dk_import()


dk_include			(${ffmpeg})
dk_include			(${ffmpeg_Config_Dir})

# libavdevice
dk_libDebug			(${ffmpeg_Debug_Dir}/libavdevice/libavdevice.a)
dk_libRelease		(${ffmpeg_Release_Dir}/libavdevice/libavdevice.a)

# libswresample
dk_libDebug			(${ffmpeg_Debug_Dir}/libswresample/libswresample.a)
dk_libRelease		(${ffmpeg_Release_Dir}/libswresample/libswresample.a)

# libavfilter
dk_libDebug			(${ffmpeg_Debug_Dir}/libavfilter/libavfilter.a)
dk_libRelease		(${ffmpeg_Release_Dir}/libavfilter/libavfilter.a)

# libavutil
dk_libDebug			(${ffmpeg_Debug_Dir}/libavutil/libavutil.a)
dk_libRelease		(${ffmpeg_Release_Dir}/libavutil/libavutil.a)

# libswscale
dk_libDebug			(${ffmpeg_Debug_Dir}/libswscale/libswscale.a)
dk_libRelease		(${ffmpeg_Release_Dir}/libswscale/libswscale.a)

# libavcodec
dk_libDebug			(${ffmpeg_Debug_Dir}/libavcodec/libavcodec.a)
dk_libRelease		(${ffmpeg_Release_Dir}/libavcodec/libavcodec.a)

# libavformat
dk_libDebug			(${ffmpeg_Debug_Dir}/libavformat/libavformat.a)
dk_libRelease		(${ffmpeg_Release_Dir}/libavformat/libavformat.a)


if(Emscripten_Debug)
	dk_configure(${ffmpeg}
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
	
elseif(Ios_Arm32_Debug)
	dk_configure(${ffmpeg} --pkg-config-flags=--static --disable-shared --enable-static --arch=armv7 --disable-x86asm --disable-iconv)
	
elseif(Ios_Arm64_Debug)
	dk_configure(${ffmpeg}
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
		
elseif(Iossim_X86_Debug)
	dk_configure(${ffmpeg} --pkg-config-flags=--static --disable-shared --enable-static --arch=i686 --disable-x86asm --disable-iconv)
	
elseif(Iossim_X86_64_Debug)
	dk_exec(${ffmpeg}
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
		
elseif(Linux_X86_Debug)
	dk_configure(${ffmpeg} --pkg-config-flags=--static --disable-shared --enable-static --arch=i686 --disable-x86asm --disable-iconv)
	
elseif(Linux_X86_64_Debug)
	dk_configure(${ffmpeg} --pkg-config-flags=--static --disable-shared --enable-static --arch=x86_64 --disable-x86asm --disable-iconv)
	
elseif(Mac_X86_Debug)
	dk_configure(${ffmpeg} --pkg-config-flags=--static --disable-shared --enable-static --arch=i686 --disable-x86asm --disable-iconv)
	
elseif(Mac_X86_64_Debug)
	dk_configure(${ffmpeg} --pkg-config-flags=--static --disable-shared --enable-static --arch=x86_64 --disable-x86asm --disable-iconv)
	
elseif(Raspberry_Arm32_Debug)
	dk_configure(${ffmpeg} --pkg-config-flags=--static --disable-shared --enable-static --arch=i686 --disable-x86asm --disable-iconv)
	
elseif(Raspberry_Arm64_Debug)
	dk_configure(${ffmpeg} --pkg-config-flags=--static --disable-shared --enable-static --arch=x86_64 --disable-x86asm --disable-iconv)
	
elseif(Windows_X86_Debug)
	dk_configure(${ffmpeg} --pkg-config-flags=--static --disable-shared --enable-static --disable-sdl2 --target-os=mingw32)
	
#elseif(Windows_X86_Debug)
#	dk_configure(${ffmpeg} --pkg-config-flags=--static --disable-shared --enable-static --toolchain=msvc) # --cc=\${MSVC_CL}

elseif(Windows_X86_64_Debug)
	dk_configure(${ffmpeg} --pkg-config-flags=--static --disable-shared --enable-static --target-os=mingw64) # --cc=${clang_exe} --cxx=${clang++_exe})
	
endif()




if(Emscripten_Release)
	dk_configure(${ffmpeg}
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

elseif(Ios_Arm32_Release)
	dk_configure(${ffmpeg} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=arm --disable-x86asm --disable-iconv)

elseif(Ios_Arm64_Release)
	dk_configure(${ffmpeg} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=arm64 --disable-x86asm --disable-iconv)

elseif(Iossim_X86_Release)
	dk_configure(${ffmpeg} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=i686 --disable-x86asm --disable-iconv)

elseif(Iossim_X86_64_Release)
	dk_configure(${ffmpeg} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=x86_64 --disable-x86asm --disable-iconv)

elseif(Linux_X86_Release)
	dk_configure(${ffmpeg} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=i686 --disable-x86asm --disable-iconv)

elseif(Linux_X86_64_Release)
	dk_configure(${ffmpeg} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=x86_64 --disable-x86asm --disable-iconv)

elseif(Mac_X86_Release)
	dk_configure(${ffmpeg} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=i686 --disable-x86asm --disable-iconv)

elseif(Mac_X86_64_Release)
	dk_configure(${ffmpeg} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=x86_64 --disable-x86asm --disable-iconv)

elseif(Raspberry_Arm32_Release)
	dk_configure(${ffmpeg} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=i686 --disable-x86asm --disable-iconv)

elseif(Raspberry_Arm64_Release)
	dk_configure(${ffmpeg} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --arch=x86_64 --disable-x86asm --disable-iconv)

elseif(Windows_X86_Release)
	dk_configure(${ffmpeg} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --disable-sdl2 --target-os=mingw32)

#elseif(Windows_X86_Release)
#	dk_configure	(${ffmpeg} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --toolchain=msvc)

elseif(Windows_X86_64_Release)
	dk_configure	(${ffmpeg} --pkg-config-flags=--static --disable-shared --enable-static --disable-debug --target-os=mingw64)
	
endif()



dk_build()
