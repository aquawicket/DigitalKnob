@if (@X)==(@Y) @end /* javascript comment
@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# dk_PPID(rtn_var)
::#
::#    http://stackoverflow.com/questions/2531837/how-can-i-get-the-pid-of-the-parent-process-of-my-application
::#
:dk_PPID
setlocal
	%dk_call% dk_debugFunc 1
    if exist "dk_PPID.exe .exe" goto exe_exists
    for /f "tokens=* delims=" %%v in ('dir /b /s /a:-d  /o:-n "%SystemRoot%\Microsoft.NET\Framework\*jsc.exe"') do (
        set "jsc=%%v"
    )

    ::if not exist "%~n0.exe" (
        "%jsc%" /nologo /out:"dk_PPID.exe" "%~dpsfnx0" 
    ::)

    :exe_exists
    for /F "tokens=* USEBACKQ" %%F IN (`dk_PPID.exe`) do (
        set "PPID=%%F"
    )
    
    
    if not defined PPID (dk_PPID.exe)
    if not defined PPID (set "PPID=%errorlevel%")
    
    if defined PPID (echo PPID = %PPID%)
    
    if not defined PPID (%dk_call% dk_error "Could not get PPID")
    endlocal & (
		set "PPID=%PPID%"
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

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


