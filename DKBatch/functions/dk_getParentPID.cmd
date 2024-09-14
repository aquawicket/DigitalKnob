@if (@X)==(@Y) @end /* JScript comment
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_getParentPID(rtn_var)
::#
::#    http://stackoverflow.com/questions/2531837/how-can-i-get-the-pid-of-the-parent-process-of-my-application
::#
:dk_getParentPID
 setlocal
    call dk_debugFunc 1
    
    if exist "dk_getParentPID.exe .exe" goto:exe_exists
    for /f "tokens=* delims=" %%v in ('dir /b /s /a:-d  /o:-n "%SystemRoot%\Microsoft.NET\Framework\*jsc.exe"') do (
        set "jsc=%%v"
    )

    ::if not exist "%~n0.exe" (
        "%jsc%" /nologo /out:"dk_getParentPID.exe" "%~dpsfnx0" 
    ::)

    :exe_exists
    for /F "tokens=* USEBACKQ" %%F IN (`dk_getParentPID.exe`) do (
        set "PPID=%%F"
    )
    
    
    if not defined PPID dk_getParentPID.exe 
    if not defined PPID set "PPID=%errorlevel%"
    
    if defined PPID echo PPID = %PPID%
    
    if not defined PPID %dk_call% dk_error "Could not get PPID"
    endlocal & set "%1=%PPID%"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_getParentPID PPID
    %dk_call% dk_printVar PPID
    
    %dk_call% dk_getParentPID PPID
    %dk_call% dk_printVar PPID
    
    %dk_call% dk_getParentPID PPID
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


