# https://github.com/emscripten-core/emsdk.git
# https://emscripten.org/index.html
# https://lyceum-allotments.github.io/2016/06/emscripten-and-sdl-2-tutorial-part-1/
# https://github.com/emscripten-core/emsdk/archive/refs/tags/2.0.26.zip

dk_depend(python)


#dk_import(https://github.com/emscripten-core/emsdk/archive/refs/tags/3.1.31.zip)
dk_import(https://github.com/emscripten-core/emsdk.git BRANCH main)


WIN_HOST_dk_command(${EMSDK}/emsdk.bat install latest)
UNIX_HOST_dk_command(${EMSDK}/emsdk.sh install latest)

WIN_HOST_dk_command(${EMSDK}/emsdk.bat activate latest --permanent)
UNIX_HOST_dk_command(chmod 777 ${EMSDK}/emsdk_env.sh)
UNIX_HOST_dk_command(${EMSDK}/emsdk.sh activate latest --permanent)

WIN_HOST_dk_command(${EMSDK}/emsdk_env.bat)
UNIX_HOST_dk_command(${EMSDK}/emsdk_env.sh)

WIN_HOST_dk_command(${EMSDK}/emsdk.bat install mingw-4.6.2-32bit)
UNIX_HOST_dk_command(${EMSDK}/emsdk.sh install mingw-4.6.2-32bit)

WIN_HOST_dk_command(${EMSDK}/emsdk.bat activate mingw-4.6.2-32bit)
UNIX_HOST_dk_command(${EMSDK}/emsdk.sh activate mingw-4.6.2-32bit)


dkFileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL = 0;" 		"var USE_SDL = false;"			NOERROR)
dkFileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL_IMAGE = 1;" 	"var USE_SDL_IMAGE = false;"	NOERROR)
dkFileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL_TTF = 1;" 	"var USE_SDL_TTF = false;"		NOERROR)
dkFileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL_NET = 1;" 	"var USE_SDL_NET = false;"		NOERROR)
dkFileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL_MIXER = 1;" 	"var USE_SDL_MIXER = false;"	NOERROR)
dkFileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_PTHREADS = false;" "var USE_PTHREADS = true;"		NOERROR)


WIN_HOST_dk_set	(EMSDK_ENV ${EMSDK}/emsdk_env.bat)
UNIX_HOST_dk_set(EMSDK_ENV ${EMSDK}/emsdk_env.sh)
dk_set			(EMSDK_TOOLCHAIN_FILE ${EMSDK}/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake)

dk_set(EMAR ${EMSDK}/upstream/emscripten/emar)
dk_set(EMCC ${EMSDK}/upstream/emscripten/emcc)
dk_set(EMCMAKE ${EMSDK}/upstream/emscripten/emcmake)
dk_set(EMCONFIGURE ${EMSDK}/upstream/emscripten/emconfigure)
dk_set(EMMAKE ${EMSDK}/upstream/emscripten/emmake)
dk_set(EMPP ${EMSDK}/upstream/emscripten/em++)
dk_set(EMRANLIB ${EMSDK}/upstream/emscripten/emranlib)
