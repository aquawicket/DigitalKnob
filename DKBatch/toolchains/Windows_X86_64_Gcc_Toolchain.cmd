::@echo off&rem  ########################################## DigitalKnob DKBatch ########################################################################
::if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG"
::if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::######################################################################################################################################################

if not defined Windows_Host (
	%return%
)

%dk_call% dk_echo "############################################################################"
%dk_call% dk_echo "################## Windows_X86_64_Gcc_Toolchain.cmd ######################"
%dk_call% dk_echo "############################################################################"

%dk_call% dk_validate 			MSYS2					"%dk_call% dk_depend msys2"
%dk_call% dk_depend 			gcc

%dk_call% dk_set				MSYSTEM 				"MINGW64"
%dk_call% dk_prependEnvPath 							"%MSYS2%/usr/bin"
%dk_call% dk_prependEnvPath 							"%%MSYSTEM%_BIN%"
%dk_call% dk_prependEnvPath 							"%MSYS2%/mingw64/lib"
%dk_call% dk_set 				%ACLOCAL_PATH% 			"%MSYS2%/usr/share/aclocal"

%dk_call% dk_set 				CMAKE_GENERATOR			"MinGW Makefiles"
%dk_call% dk_set 				CMAKE_MAKE_PROGRAM 		"%%MSYSTEM%_BIN%/mingw32-make.exe"
%dk_call% dk_set 				CMAKE_C_COMPILER		"%%MSYSTEM%_BIN%/gcc.exe"
%dk_call% dk_set 				CMAKE_CXX_COMPILER 		"%%MSYSTEM%_BIN%/g++.exe"
%dk_call% dk_set 				CMAKE_RC_COMPILER  		"%%MSYSTEM%_BIN%/windres.exe"

rem %dk_call% dk_append 		CMAKE_C_FLAGS			-v -march=x86-64 -DMSYSTEM=%MSYSTEM% -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu17
rem %dk_call% dk_append 		CMAKE_CXX_FLAGS			-v -march=x86-64 -DMSYSTEM=%MSYSTEM% -DWIN -DWIN_X86_64 -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS -D_USING_V110_SDK71_ -std=gnu++17
rem %dk_call% dk_append 		CMAKE_EXE_LINKER_FLAGS	"-static"  &rem  -s

rem %dk_call% dk_append 		DKCONFIGURE_FLAGS		"--build=x86_64-w64-mingw32"
