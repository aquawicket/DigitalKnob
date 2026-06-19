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
	if "%~1" neq "" (goto:eof)
	
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

	::###### Install DKBatch ######
	%dk_call% dk_echo "Installing DKBatch . . ."
	
	::%dk_call% dk_validate cmd.exe					%dk_call% dk_depend cmd
	%dk_call% dk_validate tcc_exe					%dk_call% dk_depend tcc-rt
	%dk_call% dk_validate DKBATCH_FUNCTIONS_DIR_	%dk_call% dk_DKBRANCH_DIR

	::###### Set the registry entry for the extension ######
	::###### tcc.exe ######
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
	ftype DKtcc="%tcc_exe:/=\%" /A /Q /D /E:ON /V:ON /C ^
	set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_FUNCTIONS_DIR_:/=\%" ^& ^
	call %CALLBACK% "%%1" %%*


	::###### Set icons and file association ######
	%dk_call% dk_registrySetKey "HKCR/DKcmd/DefaultIcon" "" "REG_SZ" "%tcc_exe%"
	assoc .cmd=DKtcc

	%dk_call% dk_success "DKtcc install complete"
%endfunction%
