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


rem Main
setlocal disableDelayedExpansion
if NOT defined @Try call dk_exception init
set /a cnt+=1
echo Main Iteration %cnt% - Calling :Sub
call :Sub
call echo Main Iteration %cnt% - :Sub returned %%errorlevel%%
echo Main Iteration %cnt% - Exit
exit /b %cnt%


:Sub
setlocal
echo :Sub Iteration %cnt% - Start
if %cnt% lss 10 (
  echo :Sub Iteration %cnt% - Calling testException2.bat
  call "%~f0"
  %= Show any non-exception return code (demonstrate ERRORLEVEL is preserved if no exception)   =%
  call echo :Sub Iteration %cnt% - testException2 returned %%errorlevel%%
)

%= Throw an exception if the iteration count is 6 =%
set /a "1/(cnt-6)" 2>nul || (
  echo Throwing exception
  call dk_exception throw -%cnt% "Divide by 0 exception!" "%~f0<%~0>"
  echo Should NOT see this
)
echo :Sub Iteration %cnt% - Exit
pause
exit /b %cnt%