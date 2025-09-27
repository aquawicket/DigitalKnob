@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_powershell(commands)
::#
::#
:dk_powershell
%setlocal%
	%dk_call% dk_debugFunc 1 99
	
	if "%~1" equ "" (%return%)
	
	set dk_powershell_command=%*
	:DeEscape
	echo %dk_powershell_command% | findstr /c:"^^" >nul && (
		set dk_powershell_command=%dk_powershell_command:^^=^%
		goto :DeEscape
	)
	
	%dk_call% dk_validate powershell_exe "%dk_call% dk_depend powershell_exe"

   
	::###### run command ######
	set DKPOWERSHELL_COMMAND=%powershell_exe% -Command %dk_powershell_command%
	
	%dk_call% dk_exec %DKPOWERSHELL_COMMAND%
	
	endlocal & (
		set "dk_powershell=%dk_exec%"
	)
	
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	echo ######################## TEST_A ########################
	%dk_call% dk_powershell "Write-Output 'dk_powershell TEST A';"
	echo(
	
	echo ######################## TEST_B ########################
	%dk_call% dk_powershell "Write-Output 'dk_powershell TEST B';"
	echo(
	
	echo ######################## TEST_C ########################
	set "PSVAR=this is a powershell variable"
    %dk_call% dk_powershell "Write-Output 'PSVAR = '${env:PSVAR};"
	echo(
	
%endfunction%
