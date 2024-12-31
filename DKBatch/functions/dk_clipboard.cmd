@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*


::####################################################################
::# dk_call()
::#	dk_clipboard(set)
::#
::#
:dk_clipboard
	%dk_call% dk_debugFunc 0 1
 setlocal
 
    if "%~1" equ "" goto clipboard_set
	    
	echo|set/p=%~1|clip
	%return%
		
	:clipboard_set
	%dk_call% dk_commandToVariable "powershell -command ""Get-Clipboard""" rtn_value
		
	for /f "delims=" %%Z in ('powershell -Command "Get-Clipboard"') do (
		set "rtn_value=%%Z"
	)
	
	endlocal & set "dk_clipboard=%rtn_value%"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal

	:: set the clipboard
	%dk_call% dk_clipboard "clipboard test"

	:: get the clipboard
	%dk_call% dk_clipboard
	%dk_call% dk_echo "clipboard = %dk_clipboard%"

%endfunction%