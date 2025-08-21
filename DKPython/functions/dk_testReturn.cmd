@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" set "DKBATCH_FUNCTIONS_DIR_=%USERPROFILE:\=/%/DigitalKnob/Development/DKBatch/functions/"
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_testReturn(input, output)
::#
::#
:dk_testReturn
%setlocal%
	%dk_call% dk_debugFunc 1 2

	set "input=%~1"
	set "dk_testReturn=%input:input=output%"

	endlocal & (
		set "dk_testReturn=%dk_testReturn%"
		if "%~2" neq "" (
			set "%~2=%dk_testReturn%"
		) else (
			echo %dk_testReturn%
		)
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::### Result as return value
	%dk_call% dk_echo
	for /f "usebackq tokens=*" %%G in (`%ComSpec% /V:ON /c call "C:\Users\Administrator\DigitalKnob\Development\3rdParty\python3-python-3.11.8-embed-amd64\python.exe" "dk_testReturn.py"`) do (set "dk_testReturn=%%G")
	%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"	
	%dk_call% dk_echo
	
%endfunction%
