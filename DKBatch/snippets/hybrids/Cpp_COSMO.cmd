/* 2>nul
	@echo off
	setlocal
	cls
	echo compiling %~n0.exe. . .																							 
	set "SH_EXE=C:\Users\Administrator\digitalknob\DKTools\git-portable-2.46.2-64-bit\bin\bash.exe"
	#set "COSMO_C_COMPILER=/C/Users/Administrator/digitalknob/Development/3rdParty/cosmopolitan-e4d6eb3/bin/cosmocc"
	set "COSMO_C_COMPILER=/C/Users/Administrator/digitalknob/Development/3rdParty/cosmopolitan-e4d6eb3/bin/x86_64-unknown-cosmo-c++"

	for %%Z in ("%~0") do set "APP_NAME=%%~nZ"
	copy %~0 "%~n0.c"
	set "C_FILE=%~n0.c"
	set "COMPILER_EXE=%SH_EXE% %COSMO_C_COMPILER%"
	set "APP_EXE=%CD%\build\%APP_NAME%.exe"
	set "COMPILE_COMMAND=%COMPILER_EXE% -DDKTEST=1 -o %APP_EXE% %C_FILE%"
	
	::###### Setup build directory
	if not exist "%CD%\build" mkdir "%CD%\build"
	
	::###### Compile Code ######
	echo compiling ...
	if exist %APP_EXE%  del %APP_EXE%

	echo %COMPILE_COMMAND%
	%COMPILE_COMMAND%
	if not exist %APP_EXE% (
		echo Compilation failed!
		exit /b %ERRORLEVEL%
	)
	del %C_FILE%
	
	cls 
	%APP_EXE%
	set exit_code=%ERRORLEVEL%

	echo exit_code = %exit_code% & pause
	exit /b %exit_code%
*/

//#################################### C++ ########################################
#include <stdio.h>

int main(){
	printf("Hello world! I was self-compiled!\n");
	return 13;
}
