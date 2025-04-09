@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# dk_getFiles(path)
::#
::#   reference: https://stackoverflow.com/a/138581
::#
:dk_getFiles
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 1

	set "_path_=%~1"
	%dk_call% dk_assertPath "%_path_%"

	set /a "n=0"
	for %%a in ("%_path_:/=\%\*") do (
		echo %%a
		set "temp=%%a"
		set "dk_getFiles[!n!]=!temp:\=/!"
		set /a "n+=1"
	) 

	::### Return the array to the calling scope ###
	set "currentScope=1"
	for /F "delims=" %%b in ('set dk_getFiles[') do (
		if defined currentScope endlocal
		set "%%b"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_getFiles "C:/"
	%dk_call% dk_printVar dk_getFiles
	%dk_call% Array/dk_length dk_getFiles
	%dk_call% dk_echo "files %dk_length%"

	%dk_call% dk_set myPath "C:/Windows"
	%dk_call% dk_getFiles "%myPath%"
	%dk_call% dk_printVar dk_getFiles
	%dk_call% Array/dk_length dk_getFiles
	%dk_call% dk_echo "files %dk_length%"
%endfunction%
