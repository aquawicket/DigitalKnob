#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ emsdk ############
# https://github.com/emscripten-core/emsdk.git
# https://emscripten.org/index.html
# https://lyceum-allotments.github.io/2016/06/emscripten-and-sdl-2-tutorial-part-1
# https://github.com/emscripten-core/emsdk/archive/refs/tags/2.0.26.zip

dk_validate(host_triple "dk_host_triple()")
if(WIN_HOST)
	dk_depend(python3)
	dk_getNativePath("${PYTHON3_DIR}" PYTHON3_DIR_WIN)
	set(bat ".bat")
	dk_assertVar(bat)
endif()

dk_import(https://github.com/emscripten-core/emsdk/archive/861ce44b.zip)

# https://storage.googleapis.com
# https://storage.googleapis.com/webassembly
# https://storage.googleapis.com/webassembly/emscripten-releases-builds/deps/node-v18.20.3-win-x64.zip 									-> ${EMSDK}/node/18.20.3_64bit
# https://storage.googleapis.com/webassembly/emscripten-releases-builds/deps/python-3.9.2-4-amd64+pywin32.zip 							-> ${EMSDK}/python/3.9.2-nuget_64bit
# https://storage.googleapis.com/webassembly/emscripten-releases-builds/deps/portable_jre_8_update_152_64bit.zip						-> ${EMSDK}/java/8.152_64bit
# https://storage.googleapis.com/webassembly/emscripten-releases-builds/win/fdcf56c75a1d27fdff6525a7e03423595485ca19/wasm-binaries.zip	-> ${EMSDK}/upstream
# https://storage.googleapis.com/webassembly/emscripten-releases-builds/deps/mingw_4.6.2_32bit.zip										-> ${EMSDK}/mingw/4.6.2_32bit

# Download and install the latest SDK tools.
if(WIN_HOST)
	dk_depend(cmake)
	execute_process(COMMAND cmd /c ${CMAKE_EXE} -E env PATH=${PYTHON3_DIR_WIN}	"${EMSDK_DIR}/emsdk.bat"  install latest 			COMMAND_ECHO STDOUT)
else()
	execute_process(COMMAND                                         			"${EMSDK_DIR}/emsdk"      install latest 			COMMAND_ECHO STDOUT)
endif()

# Make the "latest" SDK "active" for the current user. (writes .emscripten file)
if(WIN_HOST)
	execute_process(COMMAND cmd /c ${CMAKE_EXE} -E env PATH=${PYTHON3_DIR_WIN}	"${EMSDK_DIR}/emsdk.bat" activate latest 			COMMAND_ECHO STDOUT)  # --permanent
else()
	execute_process(COMMAND                                         			"${EMSDK_DIR}/emsdk"     activate latest 			COMMAND_ECHO STDOUT)
endif()

# Activate PATH and other environment variables in the current terminal
if(WIN_HOST)
	execute_process(COMMAND cmd /c call											"${EMSDK_DIR}/emsdk_env.bat" 						COMMAND_ECHO STDOUT)
else()
	execute_process(COMMAND chmod 777 											"${EMSDK_DIR}/emsdk_env.sh"  						COMMAND_ECHO STDOUT)
	execute_process(COMMAND                                         			"${EMSDK_DIR}/emsdk_env"     						COMMAND_ECHO STDOUT)
endif()

#if(WIN_HOST)
#	execute_process(COMMAND cmd /c call 									"${EMSDK_DIR}/emsdk.bat" install mingw_4.6.2_32bit		COMMAND_ECHO STDOUT)
#	execute_process(COMMAND cmd /c call 									"${EMSDK_DIR}/emsdk.bat" activate mingw_4.6.2_32bit		COMMAND_ECHO STDOUT)
#endif()

if(EXISTS "${EMSDK_DIR}/upstream/emscripten/src/settings.js")
	dk_fileReplace("${EMSDK_DIR}/upstream/emscripten/src/settings.js" "var USE_SDL = 0" 			"var USE_SDL = false"			NO_HALT)
	dk_fileReplace("${EMSDK_DIR}/upstream/emscripten/src/settings.js" "var USE_SDL_IMAGE = 1" 		"var USE_SDL_IMAGE = false"		NO_HALT)
	dk_fileReplace("${EMSDK_DIR}/upstream/emscripten/src/settings.js" "var USE_SDL_TTF = 1" 		"var USE_SDL_TTF = false"		NO_HALT)
	dk_fileReplace("${EMSDK_DIR}/upstream/emscripten/src/settings.js" "var USE_SDL_NET = 1" 		"var USE_SDL_NET = false"		NO_HALT)
	dk_fileReplace("${EMSDK_DIR}/upstream/emscripten/src/settings.js" "var USE_SDL_MIXER = 1" 		"var USE_SDL_MIXER = false"		NO_HALT)
	dk_fileReplace("${EMSDK_DIR}/upstream/emscripten/src/settings.js" "var USE_PTHREADS = false"	"var USE_PTHREADS = true"		NO_HALT)
endif()

if(WIN_HOST)
	set(ENV{EMSDK_PYTHON} "${EMSDK_DIR}/python/3.9.2-nuget_64bit/python")
	dk_exportVars(EMSDK_PYTHON "${EMSDK_DIR}/python/3.9.2-nuget_64bit/python.exe")
endif()

#dk_set(EMSDK_ENV 	"${EMSDK_DIR}/emsdk_env${bat}")			
#dk_set(EMCONFIGURE	"${EMSDK_DIR}/upstream/emscripten/emconfigure${bat}")   

dk_set			(CMAKE_TOOLCHAIN_FILE 		${EMSDK_DIR}/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake)
#if(WIN_HOST)
#	dk_set		(CMAKE_GENERATOR 			"MinGW Makefiles")
#else()
#	dk_set		(CMAKE_GENERATOR 			"Unix Makefiles")
#endif()
#dk_set			(CMAKE_AR 					"${EMSDK_DIR}/upstream/emscripten/emar${bat}")				# Name of archiving tool for static libraries.

#dk_set			(CMAKE_MAKE_PROGRAM			"${EMSDK_DIR}/upstream/emscripten/emmake${bat}")
if(NOT CMAKE_C_COMPILER)
	#dk_set		(CMAKE_C_COMPILER		    "${EMSDK_DIR}/upstream/emscripten/emcc${bat}")
	#dk_set		(CMAKE_C_COMPILER		    "${EMSDK_DIR}/upstream/bin/clang.exe")
endif()
if(NOT CMAKE_CXX_COMPILER)
	#dk_set		(CMAKE_CXX_COMPILER	    	"${EMSDK_DIR}/upstream/emscripten/em++${bat}")
	#dk_set		(CMAKE_CXX_COMPILER	    	"${EMSDK_DIR}/upstream/bin/clang++.exe")
endif()

#dk_set			(CMAKE_NM 					"${EMSDK_DIR}/upstream/emscripten/emnm${bat}")	
#dk_set			(CMAKE_RANLIB 				"${EMSDK_DIR}/upstream/emscripten/emranlib${bat}")
#dk_set			(CMAKE_C_COMPILER_AR 		"${CMAKE_AR}")
#dk_set			(CMAKE_CXX_COMPILER_AR 		"${CMAKE_AR}")
#dk_set			(CMAKE_C_COMPILER_RANLIB 	"${CMAKE_RANLIB}")
#dk_set			(CMAKE_CXX_COMPILER_RANLIB	"${CMAKE_RANLIB}")
