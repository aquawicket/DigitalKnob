include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/thestk/rtaudio


### DEPEND ###
WIN_dk_depend(winmm)


### IMPORT ###
#dk_import(https://github.com/thestk/rtaudio.git)
dk_import(https://github.com/thestk/rtaudio/archive/refs/heads/master.zip)


### LINK ###
APPLE_dk_define			(__MACOSX_CORE__)
if(LINUX OR RASPBERRY OR ANDROID)
	dk_define			(__LINUX_ALSA__)
endif()
dk_include				(${RTAUDIO})
UNIX_dk_libDebug		(${RTAUDIO}/${triple}/${DEBUG_DIR}/librtaudio.a)
UNIX_dk_libRelease		(${RTAUDIO}/${triple}/${RELEASE_DIR}/librtaudio.a)
WIN_dk_libDebug			(${RTAUDIO}/${triple}/${DEBUG_DIR}/rtaudiod.lib)
WIN_dk_libRelease		(${RTAUDIO}/${triple}/${RELEASE_DIR}/rtaudio.lib)


### GENERATE ###
dk_configure(${RTAUDIO})


### COMPILE ###
dk_build(${RTAUDIO} rtaudio)
