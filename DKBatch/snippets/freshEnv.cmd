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


setlocal ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION
goto main

:SetFromReg
FOR /F "tokens=2,*" %%A IN ('REG query "%~1" /v "%~2"^|find /I "REG_"') DO (
    call set %~3=%%B
)
goto :EOF

:GetRegEnv
FOR /F %%A IN ('REG query "%~1" /s^|find /I "REG_"') DO (
    if /I NOT "%%~A" equ "Path" call :SetFromReg "%~1" "%%~A" "%%~A"
)
goto :EOF

:InheritOrDelete
for %%A in (save_TEMP Path SystemRoot SystemDrive ProgramFiles CommonProgramFiles ALLUSERSPROFILE COMPUTERNAME LOGONSERVER USERNAME USERDOMAIN HOMEDRIVE HOMEPATH USERPROFILE APPDATA) do if /I "%%~A" equ "%~1" goto :EOF
set %~1=
goto :EOF

:main
REM Save temp
set save_TEMP=%temp%
if NOT defined save_TEMP set save_TEMP=%tmp%

for /F "delims==" %%A in ('set') do call :InheritOrDelete "%%~A"
call :GetRegEnv "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
call :GetRegEnv "HKCU\Environment"

REM Special handling for Path
call :SetFromReg "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" Path Path
setlocal
set u=
call :SetFromReg "HKCU\Environment" Path u
endlocal&if "%Path%" neq "" if "%u%" neq "" set Path=%Path%;%u%

REM Restore TEMP/TMP
set TEMP=%save_TEMP%
set save_TEMP=
set TMP=%TEMP%

REM start some command...
start %ComSpec% /d /k set