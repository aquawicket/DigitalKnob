include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_validate(HOST_TRIPLE "dk_getHostTriple()")
# https://github.com/emscripten-core/emsdk.git
# https://emscripten.org/index.html
# https://lyceum-allotments.github.io/2016/06/emscripten-and-sdl-2-tutorial-part-1/
# https://github.com/emscripten-core/emsdk/archive/refs/tags/2.0.26.zip

dk_printVar(WIN_HOST)
if(WIN_HOST)
	dk_validate(PYTHON3 "dk_depend(python3)")
	
	set(bat ".bat")
endif()


dk_import(https://github.com/emscripten-core/emsdk/archive/refs/heads/main.zip)
dk_assert(EMSDK)


if(WIN_HOST)
	execute_process(COMMAND ${CMAKE_EXE} -E env PATH=${PYTHON3}		"${EMSDK}/emsdk.bat"  install latest COMMAND_ECHO STDOUT)
else()
	execute_process(COMMAND                                         "${EMSDK}/emsdk"      install latest COMMAND_ECHO STDOUT)
endif()



if(WIN_HOST)
	#execute_process(COMMAND ${CMAKE_EXE} -E env PATH=${PYTHON3}	"${EMSDK}/emsdk.bat" activate latest --permanent COMMAND_ECHO STDOUT)
	execute_process(COMMAND ${CMAKE_EXE} -E env PATH=${PYTHON3}		"${EMSDK}/emsdk.bat" activate latest COMMAND_ECHO STDOUT)
else()
	#execute_process(COMMAND                                         "${EMSDK}/emsdk"    activate latest --permanent COMMAND_ECHO STDOUT)
	execute_process(COMMAND                                         "${EMSDK}/emsdk"     activate latest COMMAND_ECHO STDOUT)
endif()



if(WIN_HOST)
	#execute_process(COMMAND ${CMAKE_EXE} -E env PATH=${PYTHON3}	"${EMSDK}/emsdk_env.bat" COMMAND_ECHO STDOUT)
	execute_process(COMMAND cmd /c call								"${EMSDK}/emsdk_env.bat" COMMAND_ECHO STDOUT)
else()
	execute_process(COMMAND                               chmod 777 "${EMSDK}/emsdk_env.sh"  COMMAND_ECHO STDOUT)
	execute_process(COMMAND                                         "${EMSDK}/emsdk_env"     COMMAND_ECHO STDOUT)
endif()



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

    
### Set Build Flag Variables ###
dk_set(EMSDK_ENV 	"${EMSDK}/emsdk_env${bat}")			
dk_set(EMCMAKE		"${EMSDK}/upstream/emscripten/emcmake${bat}")
dk_set(EMCONFIGURE	"${EMSDK}/upstream/emscripten/emconfigure${bat}")   

dk_set			(CMAKE_TOOLCHAIN_FILE 		${EMSDK}/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake)
WIN_HOST_dk_set	(CMAKE_GENERATOR 			"MinGW Makefiles")
UNIX_HOST_dk_set(CMAKE_GENERATOR 			"Unix Makefiles")
dk_set			(CMAKE_AR 					"${EMSDK}/upstream/emscripten/emar${bat}")
dk_set			(CMAKE_CXX_COMPILER	    	"${EMSDK}/upstream/emscripten/em++${bat}")
dk_set			(CMAKE_C_COMPILER		    "${EMSDK}/upstream/emscripten/emcc${bat}")
dk_set			(CMAKE_NM 					"${EMSDK}/upstream/emscripten/emnm${bat}")	
dk_set			(CMAKE_RANLIB 				"${EMSDK}/upstream/emscripten/emranlib${bat}")
#if(WIN_HOST)
#	dk_set		(CMAKE_MAKE_PROGRAM			"${EMSDK}/mingw/4.6.2_32bit/mingw32-make.exe")
#else()
#	dk_set		(CMAKE_MAKE_PROGRAM         "${EMSDK}/upstream/emscripten/emmake${bat}")
#endif()
dk_set			(CMAKE_C_COMPILER_AR 		"${CMAKE_AR}")
dk_set			(CMAKE_CXX_COMPILER_AR 		"${CMAKE_AR}")
dk_set			(CMAKE_C_COMPILER_RANLIB 	"${CMAKE_RANLIB}")
dk_set			(CMAKE_CXX_COMPILER_RANLIB	"${CMAKE_RANLIB}")



