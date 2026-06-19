// 2>nul||@goto :batch
/*
:: https://github.com/adamdriscoll/pinvoke
:: https://www.leeholmes.com/managing-ini-files-with-powershell
:: https://pinvoke.net
:: https://www.codeproject.com/Articles/12121/Essential-P-Invoke
:batch
@echo off
setlocal
rem del /q /f "%~n0.exe" >nul 2>nul
:: find csc.exe
set "csc="
for /r "%SystemRoot:\=/%/Microsoft.NET/Framework/" %%# in ("*csc.exe") do  set "csc=%%#"
if NOT EXIST "%csc%" (
   echo no .net framework installed
   exit /b 1
)
if NOT EXIST "%~n0.exe" (
   call %csc% /nologo /warn:0 /out:"%~n0.exe" "%~dpsfnx0" || (
	  exit /b %errorlevel%
   )
)
%~n0.exe %*
del %~n0.exe
exit /b %errorlevel%
*/

public class dk {
	[System.Runtime.InteropServices.DllImport("user32.dll", CharSet = System.Runtime.InteropServices.CharSet.Auto)]
	static extern int MessageBox(System.IntPtr hWnd, System.String text, System.String caption, int options);

	static void Main(){
		MessageBox(System.IntPtr.Zero, "text", "caption", 0);
	}
}
