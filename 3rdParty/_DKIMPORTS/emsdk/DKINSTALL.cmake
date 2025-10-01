#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ emsdk ############
# https://github.com/emscripten-core/emsdk.git
# https://emscripten.org/index.html
# https://lyceum-allotments.github.io/2016/06/emscripten-and-sdl-2-tutorial-part-1
# https://github.com/emscripten-core/emsdk/archive/refs/tags/2.0.26.zip

dk_validate(Host_Tuple "dk_Host_Tuple()")
if(Windows_Host)
	dk_depend(python3)
	dk_nativePath("${python3}" python3_native)
	set(bat ".bat")
	dk_assertVar(bat)
endif()

dk_import(https://github.com/emscripten-core/emsdk/archive/861ce44b.zip)
dk_assertPath(${emsdk})

# https://storage.googleapis.com
# https://storage.googleapis.com/webassembly
# https://storage.googleapis.com/webassembly/emscripten-releases-builds/deps/node-v18.20.3-win-x64.zip 									-> ${emsdk}/node/18.20.3_64bit
# https://storage.googleapis.com/webassembly/emscripten-releases-builds/deps/python-3.9.2-4-amd64+pywin32.zip 							-> ${emsdk}/python/3.9.2-nuget_64bit
# https://storage.googleapis.com/webassembly/emscripten-releases-builds/deps/portable_jre_8_update_152_64bit.zip						-> ${emsdk}/java/8.152_64bit
# https://storage.googleapis.com/webassembly/emscripten-releases-builds/win/fdcf56c75a1d27fdff6525a7e03423595485ca19/wasm-binaries.zip	-> ${emsdk}/upstream
# https://storage.googleapis.com/webassembly/emscripten-releases-builds/deps/mingw_4.6.2_32bit.zip										-> ${emsdk}/mingw/4.6.2_32bit

# Download and install the latest SDK tools.
if(Windows_Host)
	dk_validate(cmd_exe "dk_depend(cmd_exe)")
	dk_depend(cmake)
	dk_nativePath(${cmake_exe} cmake_exe)
	execute_process(COMMAND ${cmd_exe} /c ${cmake_exe} -E env PATH=${python3_native}	"${emsdk}/emsdk.bat"  install latest 				COMMAND_ECHO STDOUT)
else()
	execute_process(COMMAND                                         					"${emsdk}/emsdk"      install latest 				COMMAND_ECHO STDOUT)
endif()

# Make the "latest" SDK "active" for the current user. (writes .emscripten file)
if(Windows_Host)
	execute_process(COMMAND ${cmd_exe} /c ${cmake_exe} -E env PATH=${python3_native}	"${emsdk}/emsdk.bat" activate latest 				COMMAND_ECHO STDOUT)  # --permanent
else()
	execute_process(COMMAND                                         					"${emsdk}/emsdk"     activate latest 				COMMAND_ECHO STDOUT)
endif()

# Activate PATH and other environment variables in the current terminal
if(Windows_Host)
	execute_process(COMMAND ${cmd_exe} /c call											"${emsdk}/emsdk_env.bat" 							COMMAND_ECHO STDOUT)
else()
	execute_process(COMMAND chmod 777 													"${emsdk}/emsdk_env.sh"  							COMMAND_ECHO STDOUT)
	execute_process(COMMAND                                         					"${emsdk}/emsdk_env"     							COMMAND_ECHO STDOUT)
endif()

#if(Windows_Host)
#	execute_process(COMMAND ${cmd_exe} /c call 											"${emsdk}/emsdk.bat" install mingw_4.6.2_32bit		COMMAND_ECHO STDOUT)
#	execute_process(COMMAND ${cmd_exe} /c call 											"${emsdk}/emsdk.bat" activate mingw_4.6.2_32bit		COMMAND_ECHO STDOUT)
#endif()

if(NOT EXISTS "${emsdk}/upstream")
	# TODO
endif()

if(EXISTS "${emsdk}/upstream/emscripten/src/settings.js")
	dk_fileReplace("${emsdk}/upstream/emscripten/src/settings.js" "var USE_SDL = 0" 			"var USE_SDL = false"			NO_HALT)
	dk_fileReplace("${emsdk}/upstream/emscripten/src/settings.js" "var USE_SDL_IMAGE = 1" 		"var USE_SDL_IMAGE = false"		NO_HALT)
	dk_fileReplace("${emsdk}/upstream/emscripten/src/settings.js" "var USE_SDL_TTF = 1" 		"var USE_SDL_TTF = false"		NO_HALT)
	dk_fileReplace("${emsdk}/upstream/emscripten/src/settings.js" "var USE_SDL_NET = 1" 		"var USE_SDL_NET = false"		NO_HALT)
	dk_fileReplace("${emsdk}/upstream/emscripten/src/settings.js" "var USE_SDL_MIXER = 1" 		"var USE_SDL_MIXER = false"		NO_HALT)
	dk_fileReplace("${emsdk}/upstream/emscripten/src/settings.js" "var USE_PTHREADS = false"	"var USE_PTHREADS = true"		NO_HALT)
endif()

if(Windows_Host)
	set(ENV{emsdk_PYTHON} "${emsdk}/python/3.9.2-nuget_64bit/python")
	dk_exportVars(emsdk_PYTHON "${emsdk}/python/3.9.2-nuget_64bit/python.exe")
endif()

dk_set(emsdk_ENV 	"${emsdk}/emsdk_env${bat}")			
dk_set(EMCONFIGURE	"${emsdk}/upstream/emscripten/emconfigure${bat}")   
dk_set				(emsdk_TOOLCHAIN_FILE 		"${emsdk}/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake")
dk_set				(emsdk_GENERATOR 			"Unix Makefiles")
dk_set				(emsdk_AR 					"${emsdk}/upstream/emscripten/emar${bat}")				# Name of archiving tool for static libraries.
dk_assertPath		(emsdk_AR)

#if(Windows_Host)
#	dk_depend(msys2)
#	dk_installPackage	(make)
#	dk_findProgram		(emsdk_MAKE_PROGRAM mingw32-make.exe "${msys2}/usr/bin")
#	#dk_set				(emsdk_MAKE_PROGRAM	"${emsdk}/upstream/emscripten/emmake${bat}")
#	dk_assertPath		(emsdk_MAKE_PROGRAM)
#elseif(Linux_Host)
#	dk_set				(emsdk_MAKE_PROGRAM	make)
#else()
#	dk_set				(emsdk_MAKE_PROGRAM	"${emsdk}/upstream/emscripten/emmake${bat}")
#	dk_assertPath		(emsdk_MAKE_PROGRAM)
#endif()

#dk_set				(emsdk_C_COMPILER		    "${emsdk}/upstream/bin/clang.exe")
#dk_set				(emsdk_CXX_COMPILER	    	"${emsdk}/upstream/bin/clang++.exe")
dk_set				(emsdk_C_COMPILER		    "${emsdk}/upstream/emscripten/emcc${bat}")
dk_set				(emsdk_CXX_COMPILER	    	"${emsdk}/upstream/emscripten/em++${bat}")
dk_set				(emsdk_NM 					"${emsdk}/upstream/emscripten/emnm${bat}")	
dk_set				(emsdk_RANLIB 				"${emsdk}/upstream/emscripten/emranlib${bat}")
dk_set				(emsdk_C_COMPILER_AR 		"${emsdk_AR}")
dk_set				(emsdk_CXX_COMPILER_AR 		"${emsdk_AR}")
dk_set				(emsdk_C_COMPILER_RANLIB 	"${emsdk_RANLIB}")
dk_set				(emsdk_CXX_COMPILER_RANLIB	"${emsdk_RANLIB}")
