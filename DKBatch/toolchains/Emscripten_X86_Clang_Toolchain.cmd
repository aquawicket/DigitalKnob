%dk_call% dk_echo "############################################################################"
%dk_call% dk_echo "################# Emscripten_X86_Clang_toolchain.cmd #######################"
%dk_call% dk_echo "############################################################################"

%dk_call% dk_prependArgs CMAKE_ARGS -DEMSCRIPTEN=ON
set CMAKE_GENERATOR="Unix Makefiles"








rem if defined Android_Host (
rem 	%dk_call% dk_pause
rem 	%dk_call% dk_echo "paused in Emscripten toolchain because Android_Host"
rem 	%return%
rem )
rem %dk_call% dk_validate emsdk						%dk_call% dk_depend emsdk
rem %dk_call% dk_set CMAKE_GENERATOR					"Unix Makefiles"
rem if defined Windows_Host (
rem 	%dk_call% dk_validate MSYS2 					%dk_call% dk_depend msys2
rem 	%dk_call% dk_installPackage 					make
rem 	dk_findProgram(CMAKE_MAKE_PROGRAM make 			"%msys2%/usr/bin"
rem ) else if defined Linux_Host (
rem 	%dk_call% dk_set CMAKE_MAKE_PROGRAM				make
rem ) else (
rem 	%dk_call% dk_set CMAKE_MAKE_PROGRAM				"%emsdk%/upstream/emscripten/emmake%bat%"
rem )
rem %dk_call% dk_set CMAKE_TOOLCHAIN_FILE 			"%emsdk%/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmd"
rem %dk_call% dk_set CMAKE_C_COMPILER					"%emsdk%/upstream/emscripten/emcc%bat%"
rem %dk_call% dk_set CMAKE_CXX_COMPILER				"%emsdk%/upstream/emscripten/em++%bat%"
rem  %dk_call% dk_append CMAKE_C_FLAGS				-DEMSDK -std=gnu11
rem  %dk_call% dk_append CMAKE_CXX_FLAGS			-DEMSDK -std=gnu++17)
rem %dk_call% dk_set CMAKE_C_COMPILER_WORKS			1
rem %dk_call% dk_set CMAKE_CXX_COMPILER_WORKS			1
rem  %dk_call% dk_append DKCMAKE_FLAGS				-DEMSDK=1
rem  %dk_call% dk_append cmake_exe_LINKER_FLAGS		-static  &rem  -s)
