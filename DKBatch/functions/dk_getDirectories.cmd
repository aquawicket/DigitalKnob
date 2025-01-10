@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_getDirectories(path rtn_var)
::#
::#   reference: https://stackoverflow.com/a/138581
::#
:dk_getDirectories
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 1
	
	set "_path_=%~1"
	set "_path_=%_path_:/=\%"

	%dk_call% dk_assertPath "%_path_%"

    set /a "i=0"
    for /d %%a in ("%_path_%\*") do (
		echo %%a
        set "dk_getDirectories[!i!]=%%a"
        set /a "i+=1"
    ) 

    :: Return the array to the calling scope
    set "currentScope=1"
    for /F "delims=" %%b in ('set dk_getDirectories[') do (
       if defined currentScope endlocal
       set "%%b"
    )

::	DEBUG
::	%dk_call% dk_printVar %~2
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_set myPath "C:\Windows"
    %dk_call% dk_getDirectories "%myPath%"
    %dk_call% dk_printVar dk_getDirectories
%endfunction%
    