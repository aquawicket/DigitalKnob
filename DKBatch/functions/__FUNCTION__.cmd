@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# __FUNCTION__(frame)
::#
:__FUNCTION__
%setlocal%
    %dk_call% dk_debugFunc 0 1

    if "%~1" equ "" (set "_FRAME_=0") else (set "_FRAME_=%~1")
    ::set /a _FRAME_+=1

::  %dk_call% dk_return "%FUNCNAME[%_FRAME_%]%"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    echo __FUNCTION__ = %__FUNCTION__%
%endfunction%
