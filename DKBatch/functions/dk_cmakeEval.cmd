@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ################################################################################
rem # dk_cmakeEval(cmake_commands, return_variables, -DVARS)
rem #
:dk_cmakeEval
rem %setlocal%

	%dk_call% dk_validate DKIMPORTS_DIR		%dk_call% dk_DKIMPORTS_DIR
	%dk_call% dk_assertPath DKIMPORTS_DIR

	%dk_call% dk_validate DKCMAKE_DIR		%dk_call% dk_DKBRANCH_DIR
	%dk_call% dk_assertPath DKCMAKE_DIR

	set DKCOMMAND=%~1
	if "%~2" neq "" (%dk_call% dk_set DKRETURN "%~2")
	if "%~3" neq "" (%dk_call% dk_set DKVARS "%~3")
	%dk_call% dk_set DK_EVAL "%DKCMAKE_DIR:\=/%/DKEval.cmake"

	rem ### build CMAKE_ARGS ###
	rem append %DKCOMMAND% to CMAKE_ARGS with quotes removed
rem	if defined DKCOMMAND  (call set CMAKE_ARGS=%CMAKE_ARGS% -DDKCOMMAND=%%DKCOMMAND:"=%%)
	if defined DKCOMMAND  set CMAKE_ARGS=%CMAKE_ARGS% "-DDKCOMMAND=%DKCOMMAND:\=/%"

	rem append %DKRETURN% to CMAKE_ARGS with quotes removed
rem	if defined DKRETURN   (call set CMAKE_ARGS=%CMAKE_ARGS% -DDKRETURN=%%DKRETURN:"=%%)
	if defined DKRETURN   set CMAKE_ARGS=%CMAKE_ARGS% "-DDKRETURN=%DKRETURN%"
	
	rem append %DKVARS% to CMAKE_ARGS with quotes removed
rem	if defined DKVARS	 (call set CMAKE_ARGS=%CMAKE_ARGS% %%DKVARS:"=%%)
	if defined DKVARS	 set CMAKE_ARGS=%CMAKE_ARGS% %DKVARS%

	rem set "CMAKE_ARGS=%CMAKE_ARGS% -DDKCMAKE_FUNCTIONS_DIR="%DKCMAKE_FUNCTIONS_DIR%""
	set CMAKE_ARGS=%CMAKE_ARGS% "-DDKCMAKE_FUNCTIONS_DIR_=%DKCMAKE_FUNCTIONS_DIR_:\=/%"
	set CMAKE_ARGS=%CMAKE_ARGS% -P
	set CMAKE_ARGS=%CMAKE_ARGS% %DK_EVAL%
	rem set "CMAKE_ARGS=%CMAKE_ARGS% "--log-level=TRACE""
	rem set "CMAKE_ARGS=%CMAKE_ARGS% >cmake_eval.out"
	rem set "CMAKE_ARGS=%CMAKE_ARGS% 2>cmake_eval.err"

	rem ### call the cmake command ###
	echo cmake.exe %CMAKE_ARGS%
	%dk_call% cmake.exe %CMAKE_ARGS%

	rem ###### IMPORT VARIABLES ######
	if NOT defined DKRETURN (%return%)
	%dk_call% dk_loadCache

rem  ## these lines are deprecated ###
rem  if NOT defined DKRETURN %return%
rem  if NOT EXIST "%DKCMAKE_DIR%\cmake_vars.cmd" (%return%)
rem  
rem  endlocal
rem  %dk_call% %DKCMAKE_DIR%\cmake_vars.cmd
rem  del %DKCMAKE_DIR%\cmake_vars.cmd

	rem %dk_call% dk_printVar ERRORLEVEL

	rem ###### work with cmake return code files ######
	rem std::out
rem	set "out="
rem	if EXIST "cmake_eval.out" (
rem		for /f "Tokens=* Delims=" %%x in (cmake_eval.out) do (
rem			set "out=!out!%%x"
rem			echo %%x
rem		)
rem	)
	rem out contains all of the lines
	rem del cmake_eval.out
	rem echo %out%	

	rem std::err
rem	set "err="
rem	if EXIST "cmake_eval.err" (
rem		for /f "Tokens=* Delims=" %%x in (cmake_eval.err) do (
rem			set "err=!err!%%x"
rem			echo [91m %%x [0m
rem		)
rem	)
	rem del cmake_eval.out
	rem err contains all of the lines
	rem echo %err%
	 
	rem %dk_call% dk_checkError
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_cmakeEval "dk_test('test dk_info message')" "return_valueA;return_valueB"
	echo return_valueA = %return_valueA%
	echo return_valueB = %return_valueB%
%endfunction%
