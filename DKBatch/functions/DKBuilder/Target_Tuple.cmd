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


rem #####################################################################
rem # Target_Tuple()
rem #
rem #	  Target_Tuple = Target_Os, Target_Arch and Target_Env concatenate with underscores
rem #
:Target_Tuple
%setlocal%

	rem ###### SET ######
	if "%~1" neq "" (
		set "Target_Tuple=%~1"
	
	rem ###### GET ######	
	) else if NOT defined Target_Tuple (
		%dk_call% dk_validate Target_Os		%dk_call% DKBuilder/Target_Os
		%dk_call% dk_validate Target_Arch	%dk_call% DKBuilder/Target_Arch
		%dk_call% dk_validate Target_Env	%dk_call% DKBuilder/Target_Env
		set "Target_Tuple=!Target_Os!_!Target_Arch!_!Target_Env!"
	)
	
	endlocal & (
		set "Target_Tuple=%Target_Tuple%"
		set "%Target_Tuple%=1"
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem ###### GET ######
    %dk_call% Target_Tuple
	%dk_call% dk_debug "Target_Tuple = %Target_Tuple%"
	%dk_call% dk_debug "%Target_Tuple% = !%Target_Tuple%!"
	
	rem ###### SET ######
	%dk_call% Target_Tuple "Windows_X86_64_Clang"
	%dk_call% dk_debug "Target_Tuple = %Target_Tuple%"
	%dk_call% dk_debug "%Target_Tuple% = !%Target_Tuple%!"
	
%endfunction%