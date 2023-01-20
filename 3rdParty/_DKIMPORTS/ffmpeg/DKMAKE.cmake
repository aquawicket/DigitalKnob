# https://git.ffmpeg.org/ffmpeg.git
# https://trac.ffmpeg.org/wiki/CompilationGuide
# https://www.roxlu.com/2019/062/compiling-ffmpeg-with-x264-on-windows-10-using-msvc


### DEPENDS ###
dk_depend(x264)


### IMPORT ###
dk_import(https://git.ffmpeg.org/ffmpeg.git)


### LINK ###
dk_include			(${FFMPEG}/src)

# avcodec
UNIX_dk_libDebug	(${FFMPEG}/${OS}/${DEBUG_DIR}/libavcodec/libavcodec.a)
UNIX_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libavcodec/libavcodec.a)
WIN_dk_libDebug		(${FFMPEG}/${OS}/${DEBUG_DIR}/libavcodec/avcodec.lib)
WIN_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libavcodec/avcodec.lib)

# avdevice
UNIX_dk_libDebug	(${FFMPEG}/${OS}/${DEBUG_DIR}/libavdevice/libavdevice.a)
UNIX_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libavdevice/libavdevice.a)
WIN_dk_libDebug		(${FFMPEG}/${OS}/${DEBUG_DIR}/libavdevice/avdevice.lib)
WIN_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libavdevice/avdevice.lib)

# avfilter
UNIX_dk_libDebug	(${FFMPEG}/${OS}/${DEBUG_DIR}/libavfilter/libavfilter.a)
UNIX_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libavfilter/libavfilter.a)
WIN_dk_libDebug		(${FFMPEG}/${OS}/${DEBUG_DIR}/libavfilter/avfilter.lib)
WIN_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libavfilter/avfilter.lib)

# avformat
UNIX_dk_libDebug	(${FFMPEG}/${OS}/${DEBUG_DIR}/libavformat/libavformat.a)
UNIX_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libavformat/libavformat.a)
WIN_dk_libDebug		(${FFMPEG}/${OS}/${DEBUG_DIR}/libavformat/avformat.lib)
WIN_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libavformat/avformat.lib)

# avutil
UNIX_dk_libDebug	(${FFMPEG}/${OS}/${DEBUG_DIR}/libavutil/libavutil.a)
UNIX_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libavutil/libavutil.a)
WIN_dk_libDebug		(${FFMPEG}/${OS}/${DEBUG_DIR}/libavutil/avutil.lib)
WIN_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libavutil/avutil.lib)

# swresample
UNIX_dk_libDebug	(${FFMPEG}/${OS}/${DEBUG_DIR}/libswresample/libswresample.a)
UNIX_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libswresample/libswresample.a)
WIN_dk_libDebug		(${FFMPEG}/${OS}/${DEBUG_DIR}/libswresample/swresample.lib)
WIN_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libswresample/swresample.lib)

# swscale
UNIX_dk_libDebug	(${FFMPEG}/${OS}/${DEBUG_DIR}/libswscale/libswscale.a)
UNIX_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libswscale/libswscale.a)
WIN_dk_libDebug		(${FFMPEG}/${OS}/${DEBUG_DIR}/libswscale/swscale.lib)
WIN_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libswscale/swscale.lib)


### GENERATE / COMPILE ###
DEBUG_dk_setPath		(${FFMPEG}/${OS}/${DEBUG_DIR})
#DEBUG_dk_queueshell	(${DKCONFIGURE_BUILD})
DEBUG_dk_queueshell		(../../configure --disable-x86asm)
DEBUG_dk_queueshell		(make)
RELEASE_dk_setPath		(${FFMPEG}/${OS}/${RELEASE_DIR})
#RELEASE_dk_queueshell	(${DKCONFIGURE_BUILD})
RELEASE_dk_queueshell	(../../configure --disable-x86asm)
RELEASE_dk_queueshell	(make)
