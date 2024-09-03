include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_validate(HOST_TRIPLE "dk_getHostTriple()")
# https://github.com/emscripten-core/emsdk.git
# https://emscripten.org/index.html
# https://lyceum-allotments.github.io/2016/06/emscripten-and-sdl-2-tutorial-part-1/
# https://github.com/emscripten-core/emsdk/archive/refs/tags/2.0.26.zip


if(WIN_HOST)
	dk_validate(PYTHON3 "dk_depend(python3)")
	
	set(bat ".bat")
endif()


dk_import(https://github.com/emscripten-core/emsdk/archive/refs/heads/main.zip)
dk_assert(EMSDK)


if(WIN_HOST)
	execute_process(COMMAND ${CMAKE_EXE} -E env PATH=${PYTHON3}		"${EMSDK}/emsdk.bat"  install latest COMMAND_ECHO STDOUT)
endif()
UNIX_HOST_dk_command(                                         		"${EMSDK}/emsdk"      install latest)


if(WIN_HOST)
	execute_process(COMMAND ${CMAKE_EXE} -E env PATH=${PYTHON3}		"${EMSDK}/emsdk.bat" activate latest --permanent COMMAND_ECHO STDOUT)
endif()
UNIX_HOST_dk_command(                                      			"${EMSDK}/emsdk"     activate latest --permanent)


if(WIN_HOST)
	#execute_process(COMMAND ${CMAKE_EXE} -E env PATH=${PYTHON3}	"${EMSDK}/emsdk_env.bat" COMMAND_ECHO STDOUT)
	execute_process(COMMAND cmd /c call								"${EMSDK}/emsdk_env.bat" COMMAND_ECHO STDOUT)
endif()
UNIX_HOST_dk_command(chmod 777 "${EMSDK}/emsdk_env.sh")
UNIX_HOST_dk_command(                                      			"${EMSDK}/emsdk_env")


if(WIN_HOST)
	#execute_process(COMMAND ${CMAKE_EXE} -E env PATH=${PYTHON3}	"${EMSDK}/emsdk.bat" install mingw-4.6.2-32bit   COMMAND_ECHO STDOUT)
	#execute_process(COMMAND ${CMAKE_EXE} -E env PATH=${PYTHON3}	"${EMSDK}/emsdk.bat" activate mingw-4.6.2-32bit  COMMAND_ECHO STDOUT)
	execute_process(COMMAND cmd /c call 							"${EMSDK}/emsdk.bat" install mingw-4.6.2-32bit   COMMAND_ECHO STDOUT)
	execute_process(COMMAND cmd /c call 							"${EMSDK}/emsdk.bat" activate mingw-4.6.2-32bit  COMMAND_ECHO STDOUT)
endif()


if(EXISTS "${EMSDK}/upstream/emscripten/src/settings.js")
	dk_fileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL = 0;" 			"var USE_SDL = false;"			NO_HALT)
	dk_fileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL_IMAGE = 1;" 		"var USE_SDL_IMAGE = false;"	NO_HALT)
	dk_fileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL_TTF = 1;" 		"var USE_SDL_TTF = false;"		NO_HALT)
	dk_fileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL_NET = 1;" 		"var USE_SDL_NET = false;"		NO_HALT)
	dk_fileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL_MIXER = 1;" 		"var USE_SDL_MIXER = false;"	NO_HALT)
	dk_fileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_PTHREADS = false;"	"var USE_PTHREADS = true;"		NO_HALT)
endif()

dk_set(EMSDK_ENV 	${EMSDK}/emsdk_env${bat})
dk_set(EMAR			${EMSDK}/upstream/emscripten/emar${bat})
dk_set(EMCC			${EMSDK}/upstream/emscripten/emcc${bat})
dk_set(EMCMAKE		${EMSDK}/upstream/emscripten/emcmake${bat})
dk_set(EMCONFIGURE	${EMSDK}/upstream/emscripten/emconfigure${bat})	
dk_set(EMXX			${EMSDK}/upstream/emscripten/em++${bat})
dk_set(EMRANLIB		${EMSDK}/upstream/emscripten/emranlib${bat})


### Set Build Flag Variables ###
WIN_HOST_dk_set	(CMAKE_GENERATOR 		    "MinGW Makefiles")
UNIX_HOST_dk_set(CMAKE_GENERATOR 		    "Unix Makefiles")
dk_set			(CMAKE_TOOLCHAIN_FILE 	    ${EMSDK}/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake)
dk_set			(CMAKE_MAKE_PROGRAM	        ${EMSDK}/mingw/4.6.2_32bit/mingw32-make.exe)
dk_set			(CMAKE_C_COMPILER		    ${EMSDK}/mingw/4.6.2_32bit/gcc.exe)
dk_set			(CMAKE_CXX_COMPILER	        ${EMSDK}/mingw/4.6.2_32bit/g++.exe)
#dk_set			(EMSCRIPTEN_AR 				)
#dk_set			(EMSCRIPTEN_C_COMPILER 		)
#dk_set			(EMSCRIPTEN_CMAKE			)
#dk_set			(EMSCRIPTEN_CONFIGURE 		)
#dk_set			(EMSCRIPTEN_CXX_COMPILER 	)
#dk_set			(EMSCRIPTEN_RANLIB 			)
dk_printVar(CMAKE_GENERATOR)
dk_printVar(CMAKE_TOOLCHAIN_FILE)
dk_printVar(CMAKE_MAKE_PROGRAM)
dk_printVar(CMAKE_C_COMPILER)
dk_printVar(CMAKE_CXX_COMPILER)

### Set Environmant Variables ###
#dk_setEnv(EMSDK 		${EMSDK})
#dk_setEnv(EMSDK_NODE 	${EMSDK}/node/16.20.0_64bit/bin/node.exe)
#dk_setEnv(EMSDK_PYTHON 	${EMSDK}/emsdk-main/python/3.9.2-nuget_64bit/python.exe)
#dk_prependEnvPath(${EMSDK})
#dk_prependEnvPath(${EMSDK}/node/16.20.0_64bit/bin)
#dk_prependEnvPath(${EMSDK}/upstream/emscripten)
