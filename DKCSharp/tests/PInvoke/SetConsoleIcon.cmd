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
   exit /b 10
)
if NOT EXIST "%~n0.exe" (
   call %csc% /nologo /warn:0 /out:"%~n0.exe" "%~dpsfnx0" || (
      exit /b %errorlevel%
   )
)

%~n0.exe %*
endlocal & exit /b %errorlevel%
*/

using System;
using System.Drawing;
using System.Runtime.InteropServices;

class Program
{
    // Declare the external function from User32.dll
	[DllImport("kernel32.dll", SetLastError = true)]
    private static extern IntPtr GetConsoleWindow();
		
    [DllImport("kernel32.dll", SetLastError = true)]
	static extern bool SetConsoleIcon(IntPtr hIcon);

    static void Main()
    {
        System.Drawing.Icon ico = new System.Drawing.Icon("C:\\icon.ico");
		this.icon = ico;
		//SetConsoleIcon(ico);
		 Console.ReadKey();
    }
	
	/*
	public static void SetConsoleIcon(System.Drawing.Icon icon)
    {
            SetConsoleIcon(icon.Handle);
    }
	*/
}