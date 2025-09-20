@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_powershell_exe()
::#
::#
:dk_powershell_exe
%setlocal%
	%dk_call% dk_debugFunc 0
  
    if EXIST "%powershell_exe%" (%return%)

	::###### try pwsh.exe ######
::	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
::	%dk_call% dk_findProgram powershell_exe pwsh.exe "%DKTOOLS_DIR%"

	::###### Try C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe ######
	if NOT EXIST "%powershell_exe%" (set "powershell_exe=C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe")
	
    ::###### try powershell.exe ######
	if NOT EXIST "%powershell_exe%" (%dk_call% dk_findProgram powershell_exe "powershell.exe")
	
	if NOT EXIST "%powershell_exe%" (
		%dk_call% dk_exec cmd /c where powershell.exe
		set "powershell_exe=!dk_exec!"
	)
	
	::### Test powershell_exe version 1 ###
	"%powershell_exe%" -v 1 -Command exit && (
		%dk_call% dk_success "powershell version 1 ran successfully"
	) || (
		%dk_call% dk_error "powershell_exe:%powershell_exe% version 1 did not run successfully"
		%dk_call% dk_unset powershell_exe
		%return%
	)
	
	::### Test powershell_exe version 2 ###
	"%powershell_exe%" -v 2 -Command exit && (
		%dk_call% dk_success "powershell version 2 ran successfully"
	) || (
		%dk_call% dk_error "powershell_exe:%powershell_exe% version 2 did not run successfully"
		%dk_call% dk_unset powershell_exe
		%return%
	)
	
	::### Test powershell_exe version 3 ###
	"%powershell_exe%" -v 3 -Command exit && (
		%dk_call% dk_success "powershell version 3 ran successfully"
	) || (
		%dk_call% dk_error "powershell_exe:%powershell_exe% version 3 did not run successfully"
		%dk_call% dk_unset powershell_exe
		%return%
	)
	
	::### Test powershell_exe version 4 ###
	"%powershell_exe%" -v 4 -Command exit && (
		%dk_call% dk_success "powershell version 4 ran successfully"
	) || (
		%dk_call% dk_error "powershell_exe:%powershell_exe% version 4 did not run successfully"
		%dk_call% dk_unset powershell_exe
		%return%
	)
	
	::### Test powershell_exe version 5 ###
	"%powershell_exe%" -v 5 -Command exit && (
		%dk_call% dk_success "powershell version 5 ran successfully"
	) || (
		%dk_call% dk_error "powershell_exe:%powershell_exe% version 5 did not run successfully"
		%dk_call% dk_unset powershell_exe
		%return%
	)
	
	::### Test powershell_exe version 6 ###
	"%powershell_exe%" -v 6 -Command exit && (
		%dk_call% dk_success "powershell version 6 ran successfully"
	) || (
		%dk_call% dk_error "powershell_exe:%powershell_exe% version 6 did not run successfully"
		%dk_call% dk_unset powershell_exe
		%return%
	)
	
	(call )
	endlocal & (
		set "powershell_exe=%powershell_exe%"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::%dk_call% dk_validate powershell_exe "%dk_call% dk_powershell_exe" %NOERROR%
	%dk_call% dk_validate powershell_exe "%dk_call% dk_powershell_exe"
    %dk_call% dk_echo "powershell_exe = %powershell_exe%"
%endfunction%
