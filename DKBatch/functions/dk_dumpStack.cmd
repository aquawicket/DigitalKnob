@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::https://stackoverflow.com/a/11576816

set "func=%~0"
for /F "delims=\" %%X in ("%func:*\=%") do set "func=%%X"
if ":" == "%func:~0,1%" ( goto %func% )

if not defined frame (set /a frame=0)
if "%*" neq "" %dk_call% dk_error "%__FUNCTION__%(): too many arguments"

:dk_dumpStack
    call dk_debugFunc 1 99
 ::setlocal
(   
    setlocal DisableDelayedExpansion
    if %frame% neq 0 (goto) 2>nul & (goto) 2>nul
    
    echo #################################################
    set /a "frame=%frame%"
    set "_returnVar=%~1"

    
    &:: FIXME: remove the need for calls here
    call set "caller[%frame%]=%%~0"
    call set "caller[%frame%].fullpath=%%~f0"
    call set "caller[%frame%].directory=%%~dp0"
    call set "caller[%frame%].filename=%%~nx0"
    call set "caller[%frame%].func=%%~n0"
    call set "caller[%frame%].args=%%*"

    call set "caller=%%~0"
    call set "caller.fullpath=%%~f0"
    call set "caller.directory=%%~dp0"
    call set "caller.filename=%%~nx0"
    call set "caller.func=%%~n0"
    call set "DKTEST_caller=:DKTEST_%%~n0"
    call set "caller.args=%%*"
    
    echo caller                         = %caller%
    echo caller.fullpath                = %caller.fullpath%
    echo caller.directory               = %caller.directory%
    echo caller.filename                = %caller.filename%
    echo caller.func                    = %caller.func%
    echo DKTEST_caller                  = %DKTEST_caller%
    echo caller.args                    = %caller.args%
    call set _caller=%%caller[%frame%].fullpath:*%%~f0=%%
    echo _caller                        = %_caller%
    
    
    call echo caller[%frame%]           = %%caller[%frame%]%%
    call echo caller[%frame%].fullpath  = %%caller[%frame%].fullpath%%
    call echo caller[%frame%].directory = %%caller[%frame%].directory%%
    call echo caller[%frame%].filename  = %%caller[%frame%].filename%%
    call echo caller[%frame%].func      = %%caller[%frame%].func%%
    call echo caller[%frame%].args      = %%caller[%frame%].args%%
    
    
    echo "%caller%" = "%DKTEST_caller%"
    if "%caller%"=="%DKTEST_caller%" (echo THEY ARE EQUAL!)
    
    if "%caller%"=="" (
        call dk_debug "CALLER IS EMPTY"
        setlocal DisableDelayedExpansion
        set /a frame+=1
        call "%~d0\:dk_dumpStack\..%~pnx0" %*
    ) else if "%caller%" neq "%DKTEST_caller%" (
        call dk_debug "CALLER neq DKTEST AND CALLER neq CALLERFUNC"
        setlocal DisableDelayedExpansion
        set /a frame+=1
        call "%~d0\:dk_dumpStack\..%~pnx0" %*
    ) else (
        echo LEAVING
        if defined _caller (
            set "caller[%frame%].type=batch"
            call "%~d0\:call_return\..%~pnx0" %*
        ) else (
            set "caller[%frame%].type=cmd-line"
            %ComSpec% /c "call "%~d0\:call_return\..%~pnx0" %*"
        )
        endlocal
    )
)
%endfunction%

:call_return
	::call dk_dkebugFunc 0
 ::setlocal	
 
    call :dk_dumpStackReturn
%endfunction%

:dk_dumpStackReturn
	::call dk_dkebugFunc 0
 ::setlocal	
 
    endlocal
    %caller[1].fullpath% %caller[1].args%
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 ::setlocal
 
    call :DKTEST_main
    %endfunction%

    :DKTEST_main
        call :DKTEST_dk_dumpStack
    %endfunction%

    :DKTEST_dk_dumpStack
        %dk_call% dk_info ":DKTEST  %*"
        call:func1
        
        %dk_call% dk_info "caller[0] = %caller[0]%"
        %dk_call% dk_info "caller[1] = %caller[1]%"
        %dk_call% dk_info "caller[2] = %caller[2]%"
        %dk_call% dk_info "caller[3] = %caller[3]%"
        %dk_call% dk_info "caller[4] = %caller[4]%"
        %dk_call% dk_info "caller[5] = %caller[5]%"
        %dk_call% dk_info "caller[6] = %caller[6]%"
        %dk_call% dk_info "caller[7] = %caller[7]%"
        %dk_call% dk_info "returned from :DKTEST"
        
        %dk_call% dk_exit
    %endfunction%

    :func1
        %dk_call% dk_info ":func1 %*"
        call:func2
        %dk_call% dk_info "returned from func2"
        ::call:func2 & (
        ::  (goto) 2>nul
        ::  call echo 0 = %%~0
        ::  echo returned from func2
        ::)
    %endfunction%

    :func2
        %dk_call% dk_info ":func2 %*"
        call:func3
        %dk_call% dk_info "returned from func3"
    %endfunction%

    :func3
        %dk_call% dk_info ":func3 %*"
        call:func4
        %dk_call% dk_info "returned from func4"
    %endfunction%

    :func4
        %dk_call% dk_info ":func4 %*"
        call:func5 orange
        %dk_call% dk_info "returned from func5"
    %endfunction%

    :func5
        %dk_call% dk_info ":func5 %*"
        %dk_call% dk_dumpStack
        :dk_dumpStackReturn
        %dk_call% dk_info "returned from dk_dumpStack dumpstack_caller"
    %endfunction%
%endfunction%
