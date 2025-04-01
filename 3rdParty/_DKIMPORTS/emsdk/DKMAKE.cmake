#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ emsdk ############
# https://github.com/emscripten-core/emsdk.git
# https://emscripten.org/index.html
# https://lyceum-allotments.github.io/2016/06/emscripten-and-sdl-2-tutorial-part-1
# https://github.com/emscripten-core/emsdk/archive/refs/tags/2.0.26.zip

dk_validate(host_triple "dk_host_triple()")
if(WIN_HOST)
	dk_depend(python3)
	dk_nativePath("${PYTHON3_DIR}" PYTHON3_DIR_WIN)
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
	dk_validate(CMD_EXE "dk_depend(cmd)")
	dk_validate(CMAKE_EXE "dk_depend(cmake)")
	dk_nativePath(${CMD_EXE} CMD_EXE)
	dk_nativePath(${CMAKE_EXE} CMAKE_EXE)
	execute_process(COMMAND ${CMD_EXE} /c ${CMAKE_EXE} -E env PATH=${PYTHON3_DIR_WIN}	"${EMSDK}/emsdk.bat"  install latest 				COMMAND_ECHO STDOUT)
else()
	execute_process(COMMAND                                         					"${EMSDK}/emsdk"      install latest 				COMMAND_ECHO STDOUT)
endif()

# Make the "latest" SDK "active" for the current user. (writes .emscripten file)
if(WIN_HOST)
	execute_process(COMMAND ${CMD_EXE} /c ${CMAKE_EXE} -E env PATH=${PYTHON3_DIR_WIN}	"${EMSDK}/emsdk.bat" activate latest 				COMMAND_ECHO STDOUT)  # --permanent
else()
	execute_process(COMMAND                                         					"${EMSDK}/emsdk"     activate latest 				COMMAND_ECHO STDOUT)
endif()

# Activate PATH and other environment variables in the current terminal
if(WIN_HOST)
	execute_process(COMMAND ${CMD_EXE} /c call											"${EMSDK}/emsdk_env.bat" 							COMMAND_ECHO STDOUT)
else()
	execute_process(COMMAND chmod 777 													"${EMSDK}/emsdk_env.sh"  							COMMAND_ECHO STDOUT)
	execute_process(COMMAND                                         					"${EMSDK}/emsdk_env"     							COMMAND_ECHO STDOUT)
endif()

#if(WIN_HOST)
#	execute_process(COMMAND ${CMD_EXE} /c call 											"${EMSDK}/emsdk.bat" install mingw_4.6.2_32bit		COMMAND_ECHO STDOUT)
#	execute_process(COMMAND ${CMD_EXE} /c call 											"${EMSDK}/emsdk.bat" activate mingw_4.6.2_32bit		COMMAND_ECHO STDOUT)
#endif()

if(NOT EXISTS "${EMSDK}/upstream")

endif()

if(EXISTS "${EMSDK}/upstream/emscripten/src/settings.js")
	dk_fileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL = 0" 			"var USE_SDL = false"			NO_HALT)
	dk_fileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL_IMAGE = 1" 		"var USE_SDL_IMAGE = false"		NO_HALT)
	dk_fileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL_TTF = 1" 		"var USE_SDL_TTF = false"		NO_HALT)
	dk_fileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL_NET = 1" 		"var USE_SDL_NET = false"		NO_HALT)
	dk_fileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL_MIXER = 1" 		"var USE_SDL_MIXER = false"		NO_HALT)
	dk_fileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_PTHREADS = false"	"var USE_PTHREADS = true"		NO_HALT)
endif()

if(WIN_HOST)
	set(ENV{EMSDK_PYTHON} "${EMSDK}/python/3.9.2-nuget_64bit/python")
	dk_exportVars(EMSDK_PYTHON "${EMSDK}/python/3.9.2-nuget_64bit/python.exe")
endif()

dk_set(EMSDK_ENV 	"${EMSDK}/emsdk_env${bat}")			
dk_set(EMCONFIGURE	"${EMSDK}/upstream/emscripten/emconfigure${bat}")   
dk_set				(EMSDK_TOOLCHAIN_FILE 		"${EMSDK}/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake")
dk_set				(EMSDK_GENERATOR 			"Unix Makefiles")
dk_set				(EMSDK_AR 					"${EMSDK}/upstream/emscripten/emar${bat}")				# Name of archiving tool for static libraries.
dk_assertPath		(EMSDK_AR)
if(WIN_HOST)
	dk_validate		(MSYS2 						"dk_depend(msys2)")
	dk_installPackage(make)
	dk_findProgram	(EMSDK_MAKE_PROGRAM make 	"${MSYS2}/usr/bin")
else()
	dk_set			(EMSDK_MAKE_PROGRAM			"${EMSDK}/upstream/emscripten/emmake${bat}")
endif()
dk_assertPath		(EMSDK_MAKE_PROGRAM)
#dk_set				(EMSDK_C_COMPILER		    "${EMSDK}/upstream/bin/clang.exe")
#dk_set				(EMSDK_CXX_COMPILER	    	"${EMSDK}/upstream/bin/clang++.exe")
dk_set				(EMSDK_C_COMPILER		    "${EMSDK}/upstream/emscripten/emcc${bat}")
dk_set				(EMSDK_CXX_COMPILER	    	"${EMSDK}/upstream/emscripten/em++${bat}")
dk_set				(EMSDK_NM 					"${EMSDK}/upstream/emscripten/emnm${bat}")	
dk_set				(EMSDK_RANLIB 				"${EMSDK}/upstream/emscripten/emranlib${bat}")
dk_set				(EMSDK_C_COMPILER_AR 		"${EMSDK_AR}")
dk_set				(EMSDK_CXX_COMPILER_AR 		"${EMSDK_AR}")
dk_set				(EMSDK_C_COMPILER_RANLIB 	"${EMSDK_RANLIB}")
dk_set				(EMSDK_CXX_COMPILER_RANLIB	"${EMSDK_RANLIB}")
