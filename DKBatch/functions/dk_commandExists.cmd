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
rem # dk_commandExists(<command> rtn_var)
rem #
:dk_commandExists
%setlocal%

    %ComSpec% /c "(help %~1 > nul || exit 0) && where %~1 > nul 2> nul"
   
    if %ERRORLEVEL% equ 0 (
		set "dk_commandExists=0"
    ) else (
		set "dk_commandExists=1"
	)
   
	:return
	endlocal & (
		set "dk_commandExists=%dk_commandExists%"
		if "%~2" neq "" (
			set "%~2=%dk_commandExists%"
		) else (
			echo %dk_commandExists%
		)
	)
	exit /b %dk_commandExists%
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    rem ###### Using if return value
    %dk_call% dk_echo
   
    %dk_call% dk_set _command_ echo
    %dk_call% dk_commandExists "%_command_%" result
    if /i "%result%" equ "0" (echo %_command_% exists) else (echo %_command_% NOT FOUND)
   
    %dk_call% dk_set _command_ NonExistentCommand
    %dk_call% dk_commandExists "%_command_%" result
    if /i "%result%" equ "0" (echo %_command_% exists) else (echo %_command_% NOT FOUND)
    rem FIXME: ERRORLEVEL is still 1
   
   
    rem ###### Using if ERRORLEVEL
    %dk_call% dk_echo
   
    %dk_call% dk_set _command_ echo
    %dk_call% dk_commandExists "%_command_%"
    if NOT ERRORLEVEL 1 (echo %_command_% exists) else (echo %_command_% NOT FOUND)
   
    %dk_call% dk_set _command_ NonExistentCommand
    %dk_call% dk_commandExists "%_command_%"
    if NOT ERRORLEVEL 1 (echo %_command_% exists) else (echo %_command_% NOT FOUND)
    rem FIXME: ERRORLEVEL is still 1
   
   
    rem ###### Using && and || conditionals
    %dk_call% dk_echo
   
    %dk_call% dk_set _command_ echo
    %dk_call% dk_commandExists "%_command_%" && (echo %_command_% exists) || (echo %_command_% NOT FOUND)
   
    %dk_call% dk_set _command_ NonExistentCommand  
    %dk_call% dk_commandExists "%_command_%" && (echo %_command_% exists) || (echo %_command_% NOT FOUND)
    rem FIXME: ERRORLEVEL is still 1
%endfunction%  
    