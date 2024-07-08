@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_cmakeEval(cmake_commands, return_variables, -DVARS)
::#
::#
:dk_cmakeEval
	call dk_debugFunc
	if %__ARGC__% GTR 4 (call dk_error "%__FUNCTION__%(): too many arguments")
	
	
	setlocal
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	::call dk_printVar DKIMPORTS_DIR
	if not exist "%DKCMAKE_DIR%" call dk_error "%__FUNCTION__%(): could not locate DKIMPORTS_DIR"
	
	call dk_validate DKCMAKE_DIR "call dk_validateBranch"
	::call dk_printVar DKCMAKE_DIR
	if not exist "%DKCMAKE_DIR%" call dk_error "%__FUNCTION__%(): could not locate DKCMAKE_DIR"
	
	::call dk_validate CMAKE_EXE "call dk_installCmake"
	call dk_validate CMAKE_EXE "call %DKIMPORTS_DIR%\cmake\dk_InstallCmake"
	call dk_printVar CMAKE_EXE
	if not exist "%CMAKE_EXE%"   call dk_error "%__FUNCTION__%(): could not locate CMAKE_EXE" 
    
    ::call dk_set DKCOMMAND "%~1"
	call dk_replaceAll "%~1" "\" "/" DKCOMMAND
	call dk_printVar DKCOMMAND
	
    call dk_set DKRETURN "%~2"
	call dk_printVar DKRETURN
	
	call dk_set DKVARS "%~3"
	call dk_printVar DKVARS
	
	::call dk_set DK_EVAL "%DKCMAKE_DIR%\DKEval.cmake"
	call dk_replaceAll "%DKCMAKE_DIR%\DKEval.cmake" "\" "/" DK_EVAL
	call dk_printVar DK_EVAL
	
	::### build CMAKE_ARGS ###

	:: append %DKCOMMAND% to CMAKE_ARGS with "'s removed
	if defined DKCOMMAND  call set "CMAKE_ARGS=%CMAKE_ARGS%"-DDKCOMMAND=%%DKCOMMAND:"=%%""
	
	:: append %DKRETURN% to CMAKE_ARGS with "'s removed
	if defined DKRETURN   call set "CMAKE_ARGS=%CMAKE_ARGS% "-DDKRETURN=%%DKRETURN:"=%%""
	
	:: append %DKVARS% to CMAKE_ARGS with "'s removed
	if defined DKVARS     call set "CMAKE_ARGS=%CMAKE_ARGS% "%%DKVARS:"=%%""
	
	set "CMAKE_ARGS=%CMAKE_ARGS% "-P""
	
	set "CMAKE_ARGS=%CMAKE_ARGS% "%DK_EVAL%""
	
	::set "CMAKE_ARGS=%CMAKE_ARGS% "--log-level=TRACE""
	
	::set "CMAKE_ARGS=%CMAKE_ARGS% >cmake_eval.out"
	
	::set "CMAKE_ARGS=%CMAKE_ARGS% 2>cmake_eval.err"
	
	echo CMAKE_ARGS = %CMAKE_ARGS%
	::call dk_printVar CMAKE_ARGS    ::FIXME
	
	::### call the cmake command
	::echo "%CMAKE_EXE%" %CMAKE_ARGS%
	"%CMAKE_EXE%" %CMAKE_ARGS%

	if not defined DKRETURN goto:eof
	if not exist %DKCMAKE_DIR%\cmake_vars.cmd goto:eof
    call %DKCMAKE_DIR%\cmake_vars.cmd
	del %DKCMAKE_DIR%\cmake_vars.cmd

    ::call dk_printVar ERRORLEVEL

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
	
	endlocal
    ::call dk_checkError
goto:eof




::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_cmakeEval "dk_info('test dk_info message'); dk_warning('test dk_info message')"
goto:eof
