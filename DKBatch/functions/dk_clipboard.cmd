@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_clipboard()
::#	dk_clipboard(set)
::#
::#
:dk_clipboard
%setlocal%
	%dk_call% dk_debugFunc 0 1

	::### SET ###
	if "%~1" neq "" (echo|set/p=%~1|clip)

	:: ###### GET ######
	%dk_call% dk_exec powershell.exe -command Get-Clipboard
	set "dk_clipboard=%dk_exec%"

	
	::###### output ######
	endlocal & (
		set "dk_clipboard=%dk_clipboard%"
		if "%~2" neq "" (
			set "%~2=%dk_clipboard%"
		) else (
			echo %dk_clipboard%
		)
	)
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	:: get the clipboard
	%dk_call% dk_echo "Getting the clipboard . . ."
	%dk_call% dk_clipboard
	%dk_call% dk_echo "dk_clipboard = %dk_clipboard%"

	:: set the clipboard
	%dk_call% dk_echo "Setting the clipboard . . ."
	%dk_call% dk_clipboard "clipboard test"
	%dk_call% dk_echo "dk_clipboard = %dk_clipboard%"

	:: get the clipboard
	%dk_call% dk_echo "Getting the clipboard . . ."
	%dk_call% dk_clipboard
	%dk_call% dk_echo "dk_clipboard = %dk_clipboard%"
%endfunction%