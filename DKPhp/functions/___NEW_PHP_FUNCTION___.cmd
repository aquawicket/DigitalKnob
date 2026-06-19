rem shebang
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


rem ############################################################################
::# ___NEW_PHP_FUNCTION___()
::#
:___NEW_PHP_FUNCTION___
%setlocal%

	::### name the new function
	%dk_call% dk_inputBox
	set "FUNCTION=%dk_inputBox%"
	set "FUNCTION_FILE=%FUNCTION%.php"
	
	if EXIST "%FUNCTION_FILE%" (
		%dk_call% dk_notice "%FUNCTION_FILE% already exists"
		goto :edit_textfile
	)
	
	setlocal disableDelayedExpansion
	>"%FUNCTION_FILE%" (
		echo.^<?php
		echo.
		echo.##################################################################################
		echo.# %FUNCTION%(arg, _rtn_var)
		echo.#
		echo.#	DESCRIPTION
		echo.#
		echo.#
		echo.function %FUNCTION%($_path, ^&...$rtn_var){
		echo.	#dk_debugFunc(0 99);
		echo.	global $%FUNCTION%;
		echo.
		echo.
		echo.	$%FUNCTION% = "your code here";
		echo.
		echo.
		echo.	###### return ######
		echo.	if(isset($rtn_var[0])){
		echo.		$rtn_var[0] = $%FUNCTION%;
		echo.	} elseif(isset($%FUNCTION%)){
		echo.		echo."$%FUNCTION%\n");
		echo.	}
		echo.	return $%FUNCTION%;
		echo.}
		echo.
		echo.
		echo.
		echo.
		echo.
		echo.
		echo.
		echo.
		echo.
		echo.
		echo.
		echo.###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
		echo.if(!function_exists('DKTEST')){ function DKTEST() {
		echo.	#dk_debugFunc(0);
		echo.	dk_source("dk_echo");
		echo.
		echo.	### Result as global variable
		echo.	dk_echo."\n");
		echo.	%FUNCTION%("A:/directoryA/filenameA.extA");
		echo.	dk_echo."%FUNCTION% = ".$GLOBALS['%FUNCTION%']."\n");
		echo.
		echo.	### Result as parameter variable
		echo.	dk_echo."\n");
		echo.	$resultB = "";
		echo.	%FUNCTION%("B:/directoryB/filenameB.extB", $resultB);
		echo.	dk_echo."resultB = $resultB\n");
		echo.	dk_echo."%FUNCTION% = ".$GLOBALS['%FUNCTION%']."\n");
		echo.
		echo.	### Result as return value
		echo.	dk_echo."\n");
		echo.	$resultC=%FUNCTION%("C:/directoryC/filenameC.extC");
		echo.	dk_echo."resultC = $resultC\n");
		echo.	dk_echo."%FUNCTION% = ".$GLOBALS['%FUNCTION%']."\n");
		echo.
		echo.	### Result as return value and parameter variable
		echo.	dk_echo."\n");
		echo.	$resultD1 = "";
		echo.	$resultD2=%FUNCTION%("D:/directoryD/filenameD.extD", $resultD1);
		echo.	dk_echo."resultD1 = $resultD1\n");
		echo.	dk_echo."resultD2 = $resultD2\n");
		echo.	dk_echo."%FUNCTION% = ".$GLOBALS['%FUNCTION%']."\n");
		echo.}}
		echo.
		echo.
		echo.include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/DigitalKnob/Development/DKPhp/functions/DK.php");
		echo.?^>
	)	
	endlocal
	
	:edit_textfile
	%dk_call% dk_validate notepadpp_exe %dk_call% dk_depend notepadpp_exe
	"%notepadpp_exe%" "%FUNCTION_FILE%"
%endfunction%


















rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% ___NEW_PHP_FUNCTION___
%endfunction%
