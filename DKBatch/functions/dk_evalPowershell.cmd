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


rem ################################################################################
rem # dk_evalPowershell(commands)
rem #
rem #
:dk_evalPowershell
%setlocal%
	
	if "%~1" equ "" (%return%)
	
	set dk_evalPowershell_command=%*
	
	:DeEscape
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	echo %dk_evalPowershell_command% | %findstr.exe% /c:"^^" >nul && (
		set dk_evalPowershell_command=%dk_evalPowershell_command:^^=^%
		goto :DeEscape
	)
	
	%dk_call% dk_validate powershell.exe %dk_call% dk_depend powershell.exe

   
	rem ###### run command ######
	set DKPOWERSHELL_COMMAND=%powershell.exe% -Command %dk_evalPowershell_command%
	
	%dk_call% dk_exec %DKPOWERSHELL_COMMAND%
	
	endlocal & (
		set "dk_evalPowershell=%dk_exec%"
	)
	
%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	echo ######################## TEST_A ########################
	%dk_call% dk_evalPowershell "Write-Output 'dk_evalPowershell TEST A';"
	echo.
	
	echo ######################## TEST_B ########################
	%dk_call% dk_evalPowershell "Write-Output 'dk_evalPowershell TEST B';"
	echo.
	
	echo ######################## TEST_C ########################
	set "PSVAR=this is a powershell variable"
    %dk_call% dk_evalPowershell "Write-Output 'PSVAR = '${env:PSVAR};"
	echo.
	
%endfunction%
