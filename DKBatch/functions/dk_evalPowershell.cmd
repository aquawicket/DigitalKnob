@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_evalPowershell(commands)
::#
::#
:dk_evalPowershell
%setlocal%
	%dk_call% dk_debugFunc 1 99
	
	if "%~1" equ "" (%return%)
	
	set dk_evalPowershell_command=%*
	:DeEscape
	echo %dk_evalPowershell_command% | findstr /c:"^^" >nul && (
		set dk_evalPowershell_command=%dk_evalPowershell_command:^^=^%
		goto :DeEscape
	)
	
	%dk_call% dk_validate powershell_exe "%dk_call% dk_depend powershell_exe"

   
	::###### run command ######
	set DKPOWERSHELL_COMMAND=%powershell_exe% -Command %dk_evalPowershell_command%
	
	%dk_call% dk_exec %DKPOWERSHELL_COMMAND%
	
	endlocal & (
		set "dk_evalPowershell=%dk_exec%"
	)
	
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	echo ######################## TEST_A ########################
	%dk_call% dk_evalPowershell "Write-Output 'dk_evalPowershell TEST A';"
	echo(
	
	echo ######################## TEST_B ########################
	%dk_call% dk_evalPowershell "Write-Output 'dk_evalPowershell TEST B';"
	echo(
	
	echo ######################## TEST_C ########################
	set "PSVAR=this is a powershell variable"
    %dk_call% dk_evalPowershell "Write-Output 'PSVAR = '${env:PSVAR};"
	echo(
	
%endfunction%
