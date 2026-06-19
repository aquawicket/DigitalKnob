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
::# test_dk_exception.cmd
::#
::#

setlocal disableDelayedExpansion
if NOT defined @Try call dk_exception init

set /a cnt+=1
echo Main Iteration %cnt% - Calling :Sub
%@Try%
  call :Sub
  call echo Main Iteration %cnt% - :Sub returned %%errorlevel%%
%@EndTry%
:@Catch
  setlocal enableDelayedExpansion
  echo.
  echo Main Iteration %cnt% - Exception detected:
  echo   Code     = !exception.code!
  echo   Message  = !exception.msg!
  echo   Location = !exception.loc!
  echo Rethrowing modified exception
  echo.
  endlocal
  call dk_exception rethrow -%cnt% "Main Exception" "%~f0<%~0>"
:@EndCatch
echo Main Iteration %cnt% - Exit
exit /b %cnt%


:Sub
setlocal
echo :Sub Iteration %cnt% - Start
%@Try%
  if %cnt% lss 7 (
    echo :Sub Iteration %cnt% - Calling "%~f0"
    call "%~f0"
    %= Show any non-exception return code (demonstrate ERRORLEVEL is preserved if no exception) =%
    call echo :Sub Iteration %cnt% - testException returned %%errorlevel%%
  )
  %= Throw an exception if the iteration count is a multiple of 3 =%
  set /a "1/(cnt%%3)" 2>nul || (
    echo Throwing exception
    call dk_exception throw -%cnt% "Divide by 0 exception" "%~f0<%~0>"
  )
%@EndTry%
:@Catch
  setlocal enableDelayedExpansion
  echo.
  echo :Sub Iteration %cnt% - Exception detected:
  echo   Code     = !exception.code!
  echo   Message  = !exception.msg!
  echo   Location = !exception.loc!
  endlocal
  %= Handle the exception if iteration count is a multiple of 5, else rethrow it with new properties =%
  set /a "1/(cnt%%5)" 2>nul && (
    echo Rethrowing modified exception
    echo.
    call dk_exception rethrow -%cnt% ":Sub Exception" "%~f0<%~0>"
  ) || (
    call dk_exception clear
    echo Exception handled
    echo.
  )
  pause
:@EndCatch
echo :Sub Iteration %cnt% - Exit
exit /b %cnt%
pause