@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_cmakeEval(cmake_commands, return_variables, -DVARS)
::#
::#
:dk_cmakeEval
    %dk_call% dk_debugFunc 1 4
 ::setlocal

    %dk_call% dk_validate DKIMPORTS_DIR    "%dk_call% dk_DKIMPORTS_DIR"
    if not exist "%DKIMPORTS_DIR%"          %dk_call% dk_error "%__FUNCTION__%: could not locate DKIMPORTS_DIR"
    
    %dk_call% dk_validate DKCMAKE_DIR      "%dk_call% dk_DKBRANCH_DIR"
    if not exist "%DKCMAKE_DIR%"            %dk_call% dk_error "%__FUNCTION__%: could not locate DKCMAKE_DIR"

    %dk_call% dk_validate CMAKE_EXE        "%dk_call% %DKIMPORTS_DIR%\cmake\dk_install.cmd"
 	echo ##############TEST####################	
    if not exist "%CMAKE_EXE%"              %dk_call% dk_error "%__FUNCTION__%: could not locate CMAKE_EXE" 

    %dk_call% dk_replaceAll "%~1" "\" "/" DKCOMMAND
    ::%dk_call% dk_printVar DKCOMMAND
 
    %dk_call% dk_set DKRETURN "%~2"
    ::%dk_call% dk_printVar DKRETURN

    %dk_call% dk_set DKVARS "%~3"
    ::%dk_call% dk_printVar DKVARS
    
    %dk_call% dk_replaceAll "%DKCMAKE_DIR%\DKEval.cmake" "\" "/" DK_EVAL
    ::%dk_call% dk_printVar DK_EVAL
    
    ::### build CMAKE_ARGS ###
    :: append %DKCOMMAND% to CMAKE_ARGS with quotes removed
    if defined DKCOMMAND  call set CMAKE_ARGS=%CMAKE_ARGS% -DDKCOMMAND=%%DKCOMMAND:"=%% 
    
    :: append %DKRETURN% to CMAKE_ARGS with quotes removed
    if defined DKRETURN   call set CMAKE_ARGS=%CMAKE_ARGS% -DDKRETURN=%%DKRETURN:"=%%
    
    :: append %DKVARS% to CMAKE_ARGS with quotes removed
    if defined DKVARS     call set CMAKE_ARGS=%CMAKE_ARGS% %%DKVARS:"=%%
   
    ::set "CMAKE_ARGS=%CMAKE_ARGS% -DDKCMAKE_FUNCTIONS_DIR="%DKCMAKE_FUNCTIONS_DIR%""
	set CMAKE_ARGS=%CMAKE_ARGS% -DDKCMAKE_FUNCTIONS_DIR_=%DKCMAKE_FUNCTIONS_DIR_%
    set CMAKE_ARGS=%CMAKE_ARGS% -P
    set CMAKE_ARGS=%CMAKE_ARGS% %DK_EVAL%
    ::set "CMAKE_ARGS=%CMAKE_ARGS% "--log-level=TRACE""
    ::set "CMAKE_ARGS=%CMAKE_ARGS% >cmake_eval.out"
    ::set "CMAKE_ARGS=%CMAKE_ARGS% 2>cmake_eval.err"
  
    ::### call the cmake command ###
    echo "%CMAKE_EXE%" %CMAKE_ARGS%
    "%CMAKE_EXE%" %CMAKE_ARGS%



::	###### IMPORT VARIABLES ######
    if not defined DKRETURN %return%
	%dk_call% dk_importVars
	
	
	
::  ## these lines are deprecated ###
::  if not defined DKRETURN %return%
::  if not exist %DKCMAKE_DIR%\cmake_vars.cmd %return%
::   
::  endlocal
::  %dk_call% %DKCMAKE_DIR%\cmake_vars.cmd
::  del %DKCMAKE_DIR%\cmake_vars.cmd

    ::%dk_call% dk_printVar ERRORLEVEL

    :::: work with cmake return code files ::::
    :: std::out
::    set "out="
::    if exist "cmake_eval.out" (
::        for /f "Tokens=* Delims=" %%x in (cmake_eval.out) do (
::            set "out=!out!%%x"
::            echo %%x
::        )
::    )
    ::out contains all of the lines
    ::del cmake_eval.out
    ::echo %out%    

    :: std::err
::    set "err="
::    if exist "cmake_eval.err" (
::        for /f "Tokens=* Delims=" %%x in (cmake_eval.err) do (
::            set "err=!err!%%x"
::            echo [91m %%x [0m
::        )
::    )
    ::del cmake_eval.out
    ::err contains all of the lines
    ::echo %err%
      
    ::%dk_call% dk_checkError
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_cmakeEval "dk_info('test dk_info message')"
%endfunction%
