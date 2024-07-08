@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_powershellEval(commands)
::#
::#
:dk_powershellEval
	call dk_debugFunc
	if %__ARGC__% GTR 1 call dk_error "%__FUNCTION__%(): too many arguments")
	
	
	setlocal
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	
	call dk_validate DKPOWERSHELL_DIR "call dk_validateBranch"
	if not exist "%DKPOWERSHELL_DIR%" call dk_error "%__FUNCTION__%(): could not locate DKPOWERSHELL_DIR"
	
	call dk_validate POWERSHELL_EXE "call %DKIMPORTS_DIR%\powershell\dk_installPowershell"
	if not exist "%POWERSHELL_EXE%"   call dk_error "%__FUNCTION__%(): could not locate POWERSHELL_EXE" 
    
    ::call dk_set DKCOMMAND "%~1"
	::call dk_replaceAll "%~1" "\" "/" DKCOMMAND
    ::call dk_set DKRETURN "%~2"
	::call dk_set DKVARS "%~3"
	
	::call dk_set DK_EVAL "%DKCMAKE_DIR%\DKEval.cmake"
	::call dk_replaceAll "%DKPOWERSHELL_DIR%\DKEval.cmake" "\" "/" DK_EVAL
	
	::### build POWERSHELL_ARGS ###

	:: append %DKCOMMAND% to POWERSHELL_ARGS with "'s removed
	::if defined DKCOMMAND  call set "POWERSHELL_ARGS=%POWERSHELL_ARGS%"-DDKCOMMAND=%%DKCOMMAND:"=%%""
	
	:: append %DKRETURN% to POWERSHELL_ARGS with "'s removed
	::if defined DKRETURN   call set "POWERSHELL_ARGS=%POWERSHELL_ARGS% "-DDKRETURN=%%DKRETURN:"=%%""
	
	:: append %DKVARS% to POWERSHELL_ARGS with "'s removed
	::if defined DKVARS     call set "POWERSHELL_ARGS=%POWERSHELL_ARGS% "%%DKVARS:"=%%""
	
	::set "POWERSHELL_ARGS=%POWERSHELL_ARGS% "--log-level=TRACE""
	
	::set "POWERSHELL_ARGS=%POWERSHELL_ARGS% >cmake_eval.out"
	
	::set "POWERSHELL_ARGS=%POWERSHELL_ARGS% 2>cmake_eval.err"
	
	call dk_set POWERSHELL_ARGS "%~1"
	echo POWERSHELL_ARGS = %POWERSHELL_ARGS%
	::call dk_printVar POWERSHELL_ARGS    ::FIXME
	
	::### call the cmake command
	::echo "%POWERSHELL_EXE%" %POWERSHELL_ARGS%
	"%POWERSHELL_EXE%" -Command %POWERSHELL_ARGS%

	::if not defined DKRETURN goto:eof
	::if not exist %DKPOWERSHELL_DIR%\powershell_vars.cmd goto:eof
    ::call %DKPOWERSHELL_DIR%\powershell_vars.cmd
	::del %DKPOWERSHELL_DIR%\powershell_vars.cmd

    ::call dk_printVar ERRORLEVEL

    :::: work with cmake return code files ::::
    :: std::out
::    set "out="
::    if exist "powershell_eval.out" (
::        for /f "Tokens=* Delims=" %%x in (powershell_eval.out) do (
::            set "out=!out!%%x"
::            echo %%x
::        )
::    )
    ::out contains all of the lines
    ::del powershell_eval.out
    ::echo %out%    

    :: std::err
::    set "err="
::    if exist "powershell_eval.err" (
::        for /f "Tokens=* Delims=" %%x in (powershell_eval.err) do (
::            set "err=!err!%%x"
::            echo [91m %%x [0m
::        )
::    )
    ::del powershell_eval.out
    ::err contains all of the lines
    ::echo %err%
	
	endlocal
    ::call dk_checkError
goto:eof




::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
:DKTEST
	call dk_debugFunc

	call dk_powershellEval "$PSVAR='this is a powershell variable'; Write-Output 'testing dk_powershellEval(): $PSVAR'"
goto:eof
