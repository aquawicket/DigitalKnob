@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_getDirectories(path rtn_var)
::#
::#   reference: https://stackoverflow.com/a/138581
::#
:dk_getDirectories
    call dk_debugFunc 2
 setlocal
	%dk_call% dk_assertPath "%~1"
 
	::%dk_call% dk_verbose "dk_getDirectories[%~1, %~2]"
    %dk_call% dk_replaceAll "%~1" "/" "\" _path_
    set /A i=0

    for /d %%a in ("%_path_%\*") do (
        if "!DE!" equ "" set "%~2[!i!]=%%a"
        if "!DE!" neq "" call set "%~2[%%i%%]=%%a"
        set /A i+=1
    ) 

    :: Return the array to the calling scope
    set "currentScope=1"
    for /F "delims=" %%a in ('set %~2[') do (
       if defined currentScope endlocal
       set "%%a"
    )

%DEBUG%
	%dk_call% dk_printVar %~2
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_set myPath "C:\Windows"
    %dk_call% dk_getDirectories "%myPath%" directories
    %dk_call% dk_printVar directories
%endfunction%
    