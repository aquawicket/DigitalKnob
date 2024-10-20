include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
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
UNIX_dk_libDebug	(${WAAVE}/${triple}/${DEBUG_DIR}/libwaave.a)
UNIX_dk_libRelease	(${WAAVE}/${triple}/${RELEASE_DIR}/libwaave.a)
WIN_dk_libDebug		(${WAAVE}/${triple}/${DEBUG_DIR}/waave.lib)
WIN_dk_libRelease	(${WAAVE}/${triple}/${RELEASE_DIR}/waave.lib)


### GENERATE ###
dk_configure(${WAAVE} ${FFMPEG-DEV_CMAKE} ${SDL_CMAKE})


### COMPILE ###
dk_build(${WAAVE} waave)
