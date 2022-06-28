# https://web.archive.org/web/20200918193140/https://ffmpeg.zeranoe.com/builds/win32/dev/ffmpeg-20200831-4a11a6f-win32-dev.zip
# https://web.archive.org/web/20200914204045/https://ffmpeg.zeranoe.com/builds/win64/dev/ffmpeg-20200831-4a11a6f-win64-dev.zip

### VERSION ###
dk_set(FFMPEG_VERSION 20200831-4a11a6f)
dk_set(FFMPEG_NAME ffmpeg-${FFMPEG_VERSION}-${OS}-dev)
dk_set(FFMPEG_DL https://web.archive.org/web/20200918193140/https://ffmpeg.zeranoe.com/builds/${OS}/dev/${FFMPEG_NAME}.zip)
dk_set(FFMPEG ${3RDPARTY}/${FFMPEG_NAME})

### INSTALL ###
#dk_import(${FFMPEG_DL} ${FFMPEG})
dk_import(${FFMPEG_DL} ${FFMPEG})
dk_rename(${FFMPEG}/include/libavutil/time.h ${FFMPEG}/include/libavutil/time.h.EXCLUDE)


### LINK ###
dk_define(__STDC_CONSTANT_MACROS)
WIN32_INCLUDE(${FFMPEG})
WIN32_INCLUDE(${FFMPEG}/include)
WIN32_INCLUDE(${FFMPEG}/include/libavcodec)
WIN32_INCLUDE(${FFMPEG}/include/libavdevice)
WIN32_INCLUDE(${FFMPEG}/include/libavfilter)
WIN32_INCLUDE(${FFMPEG}/include/libavformat)
WIN32_INCLUDE(${FFMPEG}/include/libavutil)
WIN32_INCLUDE(${FFMPEG}/include/libswresample)
WIN32_INCLUDE(${FFMPEG}/include/libswscale)
WIN32_dk_libDebug(${FFMPEG}/lib/avcodec.lib)
WIN32_dk_libRelease(${FFMPEG}/lib/avcodec.lib)
WIN32_dk_libDebug(${FFMPEG}/lib/avdevice.lib)
WIN32_dk_libRelease(${FFMPEG}/lib/avdevice.lib)
WIN32_dk_libDebug(${FFMPEG}/lib/avfilter.lib)
WIN32_dk_libRelease(${FFMPEG}/lib/avfilter.lib)
WIN32_dk_libDebug(${FFMPEG}/lib/avformat.lib)
WIN32_dk_libRelease(${FFMPEG}/lib/avformat.lib)
WIN32_dk_libDebug(${FFMPEG}/lib/avutil.lib)
WIN32_dk_libRelease(${FFMPEG}/lib/avutil.lib)
WIN32_dk_libDebug(${FFMPEG}/lib/swresample.lib)
WIN32_dk_libRelease(${FFMPEG}/lib/swresample.lib)
WIN32_dk_libDebug(${FFMPEG}/lib/swscale.lib)
WIN32_dk_libRelease(${FFMPEG}/lib/swscale.lib)


### COMPILE ###
WIN32_dk_queueCommand(call C:/Windows/System32/cmd.exe /K ${VISUALSTUDIO}/VC/vcvarsall.bat amd64)
WIN32_dk_queueCommand(${VISUALSTUDIO}/VC/bin/amd64_x86/lib.exe /machine:i386 /def:${FFMPEG}/lib/avcodec-56.def /out:${FFMPEG}/lib/avcodec.lib & 
${VC2013}/VC/bin/amd64_x86/lib.exe /machine:i386 /def:${FFMPEG}/lib/avdevice-56.def /out:${FFMPEG}/lib/avdevice.lib & 
${VC2013}/VC/bin/amd64_x86/lib.exe /machine:i386 /def:${FFMPEG}/lib/avfilter-5.def /out:${FFMPEG}/lib/avfilter.lib & 
${VC2013}/VC/bin/amd64_x86/lib.exe /machine:i386 /def:${FFMPEG}/avformat-56.def /out:${FFMPEG}/lib/avformat.lib & 
${VC2013}/VC/bin/amd64_x86/lib.exe /machine:i386 /def:${FFMPEG}/lib/avutil-54.def /out:${FFMPEG}/lib/avutil.lib & 
${VC2013}/VC/bin/amd64_x86/lib.exe /machine:i386 /def:${FFMPEG}/lib/postproc-53.def /out:${FFMPEG}/lib/postproc.lib & 
${VC2013}/VC/bin/amd64_x86/lib.exe /machine:i386 /def:${FFMPEG}/lib/swresample-1.def /out:${FFMPEG}/lib/swresample.lib & 
${VC2013}/VC/bin/amd64_x86/lib.exe /machine:i386 /def:${FFMPEG}/lib/swscale-3.def /out:${FFMPEG}/lib/swscale.lib & exit)