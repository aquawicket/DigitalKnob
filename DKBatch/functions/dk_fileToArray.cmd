@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_fileToArray(path rtn_var)
::#
::#  Read lines of a file into an array and echo them back
::#
::#  reference: https://stackoverflow.com/a/49042678
::#
:dk_fileToArray
    call dk_debugFunc 2
 setlocal
 
    ::set "file=%~1"
    set /a i=0
    for /F "usebackq delims=" %%a in ("%~f1") do (
        %if_NDK% call set "%~2[%%i%%]=%%a"      &:: FIXME: remove the need for call here
        %if_DK% set "%~2[!i!]=%%a"
        set /a i+=1
    )
    
    :: Return the array to the calling scope
    set "currentScope=1"
    for /F "delims=" %%a in ('set %~2[') do (
       if defined currentScope endlocal
       set "%%a"
    )
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    :: create the file
    dir /b /a-d > array.cmd

    %dk_call% dk_fileToArray "array.cmd" MyArray

    %dk_call% dk_printVar MyArray

    :: or print items individually
    %dk_call% dk_printVar MyArray[0]
    %dk_call% dk_printVar MyArray[1]
    %dk_call% dk_printVar MyArray[2]
    %dk_call% dk_printVar MyArray[3]
    %dk_call% dk_printVar MyArray[4]
    %dk_call% dk_printVar MyArray[5]
    %dk_call% dk_printVar MyArray[6]
    %dk_call% dk_printVar MyArray[7]
%endfunction%
