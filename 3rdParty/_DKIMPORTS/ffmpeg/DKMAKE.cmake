# https://git.ffmpeg.org/ffmpeg.git
# https://trac.ffmpeg.org/wiki/CompilationGuide
# https://www.roxlu.com/2019/062/compiling-ffmpeg-with-x264-on-windows-10-using-msvc


### DEPENDS ###
dk_depend(x264)


### IMPORT ###
dk_import(https://git.ffmpeg.org/ffmpeg.git)


### LINK ###
dk_include			(${FFMPEG}/src)
UNIX_dk_libDebug	(${FFMPEG}/${OS}/${DEBUG_DIR}/libffmpeg.a)
UNIX_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/libffmpeg.a)
WIN_dk_libDebug		(${FFMPEG}/${OS}/${DEBUG_DIR}/ffmpeg.lib)
WIN_dk_libRelease	(${FFMPEG}/${OS}/${RELEASE_DIR}/ffmpeg.lib)


### GENERATE / COMPILE ###
DEBUG_dk_setPath		(${FFMPEG}/${OS}/${DEBUG_DIR})
DEBUG_dk_queueshell		(${DKCONFIGURE_BUILD})
DEBUG_dk_queueshell		(make)
RELEASE_dk_setPath		(${FFMPEG}/${OS}/${RELEASE_DIR})
RELEASE_dk_queueshell	(${DKCONFIGURE_BUILD})
RELEASE_dk_queueshell	(make)
