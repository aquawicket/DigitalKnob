@echo off&::###### DK.cmd #########################################################################################################################
if NOT exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_fileSize(<path> <rtn_var:optional>)
::#
::#
:dk_fileSize
%setlocal%
	%dk_call% dk_debugFunc 2

	set _input=%1
	set _input=%_input:"=%
	if "%_input:~-1%" equ "\" set _input=%_input:~0,-1%
	if "%_input:~-1%" equ "/" set _input=%_input:~0,-1%
	for %%Z in ("%_input%") do set "dk_fileSize=%%~zZ"
	
	::### return ###
	endlocal & (
		set "dk_fileSize=%dk_fileSize%"
		if "%~2" neq "" (set "%~2=%dk_fileSize%")
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_echo 
	%dk_call% dk_set myPath "DK.cmd"
	%dk_call% dk_fileSize "%myPath%"
	%dk_call% dk_echo "dk_fileSize = %dk_fileSize%"
	
	%dk_call% dk_echo 
	%dk_call% dk_set myPath "dk_fileSize.cmd"
	%dk_call% dk_fileSize "%myPath%" myFileSize
	%dk_call% dk_echo "dk_fileSize = %dk_fileSize%"
	%dk_call% dk_echo "myFileSize = %myFileSize%"
%endfunction%
