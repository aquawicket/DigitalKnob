@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


setlocal ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION
goto main

:SetFromReg
FOR /F "tokens=2,*" %%A IN ('REG query "%~1" /v "%~2"^|find /I "REG_"') DO (
    call set %~3=%%B
)
goto :EOF

:GetRegEnv
FOR /F %%A IN ('REG query "%~1" /s^|find /I "REG_"') DO (
    if /I not "%%~A" equ "Path" call :SetFromReg "%~1" "%%~A" "%%~A"
)
goto :EOF

:InheritOrDelete
for %%A in (save_TEMP Path SystemRoot SystemDrive ProgramFiles CommonProgramFiles ALLUSERSPROFILE COMPUTERNAME LOGONSERVER USERNAME USERDOMAIN HOMEDRIVE HOMEPATH USERPROFILE APPDATA) do if /I "%%~A" equ "%~1" goto :EOF
set %~1=
goto :EOF

:main
REM Save temp
set save_TEMP=%temp%
if not defined save_TEMP set save_TEMP=%tmp%

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