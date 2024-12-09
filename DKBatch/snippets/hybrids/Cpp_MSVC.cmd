/* 2>nul
	@echo off && setlocal && cls && echo compiling %~n0.exe. . .																							 
	set "outfile=%~dpn0.exe"
	call "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat" > nul
	"C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Tools\MSVC\14.42.34433\bin\Hostx64\x64\cl.exe" %~dpf0 /TP /EHsc /link /out:%outfile% /nologo > nul
	if not exist %outfile% (
		echo Compilation failed!
		exit /b %ERRORLEVEL%
	)
	cls 
	del "%~dpn0.obj"
	%outfile%
	set exit_code=%ERRORLEVEL%
	del %outfile%
	echo exit_code = %exit_code% & pause
	exit /b %exit_code%
*/

//#################################### C++ ########################################
#include <stdio.h>

int main(){
	printf("Hello world! I was self-compiled!\n");
	//printf("\n   Press Enter to exit\n");
	//getchar();
	return 13;
}
