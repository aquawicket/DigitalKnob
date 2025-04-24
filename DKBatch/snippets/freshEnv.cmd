<<<<<<< HEAD
@echo off
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


>>>>>>> Development
setlocal ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION
goto main

:SetFromReg
FOR /F "tokens=2,*" %%A IN ('REG query "%~1" /v "%~2"^|find /I "REG_"') DO (
    call set %~3=%%B
)
goto :EOF

:GetRegEnv
FOR /F %%A IN ('REG query "%~1" /s^|find /I "REG_"') DO (
<<<<<<< HEAD
    if /I not "%%~A"=="Path" call :SetFromReg "%~1" "%%~A" "%%~A"
=======
    if /I not "%%~A" equ "Path" call :SetFromReg "%~1" "%%~A" "%%~A"
>>>>>>> Development
)
goto :EOF

:InheritOrDelete
<<<<<<< HEAD
for %%A in (save_TEMP Path SystemRoot SystemDrive ProgramFiles CommonProgramFiles ALLUSERSPROFILE COMPUTERNAME LOGONSERVER USERNAME USERDOMAIN HOMEDRIVE HOMEPATH USERPROFILE APPDATA) do if /I "%%~A"=="%~1" goto :EOF
=======
for %%A in (save_TEMP Path SystemRoot SystemDrive ProgramFiles CommonProgramFiles ALLUSERSPROFILE COMPUTERNAME LOGONSERVER USERNAME USERDOMAIN HOMEDRIVE HOMEPATH USERPROFILE APPDATA) do if /I "%%~A" equ "%~1" goto :EOF
>>>>>>> Development
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
<<<<<<< HEAD
endlocal&if not "%Path%"=="" if not "%u%"=="" set Path=%Path%;%u%
=======
endlocal&if not "%Path%" equ "" if not "%u%" equ "" set Path=%Path%;%u%
>>>>>>> Development

REM Restore TEMP/TMP
set TEMP=%save_TEMP%
set save_TEMP=
set TMP=%TEMP%

REM start some command...
<<<<<<< HEAD
start cmd /d /k set
=======
start %ComSpec% /d /k set
>>>>>>> Development
