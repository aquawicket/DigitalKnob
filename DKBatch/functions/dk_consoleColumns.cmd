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


rem ############################################################################
rem # dk_consoleColumns(columns)
rem #
rem #
:dk_consoleColumns
%setlocal%
 
	rem ###### SET ######
	if "%~1" neq "" (
		mode con cols=%~1
		set /a "dk_consoleColumns=%~1"

	rem ###### GET ######
	) else (
		%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
		for /f "tokens=1,2,3,4,5,6,7,8,9 delims=, " %%G in (
			'mode con^|!findstr.exe! /C:Columns:'
		) do (
			set /a "dk_consoleColumns=%%H"
		)
	)
		
	endlocal & (
		set "dk_consoleColumns=%dk_consoleColumns%"
	)
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_consoleColumns
	%dk_call% dk_echo "dk_consoleColumns = %dk_consoleColumns%"
	
	%dk_call% dk_echo "Resizing the width of the console +5 columns"
	%dk_call% dk_sleep 3
	set /a "Columns=%dk_consoleColumns%+5
	%dk_call% dk_consoleColumns %Columns%
	%dk_call% dk_echo "dk_consoleColumns = %dk_consoleColumns%"

%endfunction%

