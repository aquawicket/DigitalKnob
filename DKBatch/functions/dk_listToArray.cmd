@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_listToArray(<list> rtn_var)
::#
::#
:dk_listToArray
 setlocal
    call dk_debugFunc 2
    
    set "_list=%~1"
    if "!DE!" neq "" if defined %_list% call set _list=%%_list%%
    if "!DE!" equ "" if defined !_list! set _list=!%_list%!

    set /A i=0
    for %%a in (%_list%) do (
        if "!DE!" neq "" call set "%~2[%%i%%]=%%a"
        if "!DE!" equ "" set "%~2[!i!]=%%a"
        set /A i+=1
    ) 
    
    rem Return the array to the calling scope
    set "currentScope=1"
    for /F "delims=" %%a in ('set %~2[') do (
       if defined currentScope endlocal
       set "%%a"
    )
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0

    %dk_call% dk_set myList "a,b,c,d,e,f,g"
    %dk_call% dk_listToArray "%myList%" myArray
    %dk_call% dk_printVar myArray
%endfunction%
