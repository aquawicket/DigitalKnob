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
rem # dk_printFileLines(file)
rem #
rem #
:dk_printFileLines
setlocal disableDelayedexpansion

	set "file=%~1"
	
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	for /f "tokens=*" %%a in ('%findstr.exe% /n .* "%file:/=\%"') do (
		set "FullLine=%%a"
		for /f "tokens=1* delims=:" %%b in ("%%a") do (
			call set "LineData=%%FullLine:*:=%%
			call echo.%%b: %%LineData%%
		)
	)
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_printFileLines "%~dp0/dk_ascii2.cmd"
%endfunction%

