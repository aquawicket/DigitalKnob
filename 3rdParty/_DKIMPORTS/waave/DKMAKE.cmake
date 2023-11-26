# https://sourceforge.net/projects/waave
# https://sourceforge.net/projects/waave/files/waave/waave-3.01.tar.gz


### DEPEND ###
dk_depend(ffmpeg)
dk_depend(sdl)


### IMPORT ###
dk_import(https://sourceforge.net/projects/waave/files/waave/waave-3.01.tar.gz PATCH)
#dk_import(git://git.code.sf.net/p/waave/code)


### LINK ###
dk_include			(${WAAVE}/src)
UNIX_dk_libDebug	(${WAAVE}/${OS}/${DEBUG_DIR}/libwaave.a)
UNIX_dk_libRelease	(${WAAVE}/${OS}/${RELEASE_DIR}/libwaave.a)
WIN_dk_libDebug		(${WAAVE}/${OS}/${DEBUG_DIR}/waave.lib)
WIN_dk_libRelease	(${WAAVE}/${OS}/${RELEASE_DIR}/waave.lib)


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} ${FFMPEG-DEV_CMAKE} ${SDL_CMAKE} ${WAAVE})


### COMPILE ###
dk_build(${WAAVE} waave)
