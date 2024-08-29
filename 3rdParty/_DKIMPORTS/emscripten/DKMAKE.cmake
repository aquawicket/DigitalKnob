include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_validate(HOST_TRIPLE "dk_getHostTriple()")
# https://github.com/emscripten-core/emsdk.git
# https://emscripten.org/index.html
# https://lyceum-allotments.github.io/2016/06/emscripten-and-sdl-2-tutorial-part-1/
# https://github.com/emscripten-core/emsdk/archive/refs/tags/2.0.26.zip

#dk_depend(python)
dk_depend(python3)
dk_assert(PYTHON3)


dk_import(https://github.com/emscripten-core/emscripten/archive/refs/heads/main.zip)
dk_assert(EMSCRIPTEN)

set(bat ".bat")
dk_assert(bat)

dk_command(${EMSCRIPTEN}/emsdk${bat} install latest)

UNIX_HOST_dk_command(chmod 777 ${EMSCRIPTEN}/emsdk_env.sh)
dk_command(${EMSCRIPTEN}/emsdk${bat} activate latest --permanent)

dk_prependEnvPath(${PYTHON3})
dk_command(${EMSCRIPTEN}/emsdk_env${bat})

WIN_HOST_dk_command(${EMSCRIPTEN}/emsdk${bat} install mingw-4.6.2-32bit)
WIN_HOST_dk_command(${EMSCRIPTEN}/emsdk${bat} activate mingw-4.6.2-32bit)

if(EXISTS "${EMSCRIPTEN}/upstream/emscripten/src/settings.js")
dk_fileReplace("${EMSCRIPTEN}/upstream/emscripten/src/settings.js" "var USE_SDL = 0;" 			"var USE_SDL = false;"				NO_HALT)
dk_fileReplace("${EMSCRIPTEN}/upstream/emscripten/src/settings.js" "var USE_SDL_IMAGE = 1;" 		"var USE_SDL_IMAGE = false;"	NO_HALT)
dk_fileReplace("${EMSCRIPTEN}/upstream/emscripten/src/settings.js" "var USE_SDL_TTF = 1;" 		"var USE_SDL_TTF = false;"			NO_HALT)
dk_fileReplace("${EMSCRIPTEN}/upstream/emscripten/src/settings.js" "var USE_SDL_NET = 1;" 		"var USE_SDL_NET = false;"			NO_HALT)
dk_fileReplace("${EMSCRIPTEN}/upstream/emscripten/src/settings.js" "var USE_SDL_MIXER = 1;" 		"var USE_SDL_MIXER = false;"	NO_HALT)
dk_fileReplace("${EMSCRIPTEN}/upstream/emscripten/src/settings.js" "var USE_PTHREADS = false;"	"var USE_PTHREADS = true;"			NO_HALT)
endif()

dk_set(EMSCRIPTEN_ENV 	${EMSCRIPTEN}/emsdk_env${bat})
dk_set(EMAR			${EMSCRIPTEN}/upstream/emscripten/emar${bat})
dk_set(EMCC			${EMSCRIPTEN}/upstream/emscripten/emcc${bat})
dk_set(EMCMAKE		${EMSCRIPTEN}/upstream/emscripten/emcmake${bat})
dk_set(EMCONFIGURE	${EMSCRIPTEN}/upstream/emscripten/emconfigure${bat})	
dk_set(EMXX			${EMSCRIPTEN}/upstream/emscripten/em++${bat})
dk_set(EMRANLIB		${EMSCRIPTEN}/upstream/emscripten/emranlib${bat})


### Set Build Flag Variables ###
WIN_HOST_dk_set	(EMSCRIPTEN_GENERATOR 		"MinGW Makefiles")
UNIX_HOST_dk_set(EMSCRIPTEN_GENERATOR 		"Unix Makefiles")
dk_set			(EMSCRIPTEN_TOOLCHAIN_FILE 	${EMSCRIPTEN}/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake)
dk_set			(EMSCRIPTEN_MAKE_PROGRAM	${EMSCRIPTEN}/mingw/4.6.2_32bit/mingw32-make.exe)
dk_set			(EMSCRIPTEN_C_COMPILER		${EMSCRIPTEN}/mingw/4.6.2_32bit/gcc.exe)
dk_set			(EMSCRIPTEN_CXX_COMPILER	${EMSCRIPTEN}/mingw/4.6.2_32bit/g++.exe)
#dk_set			(EMSCRIPTEN_AR 				)
#dk_set			(EMSCRIPTEN_C_COMPILER 		)
#dk_set			(EMSCRIPTEN_CMAKE			)
#dk_set			(EMSCRIPTEN_CONFIGURE 		)
#dk_set			(EMSCRIPTEN_CXX_COMPILER 	)
#dk_set			(EMSCRIPTEN_RANLIB 			)
dk_printVar(EMSCRIPTEN_GENERATOR)
dk_printVar(EMSCRIPTEN_TOOLCHAIN_FILE)
dk_printVar(EMSCRIPTEN_MAKE_PROGRAM)


### Set Environmant Variables ###
#dk_setEnv(EMSCRIPTEN 		${EMSCRIPTEN})
#dk_setEnv(EMSCRIPTEN_NODE 	${EMSCRIPTEN}/node/16.20.0_64bit/bin/node.exe)
#dk_setEnv(EMSCRIPTEN_PYTHON 	${EMSCRIPTEN}/emsdk-main/python/3.9.2-nuget_64bit/python.exe)
#dk_prependEnvPath(${EMSCRIPTEN})
#dk_prependEnvPath(${EMSCRIPTEN}/node/16.20.0_64bit/bin)
#dk_prependEnvPath(${EMSCRIPTEN}/upstream/emscripten)
