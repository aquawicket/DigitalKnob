@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_stacktrace()
::#
::#
:dk_stacktrace
    call dk_debugFunc 0
 setlocal
 
    ::echo DKSTACK_length = %DKSTACK_length%
    ::echo DKSTACK_marker = %DKSTACK_marker%
    set /a dk_stacktrace_count=%DKSTACK_length%-1
    ::set /a dk_stacktrace_marker=%DKSTACK_marker%
    set /a dk_stacktrace_marker=%dk_stacktrace_count%
    ::echo dk_stacktrace_marker = %dk_stacktrace_marker%
    
    :dk_stacktrace_Loop
        ::set "OUTPUT="[%dk_stacktrace_count%]  %%DKSTACK[%dk_stacktrace_marker%].__FILE__%%   %%DKSTACK[%dk_stacktrace_marker%].__FUNCTION__%%    %%DKSTACK[%dk_stacktrace_marker%].__ARGS__%%"
        %dk_call% dk_textFormat OUTPUT "[%dk_stacktrace_count%]"  "%%DKSTACK[%dk_stacktrace_marker%].__FILE__%%"  "%%DKSTACK[%dk_stacktrace_marker%].__FUNCTION__%%"  "%%DKSTACK[%dk_stacktrace_marker%].__ARGS__%%"
        %dk_call% echo %OUTPUT%
        set /a dk_stacktrace_count-=1
        
        set /a dk_stacktrace_marker=%dk_stacktrace_count%
        ::if "%dk_stacktrace_marker%" equ "0" (
        ::  set /a dk_stacktrace_marker=%DKSTACK_length%
        ::) else (
        ::  set /a dk_stacktrace_marker-=1
        ::)
    if %dk_stacktrace_count% GEQ 0 goto dk_stacktrace_Loop
    
    echo done
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_debug "test putting a function on the stack"
    echo 0 = %0
    echo ~f0 = %~f0
    echo ~nx0 = %~nx0
    %dk_call% :func1 abc
%endfunction%

:func1
    call dk_debugFunc 0
    echo 0 = %0
    echo ~f0 = %~f0
    echo ~nx0 = %~nx0
    %dk_call% :func2 123
%endfunction%

:func2 
    call dk_debugFunc 0
    echo 0 = %0
    echo ~f0 = %~f0
    echo ~nx0 = %~nx0
    %dk_call% :func3 x y z
%endfunction%

:func3
    call dk_debugFunc 0
    echo 0 = %0
    echo ~f0 = %~f0
    echo ~nx0 = %~nx0
    pause
    %dk_call% dk_stacktrace
%endfunction%
