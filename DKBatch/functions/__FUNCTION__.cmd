@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::############################################################################
::# __FUNCTION__(frame)
::#
:__FUNCTION__
    %dk_call% dk_debugFunc
 setlocal
 
    if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
    ::set /A _FRAME_+=1

::  call dk_return "%FUNCNAME[%_FRAME_%]%"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal
 
    echo __FUNCTION__ = %__FUNCTION__%
%endfunction%
