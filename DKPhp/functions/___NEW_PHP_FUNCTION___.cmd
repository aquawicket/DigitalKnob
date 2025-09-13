@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# ___NEW_PHP_FUNCTION___()
::#
::#
:___NEW_PHP_FUNCTION___
%setlocal%
	%dk_call% dk_debugFunc 0

	::### name the new function
	%dk_call% dk_inputBox
	set "FUNCTION=%dk_inputBox%"
	set "FUNCTION_FILE=%FUNCTION%.php"
	
	if EXIST "%FUNCTION_FILE%" (
		%dk_call% dk_notice "%FUNCTION_FILE% already exists"
		goto :edit_textfile
	)
	
	setlocal disableDelayedExpansion
	echo(^<?php>																															"%FUNCTION_FILE%"
	echo(>>																																"%FUNCTION_FILE%"
	echo(##################################################################################>>											"%FUNCTION_FILE%"
	echo(# %FUNCTION%(arg, _rtn_var)>>																									"%FUNCTION_FILE%"
	echo(#>>																															"%FUNCTION_FILE%"
	echo(#	DESCRIPTION>>																												"%FUNCTION_FILE%"
	echo(#>>																															"%FUNCTION_FILE%"
	echo(#>>																															"%FUNCTION_FILE%"
	echo(function %FUNCTION%($_path, ^&...$rtn_var){>>																					"%FUNCTION_FILE%"
	echo(	#dk_debugFunc(0 99);>>																										"%FUNCTION_FILE%"
	echo(	global $%FUNCTION%;>>																										"%FUNCTION_FILE%"
	echo(>>																																"%FUNCTION_FILE%"
	echo(>>																																"%FUNCTION_FILE%"
	echo(	$%FUNCTION% = "your code here";>>																							"%FUNCTION_FILE%"
	echo(>>																																"%FUNCTION_FILE%"
	echo(>>																																"%FUNCTION_FILE%"	
	echo(	### output ####>>																											"%FUNCTION_FILE%"
	echo(	if(isset($rtn_var[0])){>>																									"%FUNCTION_FILE%"
	echo(		$rtn_var[0] = $%FUNCTION%;>>																							"%FUNCTION_FILE%"
	echo(	} elseif(isset($%FUNCTION%)){>>																								"%FUNCTION_FILE%"
	echo(		echo("$%FUNCTION%\n");>>																								"%FUNCTION_FILE%"
	echo(	}>>																															"%FUNCTION_FILE%"
	echo(	return $%FUNCTION%;>>																										"%FUNCTION_FILE%"
	echo(}>>																															"%FUNCTION_FILE%"
	echo(>>																																"%FUNCTION_FILE%"
	echo(>>																																"%FUNCTION_FILE%"
	echo(>>																																"%FUNCTION_FILE%"
	echo(>>																																"%FUNCTION_FILE%"
	echo(>>																																"%FUNCTION_FILE%"
	echo(>>																																"%FUNCTION_FILE%"
	echo(>>																																"%FUNCTION_FILE%"
	echo(>>																																"%FUNCTION_FILE%"
	echo(>>																																"%FUNCTION_FILE%"
	echo(>>																																"%FUNCTION_FILE%"
	echo(>>																																"%FUNCTION_FILE%"
	echo(###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######>>													"%FUNCTION_FILE%"
	echo(if(!function_exists('DKTEST')){ function DKTEST() {>>																			"%FUNCTION_FILE%"
	echo(	#dk_debugFunc(0);>>																											"%FUNCTION_FILE%"
	echo(	dk_source("dk_echo");>>																										"%FUNCTION_FILE%"
	echo(>>																																"%FUNCTION_FILE%"
	echo(	### Result as global variable>>																								"%FUNCTION_FILE%"
	echo(	dk_echo("\n");>>																											"%FUNCTION_FILE%"
	echo(	%FUNCTION%("A:/directoryA/filenameA.extA");>>																				"%FUNCTION_FILE%"
	echo(	dk_echo("%FUNCTION% = ".$GLOBALS['%FUNCTION%']."\n");>>																		"%FUNCTION_FILE%"
	echo(>>																																"%FUNCTION_FILE%"
	echo(	### Result as parameter variable>>																							"%FUNCTION_FILE%"
	echo(	dk_echo("\n");>>																											"%FUNCTION_FILE%"
	echo(	$resultB = "";>>																											"%FUNCTION_FILE%"
	echo(	%FUNCTION%("B:/directoryB/filenameB.extB", $resultB);>>																		"%FUNCTION_FILE%"
	echo(	dk_echo("resultB = $resultB\n");>>																							"%FUNCTION_FILE%"
	echo(	dk_echo("%FUNCTION% = ".$GLOBALS['%FUNCTION%']."\n");>>																		"%FUNCTION_FILE%"
	echo(>>																																"%FUNCTION_FILE%"
	echo(	### Result as return value>>																								"%FUNCTION_FILE%"
	echo(	dk_echo("\n");>>																											"%FUNCTION_FILE%"
	echo(	$resultC=%FUNCTION%("C:/directoryC/filenameC.extC");>>																		"%FUNCTION_FILE%"
	echo(	dk_echo("resultC = $resultC\n");>>																							"%FUNCTION_FILE%"
	echo(	dk_echo("%FUNCTION% = ".$GLOBALS['%FUNCTION%']."\n");>>																		"%FUNCTION_FILE%"
	echo(>>																																"%FUNCTION_FILE%"
	echo(	### Result as return value and parameter variable>>																			"%FUNCTION_FILE%"
	echo(	dk_echo("\n");>>																											"%FUNCTION_FILE%"
	echo(	$resultD1 = "";>>																											"%FUNCTION_FILE%"
	echo(	$resultD2=%FUNCTION%("D:/directoryD/filenameD.extD", $resultD1);>>															"%FUNCTION_FILE%"
	echo(	dk_echo("resultD1 = $resultD1\n");>>																						"%FUNCTION_FILE%"
	echo(	dk_echo("resultD2 = $resultD2\n");>>																						"%FUNCTION_FILE%"
	echo(	dk_echo("%FUNCTION% = ".$GLOBALS['%FUNCTION%']."\n");>>																		"%FUNCTION_FILE%"
	echo(}}>>																															"%FUNCTION_FILE%"
	echo(>>																																"%FUNCTION_FILE%"
	echo(>>																																"%FUNCTION_FILE%"
	echo(include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/DigitalKnob/Development/DKPhp/functions/DK.php");>>				"%FUNCTION_FILE%"
	echo(?^>>>																															"%FUNCTION_FILE%"
	endlocal

	:edit_textfile
	%dk_call% dk_validate NOTEPADPP_EXE "%dk_call% dk_NOTEPADPP_EXE"
	"%NOTEPADPP_EXE%" "%FUNCTION_FILE%"
%endfunction%


















::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% ___NEW_PHP_FUNCTION___
%endfunction%
