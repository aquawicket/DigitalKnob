@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)


::####################################################################
::# dk_clipboard()
::#	dk_clipboard(set)
::#
::#
:dk_clipboard
setlocal
	%dk_call% dk_debugFunc 0 1

	::### SET ###
	if not "%~1"=="" (echo|set/p=%~1|clip)

	:: ###### GET ######
	%dk_call% dk_commandToVariable powershell -command Get-Clipboard

	endlocal & (
		set "dk_clipboard=%dk_commandToVariable%"
	)
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
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