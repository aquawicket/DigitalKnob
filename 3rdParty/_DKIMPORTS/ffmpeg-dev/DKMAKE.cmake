# https://web.archive.org/web/20200919011114/https://ffmpeg.zeranoe.com/builds/
# https://web.archive.org/web/20200918193140/https://ffmpeg.zeranoe.com/builds/win32/dev/ffmpeg-20200831-4a11a6f-win32-dev.zip
# https://web.archive.org/web/20200914204045/https://ffmpeg.zeranoe.com/builds/win64/dev/ffmpeg-20200831-4a11a6f-win64-dev.zip
# https://web.archive.org/web/20200919011114mp_/https://ffmpeg.zeranoe.com/builds/macos64/dev/ffmpeg-20200831-4a11a6f-macos64-dev.zip

if(NOT WIN AND NOT MAC)
	return()
endif()


dk_depend(visualstudio)


WIN32_dk_import(https://web.archive.org/web/20200918193140/https://ffmpeg.zeranoe.com/builds/win32/dev/ffmpeg-20200831-4a11a6f-win32-dev.zip)
WIN64_dk_import(https://web.archive.org/web/20200914204045/https://ffmpeg.zeranoe.com/builds/win64/dev/ffmpeg-20200831-4a11a6f-win64-dev.zip)
MAC64_dk_import(https://web.archive.org/web/20200919011114mp_/https://ffmpeg.zeranoe.com/builds/macos64/dev/ffmpeg-20200831-4a11a6f-macos64-dev.zip)


dk_rename(${FFMPEG-DEV}/include/libavutil/time.h ${FFMPEG-DEV}/include/libavutil/time.h.EXCLUDE)


### LINK ###
dk_define(__STDC_CONSTANT_MACROS)
dk_include(${FFMPEG-DEV})
dk_include(${FFMPEG-DEV}/include)
dk_include(${FFMPEG-DEV}/include/libavcodec)
dk_include(${FFMPEG-DEV}/include/libavdevice)
dk_include(${FFMPEG-DEV}/include/libavfilter)
dk_include(${FFMPEG-DEV}/include/libavformat)
dk_include(${FFMPEG-DEV}/include/libavutil)
dk_include(${FFMPEG-DEV}/include/libswresample)
dk_include(${FFMPEG-DEV}/include/libswscale)
WIN_dk_libDebug(${FFMPEG-DEV}/lib/avcodec.lib)
WIN_dk_libDebug(${FFMPEG-DEV}/lib/avdevice.lib)
WIN_dk_libDebug(${FFMPEG-DEV}/lib/avfilter.lib)
WIN_dk_libDebug(${FFMPEG-DEV}/lib/avformat.lib)
WIN_dk_libDebug(${FFMPEG-DEV}/lib/avutil.lib)
WIN_dk_libDebug(${FFMPEG-DEV}/lib/swresample.lib)
WIN_dk_libDebug(${FFMPEG-DEV}/lib/swscale.lib)
WIN_dk_libRelease(${FFMPEG-DEV}/lib/avcodec.lib)
WIN_dk_libRelease(${FFMPEG-DEV}/lib/avdevice.lib)
WIN_dk_libRelease(${FFMPEG-DEV}/lib/avfilter.lib)
WIN_dk_libRelease(${FFMPEG-DEV}/lib/avformat.lib)
WIN_dk_libRelease(${FFMPEG-DEV}/lib/avutil.lib)
WIN_dk_libRelease(${FFMPEG-DEV}/lib/swresample.lib)
WIN_dk_libRelease(${FFMPEG-DEV}/lib/swscale.lib)


### 3RDPARTY LINK ###
UNIX_dk_set	(FFMPEG-DEV_CMAKE "-DCMAKE_C_FLAGS=-I${FFMPEG-DEV}/include" "-DCMAKE_CXX_FLAGS=-I${FFMPEG-DEV}/include" -DFFMPEG_INCLUDE_DIR=${FFMPEG-DEV})
WIN_dk_set	(FFMPEG-DEV_CMAKE "-DCMAKE_C_FLAGS=/I${FFMPEG-DEV}/include" "-DCMAKE_CXX_FLAGS=/I${FFMPEG-DEV}/include" -DFFMPEG_INCLUDE_DIR=${FFMPEG-DEV})


### COMPILE ###
WIN_dk_queueCommand(call C:/Windows/System32/cmd.exe /K ${VISUALSTUDIO}/VC/vcvarsall.bat amd64)
WIN_dk_queueCommand(${VISUALSTUDIO}/VC/bin/amd64_x86/lib.exe /machine:i386 /def:${FFMPEG-DEV}/lib/avcodec-56.def /out:${FFMPEG-DEV}/lib/avcodec.lib & 
	${VC2013}/VC/bin/amd64_x86/lib.exe /machine:i386 /def:${FFMPEG-DEV}/lib/avdevice-56.def /out:${FFMPEG-DEV}/lib/avdevice.lib & 
	${VC2013}/VC/bin/amd64_x86/lib.exe /machine:i386 /def:${FFMPEG-DEV}/lib/avfilter-5.def /out:${FFMPEG-DEV}/lib/avfilter.lib & 
	${VC2013}/VC/bin/amd64_x86/lib.exe /machine:i386 /def:${FFMPEG-DEV}/avformat-56.def /out:${FFMPEG-DEV}/lib/avformat.lib & 
	${VC2013}/VC/bin/amd64_x86/lib.exe /machine:i386 /def:${FFMPEG-DEV}/lib/avutil-54.def /out:${FFMPEG-DEV}/lib/avutil.lib & 
	${VC2013}/VC/bin/amd64_x86/lib.exe /machine:i386 /def:${FFMPEG-DEV}/lib/postproc-53.def /out:${FFMPEG-DEV}/lib/postproc.lib & 
	${VC2013}/VC/bin/amd64_x86/lib.exe /machine:i386 /def:${FFMPEG-DEV}/lib/swresample-1.def /out:${FFMPEG-DEV}/lib/swresample.lib & 
	${VC2013}/VC/bin/amd64_x86/lib.exe /machine:i386 /def:${FFMPEG-DEV}/lib/swscale-3.def /out:${FFMPEG-DEV}/lib/swscale.lib & exit)
	