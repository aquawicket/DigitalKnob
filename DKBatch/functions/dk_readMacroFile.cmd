@echo off

@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b !errorlevel!
)
rem #################################################################################################################################################

:dk_readMacroFile
setlocal DisableDelayedExpansion
(set LF=^
%=Do not remove this line=%
)
set ^"\n=^^^%LF%%LF%^%LF%%LF%^^"


set ^"template=for %%# in (1 2) do if %%#==2 (%\n%
    setlocal EnableDelayedExpansion%\n%
    rem set "this=!this!"%\n%
    echo this = !this!%\n%
     set "!this!_argv=!argv:~1!"%\n%
    call set "_argv="%%!this!_file%%" !argv!"%\n%
    set "argc=0"%\n%
    for %%C in (!_argv!) do set "_argv_=!_argv_!;%%C" ^& set "!this!_argv!argc!=%%C" ^& set /a argc+=1 %\n%
    set /a "argc-=1"%\n%
    set "!this!_argc=!argc!"%\n%
    call echo !this!_argv = '%%!this!_argv%%'%\n%
    call echo !this!_argc = '%%!this!_argc%%'%\n%
    for /L %%n in (0 1 !argc!) do (%\n%
      call echo !this!_argv%%n = '%%!this!_argv%%n%%'%\n%
    )%\n%
    FOR /F "usebackq tokens=1-20 delims=;" %%0 IN ('!_argv_!') do (%\n%
    FOR /F "delims=" %%* IN ("!argv:~1!") do (%\n%"
    

    set ^"templateB=))%\n%
    for /F "delims=" %%a in ('set !this!_') do (%\n%
    if "!this!" equ "%~n0" endlocal%\n%
    if defined this endlocal%\n%
        set "%%a"%\n%
    )%\n%
) else set argv="




  rem https://www.dostips.com/forum/viewtopic.php?f=3&t=2128&sid=938ec204d04c1482fc7c39b6a457b052
  setlocal EnableDelayedExpansion
  
  echo.
rem  call :readMacro "%UserProfile%\Digital Knob\Development\DKBatch\tests\macros\MacroFile.cmd" readMacroABC
  call :readMacro "%~1" %2 %3 %4 %5 %6 %7 %8 %9
rem  call :readMacro "%UserProfile%\Digital Knob\Development\DKBatch\functions\dk_selectFolder.cmd" dk_selectFolder
  echo.
  echo ########### end %~2 ##################
  echo %~2_argv  = '!%~2_argv!'
  echo %~2_argc  = '!%~2_argc!'
  echo %~2_argv0 = '!%~2_argv0!'
  echo %~2_argv1 = '!%~2_argv1!'
  echo %~2_argv2 = '!%~2_argv2!'
  echo %~2_argv3 = '!%~2_argv3!'
  echo %~2_argv4 = '!%~2_argv4!'
  echo %~2_argv5 = '!%~2_argv5!'
  echo %~2_argv6 = '!%~2_argv6!'
  echo %~2_argv7 = '!%~2_argv7!'
  echo %~2_argv8 = '!%~2_argv8!'
  echo %~2_argv9 = '!%~2_argv9!'
  echo.
  echo this = %this%
  echo %%this%%_argv  = '!%this%_argv!'
  echo %%this%%_argc  = '!%this%_argc!'
  echo %%this%%_argv0 = '!%this%_argv0!'
  echo %%this%%_argv1 = '!%this%_argv1!'
  echo %%this%%_argv2 = '!%this%_argv2!'
  echo %%this%%_argv3 = '!%this%_argv3!'
  echo %%this%%_argv4 = '!%this%_argv4!'
  echo %%this%%_argv5 = '!%this%_argv5!'
  echo %%this%%_argv6 = '!%this%_argv6!'
  echo %%this%%_argv7 = '!%this%_argv7!'
  echo %%this%%_argv8 = '!%this%_argv8!'
  echo %%this%%_argv9 = '!%this%_argv9!'
  
  
  pause
exit /b 0

:readFile
  set "filedata="
  set "read="
  :readLoop
	set "line="
	set /p line=
  if "!line!" equ "^!endfunction^!" exit /b
  if "!line!" equ "%%endfunction%%" exit /b
	if "!line!" equ "%~1_END" exit /b
	if "!line!" equ ":#EOF#" exit /b
	if "%read%" equ "1" set filedata=!filedata!!line!!LF!
	if "!line!" equ "%~1" set read=1
goto :readLoop

:readMacro
  ::FIXME - the two hardcoded 'readMacro' variables are our problem. They need to be dynamic
  echo  "%~1" (call :readFile :%~2)
  <"%~1" (call :readFile :%~2)
  set "this=%~2"
rem  echo this = %this%
  set "%~2_file=%~1"
  set %~2=!filedata:%%%%=%%!
rem  echo %~2='!filedata:%%%%=%%!'
rem  echo template='!template!'
rem  set "_MACRO_=!template:template=%~2!!filedata:%%%%=%%!!templateB:template=%~2!"
rem  set "_MACRO_=!template!!filedata:%%%%=%%!!templateB:template=%this%!"
  set "filedata=!filedata:%%setlocal%%=%setlocal%!"
  set "filedata=!filedata:%%dk_call%%=%dk_call%!"
  set "filedata=!filedata:%%endfuncion%%=%endfuncion%!"
  set "_MACRO_=!template!!filedata!!templateB:template=%this%!"
rem  set "_MACRO_=!template!!filedata!!templateB!"
  echo %this%='!_MACRO_:%%%%=%%!'
  echo.
  echo ########### call %~2 #################
  echo.
rem  %_MACRO_% abc "9 8 7" arg3 "arg 4"
  
  for /f "tokens=3*" %%a in ("%*") do (
		set args=%%a
	)
  %_MACRO_% %args%
  
exit /b !errorlevel!




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

  %dk_call% dk_readMacroFile "%UserProfile%\Digital Knob\Development\DKBatch\functions\dk_test.cmd" dk_test

%endfunction%
