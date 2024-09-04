include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/emscripten-core/emsdk.git
# https://emscripten.org/index.html
# https://lyceum-allotments.github.io/2016/06/emscripten-and-sdl-2-tutorial-part-1/
# https://github.com/emscripten-core/emsdk/archive/refs/tags/2.0.26.zip


dk_validate(HOST_TRIPLE "dk_getHostTriple()")
if(WIN_HOST)
	dk_validate(PYTHON3 "dk_depend(python3)")
	dk_assertPath(PYTHON3)
	set(bat ".bat")
	dk_assert(bat)
endif()


dk_import(https://github.com/emscripten-core/emsdk/archive/refs/heads/main.zip)
dk_assert(EMSDK)

# https://storage.googleapis.com
# https://storage.googleapis.com/webassembly
# https://storage.googleapis.com/webassembly/emscripten-releases-builds/deps/node-v18.20.3-win-x64.zip 									-> ${EMSDK}/node/18.20.3_64bit
# https://storage.googleapis.com/webassembly/emscripten-releases-builds/deps/python-3.9.2-4-amd64+pywin32.zip 							-> ${EMSDK}/python/3.9.2-nuget_64bit
# https://storage.googleapis.com/webassembly/emscripten-releases-builds/deps/portable_jre_8_update_152_64bit.zip						-> ${EMSDK}/java/8.152_64bit
# https://storage.googleapis.com/webassembly/emscripten-releases-builds/win/fdcf56c75a1d27fdff6525a7e03423595485ca19/wasm-binaries.zip	-> ${EMSDK}/upstream
# https://storage.googleapis.com/webassembly/emscripten-releases-builds/deps/mingw_4.6.2_32bit.zip										-> ${EMSDK}/mingw/4.6.2_32bit


# Download and install the latest SDK tools.
if(WIN_HOST)
	execute_process(COMMAND ${CMAKE_EXE} -E env PATH=${PYTHON3}		"${EMSDK}/emsdk.bat"  install latest 				COMMAND_ECHO STDOUT)
else()
	execute_process(COMMAND                                         "${EMSDK}/emsdk"      install latest 				COMMAND_ECHO STDOUT)
endif()

# Make the "latest" SDK "active" for the current user. (writes .emscripten file)
if(WIN_HOST)
	execute_process(COMMAND ${CMAKE_EXE} -E env PATH=${PYTHON3}		"${EMSDK}/emsdk.bat" activate latest 				COMMAND_ECHO STDOUT)  # --permanent
else()
	execute_process(COMMAND                                         "${EMSDK}/emsdk"     activate latest 				COMMAND_ECHO STDOUT)
endif()

# Activate PATH and other environment variables in the current terminal
if(WIN_HOST)
	execute_process(COMMAND cmd /c call								"${EMSDK}/emsdk_env.bat" 							COMMAND_ECHO STDOUT)
else()
	execute_process(COMMAND chmod 777 								"${EMSDK}/emsdk_env.sh"  							COMMAND_ECHO STDOUT)
	execute_process(COMMAND                                         "${EMSDK}/emsdk_env"     							COMMAND_ECHO STDOUT)
endif()

if(WIN_HOST)
	execute_process(COMMAND cmd /c call 							"${EMSDK}/emsdk.bat" install mingw-4.6.2-32bit		COMMAND_ECHO STDOUT)
	execute_process(COMMAND cmd /c call 							"${EMSDK}/emsdk.bat" activate mingw-4.6.2-32bit		COMMAND_ECHO STDOUT)
endif()


if(EXISTS "${EMSDK}/upstream/emscripten/src/settings.js")
	dk_fileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL = 0;" 			"var USE_SDL = false;"			NO_HALT)
	dk_fileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL_IMAGE = 1;" 		"var USE_SDL_IMAGE = false;"	NO_HALT)
	dk_fileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL_TTF = 1;" 		"var USE_SDL_TTF = false;"		NO_HALT)
	dk_fileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL_NET = 1;" 		"var USE_SDL_NET = false;"		NO_HALT)
	dk_fileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_SDL_MIXER = 1;" 		"var USE_SDL_MIXER = false;"	NO_HALT)
	dk_fileReplace("${EMSDK}/upstream/emscripten/src/settings.js" "var USE_PTHREADS = false;"	"var USE_PTHREADS = true;"		NO_HALT)
endif()


### Environment Variables ###
# EMSDK		 	= C:/Users/Administrator/digitalknob/Development/3rdParty/emsdk-main
set(ENV{EMSDK} "${EMSDK}")

# EMSDK_NODE	= C:\Users\Administrator\digitalknob\Development\3rdParty\emsdk-main\node\18.20.3_64bit\bin\node.exe
set(ENV{EMSDK_NODE} "${EMSDK}/node/18.20.3_64bit/bin/node.exe")

# EMSDK_PYTHON	= C:\Users\Administrator\digitalknob\Development\3rdParty\emsdk-main\python\3.9.2-nuget_64bit\python.exe
set(ENV{EMSDK_PYTHON} "${EMSDK}/python/3.9.2-nuget_64bit/python.exe")

# JAVA_HOME		= C:\Users\Administrator\digitalknob\Development\3rdParty\emsdk-main\java\8.152_64bit
set(ENV{JAVA_HOME} "${EMSDK}/java/8.152_64bit")

# PATH			= C:\Users\Administrator\digitalknob\Development\3rdParty\emsdk-main
#                 C:\Users\Administrator\digitalknob\Development\3rdParty\emsdk-main\mingw\4.6.2_32bit
#				  C:\Users\Administrator\digitalknob\Development\3rdParty\emsdk-main\node\18.20.3_64bit\bin
#				  C:\Users\Administrator\digitalknob\Development\3rdParty\emsdk-main\upstream\emscripten	  
set(ENV{PATH} "${EMSDK}/mingw/4.6.2_32bit;${EMSDK}/node/18.20.3_64bit/bin;${EMSDK}/upstream/emscripten;${EMSDK}/python/3.9.2-nuget_64bit")

### Set Build Flag Variables ###
dk_set(EMSDK_ENV 	"${EMSDK}/emsdk_env${bat}")			
#dk_set(EMCMAKE		"${EMSDK}/upstream/emscripten/emcmake${bat}")
dk_set(EMCONFIGURE	"${EMSDK}/upstream/emscripten/emconfigure${bat}")   

dk_set			(CMAKE_TOOLCHAIN_FILE 		${EMSDK}/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake)
WIN_HOST_dk_set	(CMAKE_GENERATOR 			"MinGW Makefiles")
UNIX_HOST_dk_set(CMAKE_GENERATOR 			"Unix Makefiles")
dk_set			(CMAKE_AR 					"${EMSDK}/upstream/emscripten/emar${bat}")
dk_set			(CMAKE_CXX_COMPILER	    	"${EMSDK}/upstream/emscripten/em++${bat}")
dk_set			(CMAKE_C_COMPILER		    "${EMSDK}/upstream/emscripten/emcc${bat}")
dk_set			(CMAKE_NM 					"${EMSDK}/upstream/emscripten/emnm${bat}")	
dk_set			(CMAKE_RANLIB 				"${EMSDK}/upstream/emscripten/emranlib${bat}")
dk_set			(CMAKE_C_COMPILER_AR 		"${CMAKE_AR}")
dk_set			(CMAKE_CXX_COMPILER_AR 		"${CMAKE_AR}")
dk_set			(CMAKE_C_COMPILER_RANLIB 	"${CMAKE_RANLIB}")
dk_set			(CMAKE_CXX_COMPILER_RANLIB	"${CMAKE_RANLIB}")

###### Set CMAKE_MAKE_PROGRAM ######
#if(WIN_HOST)
#	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${EMSDK}/mingw/4.6.2_32bit")
#else()
#	dk_findProgram(CMAKE_MAKE_PROGRAM make /usr/bin)
#endif()


