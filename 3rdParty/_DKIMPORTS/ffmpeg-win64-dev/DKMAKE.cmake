# https://web.archive.org/web/20200918193155/https://ffmpeg.zeranoe.com/builds/win64/dev/ffmpeg-20200831-4a11a6f-win64-dev.zip

### VERSION ###
DKSET(FFMPEG_VERSION 20200831-4a11a6f)
DKSET(FFMPEG_NAME ffmpeg-${FFMPEG_VERSION}-win64-dev)
DKSET(FFMPEG_DL https://web.archive.org/web/20200918193140/https://ffmpeg.zeranoe.com/builds/win64/dev/${FFMPEG_NAME}.zip)
DKSET(FFMPEG ${3RDPARTY}/${FFMPEG_NAME})

### INSTALL ###
DKINSTALL(${FFMPEG_DL} ffmpeg-win64-dev ${FFMPEG})
DKRENAME(${FFMPEG}/include/libavutil/time.h ${FFMPEG}/include/libavutil/time.h.EXCLUDE)


### LINK ###
DKDEFINE(__STDC_CONSTANT_MACROS)
WIN64_INCLUDE(${FFMPEG})
WIN64_INCLUDE(${FFMPEG}/include)
WIN64_INCLUDE(${FFMPEG}/include/libavcodec)
WIN64_INCLUDE(${FFMPEG}/include/libavdevice)
WIN64_INCLUDE(${FFMPEG}/include/libavfilter)
WIN64_INCLUDE(${FFMPEG}/include/libavformat)
WIN64_INCLUDE(${FFMPEG}/include/libavutil)
WIN64_INCLUDE(${FFMPEG}/include/libswresample)
WIN64_INCLUDE(${FFMPEG}/include/libswscale)
WIN64_DEBUG_LIB(${FFMPEG}/lib/avcodec.lib)
WIN64_RELEASE_LIB(${FFMPEG}/lib/avcodec.lib)
WIN64_DEBUG_LIB(${FFMPEG}/lib/avdevice.lib)
WIN64_RELEASE_LIB(${FFMPEG}/lib/avdevice.lib)
WIN64_DEBUG_LIB(${FFMPEG}/lib/avfilter.lib)
WIN64_RELEASE_LIB(${FFMPEG}/lib/avfilter.lib)
WIN64_DEBUG_LIB(${FFMPEG}/lib/avformat.lib)
WIN64_RELEASE_LIB(${FFMPEG}/lib/avformat.lib)
WIN64_DEBUG_LIB(${FFMPEG}/lib/avutil.lib)
WIN64_RELEASE_LIB(${FFMPEG}/lib/avutil.lib)
WIN64_DEBUG_LIB(${FFMPEG}/lib/swresample.lib)
WIN64_RELEASE_LIB(${FFMPEG}/lib/swresample.lib)
WIN64_DEBUG_LIB(${FFMPEG}/lib/swscale.lib)
WIN64_RELEASE_LIB(${FFMPEG}/lib/swscale.lib)