# https://github.com/emscripten-core/emsdk.git
# https://emscripten.org/index.html
# https://lyceum-allotments.github.io/2016/06/emscripten-and-sdl-2-tutorial-part-1/
# https://github.com/emscripten-core/emsdk/archive/refs/tags/2.0.26.zip

dk_depend(python)
#
#	NOTE:
#	On Windows command prompt,  calling emsdk_env.bat complains about no access to python.
#	This is because, set PATH=%PATH%;${PYTHON} doesn't see to work.
#   However, in a msys2 shell, it does. Maybe we can run these call from there


#dk_import(https://github.com/emscripten-core/emsdk/archive/refs/tags/3.1.31.zip)
dk_import(https://github.com/emscripten-core/emsdk.git BRANCH main)


dk_command(${EMSDK}/emsdk${bat} install latest)

UNIX_HOST_dk_command(chmod 777 ${EMSDK}/emsdk_env.sh)
dk_command(${EMSDK}/emsdk${bat} activate latest --permanent)

#FIXME: add python dir to the path environment variable before calling emsdk.bat
dk_command(${EMSDK}/emsdk_env${bat})

WIN_HOST_dk_command(${EMSDK}/emsdk${bat} install mingw-4.6.2-32bit)
WIN_HOST_dk_command(${EMSDK}/emsdk${bat} activate mingw-4.6.2-32bit)


dk_fileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL = 0;" 			"var USE_SDL = false;"			NOERROR)
dk_fileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL_IMAGE = 1;" 		"var USE_SDL_IMAGE = false;"	NOERROR)
dk_fileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL_TTF = 1;" 		"var USE_SDL_TTF = false;"		NOERROR)
dk_fileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL_NET = 1;" 		"var USE_SDL_NET = false;"		NOERROR)
dk_fileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL_MIXER = 1;" 		"var USE_SDL_MIXER = false;"	NOERROR)
dk_fileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_PTHREADS = false;"	"var USE_PTHREADS = true;"		NOERROR)

#WIN_HOST_dk_set	(EMSDK_ENV 				${EMSDK}/emsdk_env.bat)
#UNIX_HOST_dk_set(EMSDK_ENV 				${EMSDK}/emsdk_env.sh)
dk_set(EMSDK_ENV 							${EMSDK}/emsdk_env${bat})

WIN_HOST_dk_set	(EMSCRIPTEN_GENERATOR 		"MinGW Makefiles")
UNIX_HOST_dk_set(EMSCRIPTEN_GENERATOR 		"Unix Makefiles")
dk_set			(EMSCRIPTEN_TOOLCHAIN_FILE 	${EMSDK}/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake)
dk_set			(EMSCRIPTEN_AR 				${EMSDK}/upstream/emscripten/emar${bat})
dk_set			(EMSCRIPTEN_C_COMPILER 		${EMSDK}/upstream/emscripten/emcc${bat})
dk_set			(EMSCRIPTEN_CMAKE			${EMSDK}/upstream/emscripten/emcmake${bat})
dk_set			(EMSCRIPTEN_CONFIGURE 		${EMSDK}/upstream/emscripten/emconfigure${bat})
dk_set			(EMSCRIPTEN_MAKE_PROGRAM	${EMSDK}/upstream/emscripten/emmake${bat})
dk_set			(EMSCRIPTEN_CXX_COMPILER 	${EMSDK}/upstream/emscripten/em++${bat})
dk_set			(EMSCRIPTEN_RANLIB 			${EMSDK}/upstream/emscripten/emranlib${bat})

