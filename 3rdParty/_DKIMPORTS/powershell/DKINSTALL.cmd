@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
%setlocal%
	%dk_call% dk_debugFunc 0

	if EXIST "%powershell_exe%" (%return%)

	set "powershell_exe=C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe"
	if NOT EXIST "%powershell_exe%" (%dk_call% dk_findProgram powershell_exe "powershell.exe" "%windir%")
	
	%dk_call% dk_assertPath "%powershell_exe:\=/%"

	endlocal & (
		set "powershell_exe=%powershell_exe:\=/%"
	)
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% DKINSTALL
	%dk_call% dk_debug "powershell_exe = %powershell_exe%"
%endfunction%