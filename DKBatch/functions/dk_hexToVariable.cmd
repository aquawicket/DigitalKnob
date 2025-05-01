@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_hexToVariable(<name>, <output>:optional)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_hexToVariable
%setlocal%
	%dk_call% dk_debugFunc 1 2

    set "hex=%~1"
    for /f %%b in ('forfiles /c "%ComSpec% /c echo 0x%hex:~-2%"') do endlocal & (
		set "dk_hexToVariable=%%b"
		if "%~2" neq "" (set "%~2=%dk_hexToVariable%")
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    %dk_call% dk_hexToVariable 0x41
    %dk_call% dk_echo "dk_hexToVariable = %dk_hexToVariable%"
%endfunction%
