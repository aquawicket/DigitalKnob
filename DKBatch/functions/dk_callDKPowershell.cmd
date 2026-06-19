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
rem # dk_callDKPowershell(function, arguments...)
rem #
rem #   Reference: https://stackoverflow.com/questions/34451444/how-to-get-a-returned-value-from-powershell-and-get-it-in-a-batch-file
rem #
:dk_callDKPowershell
%setlocal%

	set "_func_=%~1"
	
	rem ### Get DKPOWERSHELL_FUNCTIONS_DIR
	%dk_call% dk_validate DKPOWERSHELL_FUNCTIONS_DIR	%dk_call% dk_DKBRANCH_DIR
	%dk_call% dk_mkdir "%DKPOWERSHELL_FUNCTIONS_DIR%"
	%dk_call% dk_assertPath DKPOWERSHELL_FUNCTIONS_DIR

	rem ### Atempt to extract the file from DigitalKnob.tar.gz
	rem if "%DKOFFLINE%" equ "1" (
		if EXIST "%DigitalKnob_tar_gz%" (
			if NOT EXIST "%DKPOWERSHELL_FUNCTIONS_DIR%/DK.ps1"	(%dk_call% tar.exe -zxvf "%DigitalKnob_tar_gz%" -C "%DKBRANCH_DIR%" DKPowershell/functions/DK.ps1)
			if NOT EXIST "%DKPOWERSHELL_FUNCTIONS_DIR%/%~1.ps1"	(%dk_call% tar.exe -zxvf "%DigitalKnob_tar_gz%" -C "%DKBRANCH_DIR%" DKPowershell/functions/%~1.ps1)
		)
	rem )
	
	rem ### Get DKHTTP_DKPOWERSHELL_DIR
	if NOT defined DKHTTP_DKPOWERSHELL_DIR				(set "DKHTTP_DKPOWERSHELL_DIR=%DKHTTP_DKBRANCH_DIR%/DKPowershell")
	if NOT defined DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR	(set "DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR=%DKHTTP_DKPOWERSHELL_DIR%/functions")

	set "_path_=%DKPOWERSHELL_FUNCTIONS_DIR%/%_func_%.ps1"
	
	rem ### Download files if missing
	if NOT EXIST "%DKPOWERSHELL_FUNCTIONS_DIR%/DK.ps1"	(%dk_call% dk_download "%DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR%/DK.ps1" "%DKPOWERSHELL_FUNCTIONS_DIR%/DK.ps1")
	if NOT EXIST "%DKPOWERSHELL_FUNCTIONS_DIR%/%~1.ps1"	(%dk_call% dk_download "%DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR%/%~1.ps1" "%DKPOWERSHELL_FUNCTIONS_DIR%/%~1.ps1")

	%dk_call% dk_validate powershell.exe %dk_call% dk_depend powershell.exe

	rem https://stackoverflow.com/a/4732316/688352
	%dk_call% %ComSpec% /c %powershell.exe% -Command 'Set-ExecutionPolicy RemoteSigned -Scope CurrentUser' 1>nul

	rem ### ALL_BUT_FIRST ###	
	%dk_call% dk_allButFirstArgs %*

	rem ############ DKPowershell function call ############
	rem %dk_call% %ComSpec% /c %powershell.exe% -Command $global:DKSCRIPT_PATH = '%DKSCRIPT_PATH%'; . %DKPOWERSHELL_FUNCTIONS_DIR%/%~1.ps1; %1 %dk_allButFirstArgs%
	rem set "dk_exec_ECHO_OUTPUT=0"
	set dk_allButFirstArgs=%dk_allButFirstArgs:"='%
	set DKCOMMAND=%powershell.exe% -Command "$global:DKSCRIPT_PATH = '%DKSCRIPT_PATH%'; . %_path_%; %_func_% %dk_allButFirstArgs%;"
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_callDKPowershell=%dk_exec%"
		set "%_func_%=%dk_exec%"
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_callDKPowershell dk_trayAddOption Option1 "Option 1"

	%dk_call% dk_echo
	%dk_call% dk_callDKPowershell dk_basename "%USERPROFILE:\=/%/Digital Knob/Development"
	%dk_call% dk_echo "dk_callDKPowershell = %dk_callDKPowershell%"
	%dk_call% dk_echo "dk_basename = %dk_basename%"
	%dk_call% dk_echo
	

	
	%dk_call% dk_callDKPowershell dk_testReturn "inputA"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKPowershell = %dk_callDKPowershell%"
	
rem	%dk_call% dk_callDKPowershell Test/dk_test "arg 1" "arg 2" "arg 3"
rem	%dk_call% dk_echo
rem	%dk_call% dk_echo "dk_callDKPowershell = %dk_callDKPowershell%"
	
rem	%dk_call% dk_callDKPowershell Test/Test/dk_test "arg 1" "arg 2" "arg 3"
rem	%dk_call% dk_echo
rem	%dk_call% dk_echo "dk_callDKPowershell = %dk_callDKPowershell%"
%endfunction%
