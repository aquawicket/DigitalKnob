@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# dk_getDirectories(path)
::#
::#   reference: https://stackoverflow.com/a/138581
::#
:dk_getDirectories
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 1

	set "_path_=%~1"
	%dk_call% dk_assertPath "%_path_%"

	set /a "n=0"
	for /d %%a in ("%_path_:/=\%\*") do (
		set "temp=%%a"
		set "dk_getDirectories[!n!]=!temp:\=/!"
		set /a "n+=1"
	) 

	::### Return the array to the calling scope ###
	set "currentScope=1"
	for /F "delims=" %%b in ('set dk_getDirectories[') do (
		if defined currentScope endlocal
		set "%%b"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_getDirectories "C:"
	%dk_call% dk_printVar dk_getDirectories
	%dk_call% Array::dk_length dk_getDirectories
	%dk_call% dk_echo "directories %dk_length%"

	%dk_call% dk_set myPath "C:/Windows"
	%dk_call% dk_getDirectories "%myPath%"
	%dk_call% dk_printVar dk_getDirectories
	%dk_call% Array::dk_length dk_getDirectories
	%dk_call% dk_echo "directories %dk_length%"
%endfunction%
