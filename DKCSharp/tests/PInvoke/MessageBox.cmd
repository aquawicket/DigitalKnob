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
using System.Runtime.InteropServices; // Required for P/Invoke

class Program
{
    // Declare the external function from User32.dll
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int MessageBox(IntPtr hWnd, String text, String caption, int options);

    static void Main()
    {
        // Call the external function to show a message box
        MessageBox(IntPtr.Zero, "Hello from P/Invoke!", "P/Invoke Example", 0);
    }
}