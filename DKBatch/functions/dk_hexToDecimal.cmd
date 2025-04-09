@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_hexToDecimal(<hex> <output>:optional)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_hexToDecimal
setlocal
	%dk_call% dk_debugFunc 1 2

    set "hex=%~1"
    set "decimal="
    set /a dk_hexToDecimal=0x%hex:~-2%
    endlocal & (
		set "dk_hexToDecimal=%dk_hexToDecimal%"
		if "%2" neq "" set "%2=%dk_hexToDecimal%"
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_hexToDecimal 0x1b
    %dk_call% dk_echo "dk_hexToDecimal = %dk_hexToDecimal%"
%endfunction%
