@echo off&rem  ########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG"
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
rem  #################################################################################################################################################


%dk_call% dk_echo "############################################################################"
%dk_call% dk_echo "################# Emscripten_X86_Clang_Toolchain.cmake #####################"
%dk_call% dk_echo "############################################################################"

if defined Android_Host (
	%dk_call% dk_pause
	%dk_call% dk_echo "paused in emscripten toolchain because Android_Host"
	%dk_call% dk_exit
)

%dk_call% dk_validate EMSDK							"%dk_call% dk_depend emsdk"

%dk_call% dk_set CMAKE_GENERATOR					"Unix Makefiles"
if defined Windows_Host (
	%dk_call% dk_validate MSYS2 					"%dk_call% dk_depend msys2"
	%dk_call% dk_installPackage 					make
	dk_findProgram(CMAKE_MAKE_PROGRAM make 			"%MSYS2%/usr/bin"
) else if defined Linux_Host (
	%dk_call% dk_set CMAKE_MAKE_PROGRAM				make
) else (
	%dk_call% dk_set CMAKE_MAKE_PROGRAM				"%EMSDK%/upstream/emscripten/emmake%bat%"
)
%dk_call% dk_set CMAKE_TOOLCHAIN_FILE 				"%EMSDK%/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake"
%dk_call% dk_set CMAKE_C_COMPILER					"%EMSDK%/upstream/emscripten/emcc%bat%"
%dk_call% dk_set CMAKE_CXX_COMPILER					"%EMSDK%/upstream/emscripten/em++%bat%"
rem  %dk_call% dk_append CMAKE_C_FLAGS				-DEMSDK -std=gnu11
rem  %dk_call% dk_append CMAKE_CXX_FLAGS				-DEMSDK -std=gnu++17)
%dk_call% dk_set CMAKE_C_COMPILER_WORKS				1
%dk_call% dk_set CMAKE_CXX_COMPILER_WORKS			1
rem  %dk_call% dk_append DKCMAKE_FLAGS				-DEMSDK=1
rem  %dk_call% dk_append CMAKE_EXE_LINKER_FLAGS		-static  &rem  -s)
