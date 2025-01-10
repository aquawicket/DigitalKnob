@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_getFiles(path rtn_var)
::#
::#   reference: https://stackoverflow.com/a/138581
::#
:dk_getFiles
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 1

    set /a i=0
    for %%a in ("%~1\*") do (
        set "dk_getFiles[!i!]=%%a"
        set /a i+=1
    ) 

    :: Return the array to the calling scope
    set "currentScope=1"
    for /F "delims=" %%a in ('set dk_getFiles[') do (
       if defined currentScope endlocal
       set "%%a"
    )
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_set myPath "C:\Windows"
    %dk_call% dk_getFiles "%myPath%"
    %dk_call% dk_printVar dk_getFiles
%endfunction%
