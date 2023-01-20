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
UNIX_dk_libDebug	(${FFMPEG}/${OS}/${DEBUG_DIR}/libavcodec.a)
UNIX_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libavcodec.a)
WIN_dk_libDebug		(${FFMPEG}/${OS}/${DEBUG_DIR}/avcodec.lib)
WIN_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/avcodec.lib)

# avdevice
UNIX_dk_libDebug	(${FFMPEG}/${OS}/${DEBUG_DIR}/libavdevice.a)
UNIX_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libavdevice.a)
WIN_dk_libDebug		(${FFMPEG}/${OS}/${DEBUG_DIR}/avdevice.lib)
WIN_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/avdevice.lib)

# avfilter
UNIX_dk_libDebug	(${FFMPEG}/${OS}/${DEBUG_DIR}/libavfilter.a)
UNIX_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libavfilter.a)
WIN_dk_libDebug		(${FFMPEG}/${OS}/${DEBUG_DIR}/avfilter.lib)
WIN_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/avfilter.lib)

# avformat
UNIX_dk_libDebug	(${FFMPEG}/${OS}/${DEBUG_DIR}/libavformat.a)
UNIX_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libavformat.a)
WIN_dk_libDebug		(${FFMPEG}/${OS}/${DEBUG_DIR}/avformat.lib)
WIN_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/avformat.lib)

# avutil
UNIX_dk_libDebug	(${FFMPEG}/${OS}/${DEBUG_DIR}/libavutil.a)
UNIX_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libavutil.a)
WIN_dk_libDebug		(${FFMPEG}/${OS}/${DEBUG_DIR}/avutil.lib)
WIN_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/avutil.lib)

# swresample
UNIX_dk_libDebug	(${FFMPEG}/${OS}/${DEBUG_DIR}/libswresample.a)
UNIX_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libswresample.a)
WIN_dk_libDebug		(${FFMPEG}/${OS}/${DEBUG_DIR}/swresample.lib)
WIN_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/swresample.lib)

# swscale
UNIX_dk_libDebug	(${FFMPEG}/${OS}/${DEBUG_DIR}/libswscale.a)
UNIX_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libswscale.a)
WIN_dk_libDebug		(${FFMPEG}/${OS}/${DEBUG_DIR}/swscale.lib)
WIN_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/swscale.lib)


### GENERATE / COMPILE ###
DEBUG_dk_setPath		(${FFMPEG}/${OS}/${DEBUG_DIR})
#DEBUG_dk_queueshell	(${DKCONFIGURE_BUILD})
DEBUG_dk_queueshell		(../../configure --disable-x86asm)
DEBUG_dk_queueshell		(make)
RELEASE_dk_setPath		(${FFMPEG}/${OS}/${RELEASE_DIR})
#RELEASE_dk_queueshell	(${DKCONFIGURE_BUILD})
RELEASE_dk_queueshell	(../../configure --disable-x86asm)
RELEASE_dk_queueshell	(make)
