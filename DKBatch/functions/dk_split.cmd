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

rem ####################################################################
rem # dk_split("string")
rem #
rem #		https://stackoverflow.com/a/33131797/688352
rem #		https://www.dostips.com/forum/viewtopic.php?f=3&t=6429
rem # 
:dk_split
%setlocal%

	set "str=%~1"
	rem set "output=%~2"

	set i=1
	set "dk_split!i!=%str:;=" & set /a i+=1 & set "dk_split!i!=%"
	rem set %dk_split%
	
	rem Return the list to the calling scope
	set "_SCOPE_=%~n0"
	for /F "delims=" %%a in ('set dk_split') do (
		if "%_SCOPE_%" equ "%~n0" endlocal
		set "%%a"
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	set "myString=abc;123;def;456;ghi;789;jkl"
	echo myString = %myString%
	echo.
	call :dk_split "%myString%"

	set "dk_split"
%endfunction%
