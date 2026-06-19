@if (@X)==(@Y) @end /* javascript comment
@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ################################################################################
rem # dk_PPID(rtn_var)
rem #
rem #    http://stackoverflow.com/questions/2531837/how-can-i-get-the-pid-of-the-parent-process-of-my-application
rem #
:dk_PPID
%setlocal%
    if EXIST "dk_PPID.exe .exe" goto exe_exists
    for /f "tokens=* delims=" %%v in ('dir /b/s/a:-d /o:-n "%SystemRoot%\Microsoft.NET\Framework\*jsc.exe"') do (
        set "jsc=%%v"
    )

    rem if NOT EXIST "%~n0.exe" (
        "%jsc%" /nologo /out:"dk_PPID.exe" "%~dpsfnx0"
    rem )

    :exe_exists
    for /F "tokens=* USEBACKQ" %%F IN (`dk_PPID.exe`) do (
        set "PPID=%%F"
    )
   
   
    if NOT defined PPID (dk_PPID.exe)
    if NOT defined PPID (set "PPID=%errorlevel%")
   
    if defined PPID (echo PPID = %PPID%)
   
    if NOT defined PPID (%dk_call% dk_error "Could NOT get PPID")
    endlocal & (
		set "PPID=%PPID%"
	)
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_PPID PPID
    %dk_call% dk_printVar PPID
   
    %dk_call% dk_PPID PPID
    %dk_call% dk_printVar PPID
   
    %dk_call% dk_PPID PPID
    %dk_call% dk_printVar PPID
%endfunction%
*/



import  System;
import  System.Diagnostics;
import  System.ComponentModel;
import  System.Management;

var myId = Process.GetCurrentProcess().Id;
var query = String.Format("SELECT ParentProcessId FROM Win32_Process WHERE ProcessId = {0}", myId);
var search = new ManagementObjectSearcher("root\\CIMV2", query);
var results = search.Get().GetEnumerator();
if (!results.MoveNext()) {
    Console.WriteLine("Error");
    Environment.Exit(-1);
}
var queryObj = results.Current;
var parentId = queryObj["ParentProcessId"];
var parent = Process.GetProcessById(parentId);
Console.WriteLine(parent.Id);
Environment.Exit(parent.Id);


