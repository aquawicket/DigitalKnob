@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


:: Main
setlocal disableDelayedExpansion
if not defined @Try call dk_exception init
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