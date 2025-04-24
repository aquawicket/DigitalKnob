// 2>nul||@goto :batch
/*
:batch
@echo off
setlocal
rem del /q /f "%~n0.exe" >nul 2>nul
:: find csc.exe
set "csc="
for /r "%SystemRoot%\Microsoft.NET\Framework\" %%# in ("*csc.exe") do  set "csc=%%#"
if not exist "%csc%" (
   echo no .net framework installed
   exit /b 10
)
if not exist "%~n0.exe" (
   call %csc% /nologo /warn:0 /out:"%~n0.exe" "%~dpsfnx0" || (
      exit /b %errorlevel% 
   )
)

%~n0.exe %*
endlocal & exit /b %errorlevel%
*/

using System;
using System.Runtime.InteropServices;
using System.Diagnostics;
using System.Collections.Generic;

public class SelfContainer {

    public static void Main(String[] args)
    {
        var myVariable = 2 + 2;
        Console.WriteLine("Run from bat " + myVariable);
    }
}