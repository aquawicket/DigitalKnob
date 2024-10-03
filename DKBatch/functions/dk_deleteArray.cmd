@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_deleteArray(array)
::#
::#
:dk_deleteArray
    call dk_debugFunc 1
 setlocal
 
    set /A "n=0"
    :loop1 
    if defined %~1[%n%] (
        set "%~1[%n%]="
        set /A n+=1
        goto loop1 
    )

    if defined %~1[0] %dk_call% dk_error "%__FUNCTION__%(): failed to delete array"
    :: DOSTIPS version
    :: :remove_array
    :: for /f "delims==" %%a in ('"set %~1[ 2>NUL"') do set "%%a="
    :: EXIT /b
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_deleteArray
%endfunction%
