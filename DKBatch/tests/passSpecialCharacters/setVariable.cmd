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


:setVariable name value
::setlocal	
	echo setVariable INPUT: %*
	set args=%*
	::set args=%args:<=^<%
	::set args=%args:<=^^<%
	for %%x in (%args%) do (
		echo %~1 %%~x
		call :setargs %1 %%x
	)
	endlocal & %PRINT_DE_STATUS%
	pause
	goto :end
	:setargs
		echo %~1 %~2
		if "%~1" neq "%~2" set args=%args% %~2
		goto:eof
	:end
	echo args = %args%
	
	
	
	call set args=%%args:%~1 =%%
	set args=%args:^^=^%
	
	
	::if %args:~0,1%%args:~-1%=="" (set "%~1=%args:~1,-1%")
	

setlocal enableDelayedExpansion
	echo setVariable OUTPUT: %~1 = '!%~1!'
%endfunction%
