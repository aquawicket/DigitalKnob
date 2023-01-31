# https://github.com/emscripten-core/emsdk.git
# https://emscripten.org/index.html
# https://lyceum-allotments.github.io/2016/06/emscripten-and-sdl-2-tutorial-part-1/
# https://github.com/emscripten-core/emsdk/archive/refs/tags/2.0.26.zip


dk_depend(python)

#dk_import(https://github.com/emscripten-core/emsdk/archive/refs/tags/3.1.30.zip PATCH)
dk_import(https://github.com/emscripten-core/emsdk/archive/refs/tags/3.1.31.zip PATCH)
#dk_import(https://github.com/emscripten-core/emsdk.git BRANCH main PATCH)

#dk_copy(${DKIMPORTS}/emsdk/upstream/emscripten/src/settings.js ${EMSDK}/emsdk/upstream/emscripten/src/settings.js)


dk_command(${EMSDK}/emsdk install latest)
dk_command(${EMSDK}/emsdk activate latest)
UNIX_HOST_dk_command(chmod 777 ${EMSDK}/emsdk_env.sh)
UNIX_HOST_dk_command(${EMSDK}/emsdk_env.sh)
WIN_HOST_dk_command(${EMSDK}/emsdk_env.bat)
WIN_HOST_dk_command(${EMSDK}/emsdk install mingw-4.6.2-32bit)
WIN_HOST_dk_command(${EMSDK}/emsdk activate mingw-4.6.2-32bit)

#if(WIN_HOST)
	WIN_HOST_dk_set(EMSDK_ENV ${EMSDK}/emsdk_env.bat)
#else()
	UNIX_HOST_dk_set(EMSDK_ENV ${EMSDK}/emsdk_env.sh)
#endif()
dk_set(EMAR ${EMSDK}/upstream/emscripten/emar)
dk_set(EMCC ${EMSDK}/upstream/emscripten/emcc)
dk_set(EMCMAKE ${EMSDK}/upstream/emscripten/emcmake)
dk_set(EMCONFIGURE ${EMSDK}/upstream/emscripten/emconfigure)
dk_set(EMMAKE ${EMSDK}/upstream/emscripten/emmake)
dk_set(EMPP ${EMSDK}/upstream/emscripten/em++)
dk_set(EMRANLIB ${EMSDK}/upstream/emscripten/emranlib)
