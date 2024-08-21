@if (@X)==(@Y) @end /* JScript comment
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_getParentPID(rtn_var)
::#
::#    http://stackoverflow.com/questions/2531837/how-can-i-get-the-pid-of-the-parent-process-of-my-application
::#
:dk_getParentPID
	call dk_debugFunc 1

	setlocal
	for /f "tokens=* delims=" %%v in ('dir /b /s /a:-d  /o:-n "%SystemRoot%\Microsoft.NET\Framework\*jsc.exe"') do (
		set "jsc=%%v"
	)

	if not exist "%~n0.exe" (
		"%jsc%" /nologo /out:"%~n0.exe" "%~dpsfnx0" 
	)

	%~n0.exe
	endlocal & "%1=%errorlevel%"
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_getParentPID PPID
	%dk_call% dk_printVar PPID
goto:eof
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
