@echo off

::####################################################################
::# test_dk_exception.cmd
::#
::#

setlocal disableDelayedExpansion
if not defined @Try call exception init

set /a cnt+=1
echo Main Iteration %cnt% - Calling :Sub
%@Try%
  call :Sub
  call echo Main Iteration %cnt% - :Sub returned %%errorlevel%%
%@EndTry%
:@Catch
  setlocal enableDelayedExpansion
  echo(
  echo Main Iteration %cnt% - Exception detected:
  echo   Code     = !exception.code!
  echo   Message  = !exception.msg!
  echo   Location = !exception.loc!
  echo Rethrowing modified exception
  echo(
  endlocal
  call exception rethrow -%cnt% "Main Exception" "%~f0<%~0>"
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
    call exception throw -%cnt% "Divide by 0 exception" "%~f0<%~0>"
  )
%@EndTry%
:@Catch
  setlocal enableDelayedExpansion
  echo(
  echo :Sub Iteration %cnt% - Exception detected:
  echo   Code     = !exception.code!
  echo   Message  = !exception.msg!
  echo   Location = !exception.loc!
  endlocal
  %= Handle the exception if iteration count is a multiple of 5, else rethrow it with new properties =%
  set /a "1/(cnt%%5)" 2>nul && (
    echo Rethrowing modified exception
    echo(
    call exception rethrow -%cnt% ":Sub Exception" "%~f0<%~0>"
  ) || (
    call exception clear
    echo Exception handled
    echo(
  )
  pause
:@EndCatch
echo :Sub Iteration %cnt% - Exit
exit /b %cnt%