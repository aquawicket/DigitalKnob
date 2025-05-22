// >nul 2>nul || @echo off && goto :batch
/*
:batch
@echo off
setlocal
	set framework=%SystemRoot%\Microsoft.NET\Framework
	for /f "tokens=* delims=" %%v in ('dir /b /a:d /o:-n "%framework%\v*"') do (
	   set version=%%v
	   goto :found_version
	)
	:found_version
	set csc=%framework%\%version%\csc.exe
	set program=%~n0.exe
	call %csc% /nologo /out:"%program%" "%~dpsfnx0"
	%program%
endlocal & set "exit_code=%ERRORLEVEL%" & del /f "%program%"
echo exit_code = %exit_code% && pause
exit /b %exit_code%

########################################### CSharp #############################################*/
namespace BatchHybrid {
	using System;

	class Program {
		static void Main (string[] args) {
			Console.WriteLine("CSharp: main("+args+")");
			System.Environment.Exit(13);
		}
	}
}