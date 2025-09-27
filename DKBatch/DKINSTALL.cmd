@echo off

::###### SETTINGS ######
set "CALLBACK=%~f0"


::###### CALLBACK ######
if "%~1" equ "" (goto DKINSTALL)
:CALLBACK
	title CALLBACK(%~0)
	
	::### Method_1: Call the arguments unaltered
::	set COMMAND=%*
	
	::### Method_2: Call get the arguments and call them
	if NOT EXIST "%DKSCRIPT_PATH%"	(set "DKSCRIPT_PATH=%~1")
	if NOT defined DKSCRIPT_ARGS	(for /F "usebackq tokens=1*" %%a in ('%*') do set DKSCRIPT_ARGS=%%b)
	set COMMAND="%DKSCRIPT_PATH%" %DKSCRIPT_ARGS%
	
	echo COMMAND = %COMMAND%
	call %COMMAND%
	echo CALLBACK
	pause

	::###### exit_code ######
	set "exit_code=%errorlevel%"
	echo %~nx0:CALLBACK exit_code = %exit_code%
	pause
	exit /b %exit_code%
%endfunction%


::###### INSTALL ######
:DKINSTALL
	::echo %~0(%*)
	if "%~1" neq "" (goto:eof)
	
	@echo off&::###### DK.cmd #########################################################################################################################
	if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
	::#################################################################################################################################################

	::###### Install DKBatch ######
	%dk_call% dk_echo "Installing DKBatch . . ."
	
	%dk_call% dk_validate cmd_exe					"%dk_call% dk_depend cmd_exe"
	::%dk_call% dk_validate tcc_exe					"%dk_call% dk_depend tcc-rt"
	%dk_call% dk_validate DKBATCH_FUNCTIONS_DIR_	"%dk_call% dk_DKBRANCH_DIR"

	::###### Set the registry entry for the extension ######
	::###### cmd.exe ######
	::## /A      		Causes the output of internal commands to a pipe or file to be ANSI
	::## /U      		Causes the output of internal commands to a pipe or file to be Unicode
	::## /Q      		Turns echo off
	::## /D      		Disable execution of AutoRun commands from registry (see below)
	::## /E:ON or /X 	Enable command extensions (see below)
	::## /E:OFF or /Y 	Disable command extensions (see below)
	::## /F:ON   		Enable file and directory name completion characters (see below)
	::## /F:OFF  		Disable file and directory name completion characters (see below)
	::## /V:ON   		Enable delayed environment variable expansion 
	::## /V:OFF  		Disable delayed environment expansion.
	::## /T:fg   		Sets the foreground/background colors (see COLOR /? for more info)
	::##
	::## /S      		Modifies the treatment of string after /C or /K (see below)	
	::## /C or /R		Carries out the command specified by string and then terminates
	::## /K      		Carries out the command specified by string but remains
	
	rem ###### Method 1: use callback
	ftype DKcmd="%cmd_exe:/=\%" /A /Q /D /E:ON /V:ON /C ^
	set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_FUNCTIONS_DIR_%" ^& ^
	call %CALLBACK% "%%1" %%*


	::###### Set icons and file association ######
	%dk_call% dk_registrySetKey "HKCR/DKcmd/DefaultIcon" "" "REG_SZ" "%cmd_exe%"
	assoc .cmd=DKcmd

	%dk_call% dk_success "DKcmd install complete"
%endfunction%
