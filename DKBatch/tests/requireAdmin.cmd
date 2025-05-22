@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


@echo off & cls & echo:
net file 1>nul 2>nul & if errorlevel 1 (echo you must right-click and select & echo "run as administrator"  to run this batch. exiting... & echo: & pause & exit /d)
REM ... proceed here with admin rights ...

pause