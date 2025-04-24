<<<<<<< HEAD
::Kill a processes in processes_MYList.txt
@echo off

=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::###### Kill a processes in processes_MYList.txt ######
>>>>>>> Development
:: kill by name
for /f "tokens=*" %%a in (processes_MyList.txt) do (
	echo %%a 
	taskkill /IM "%%a" /F
)
<<<<<<< HEAD

pause
=======
>>>>>>> Development
