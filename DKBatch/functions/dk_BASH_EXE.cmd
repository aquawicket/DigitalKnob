@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_BASH_EXE()
::#
::#
:dk_BASH_EXE
setlocal
	%dk_call% dk_debugFunc 0

	if exist "%BASH_EXE%" (%return%)

	%dk_call% dk_validate GIT "%dk_call% dk_installGit"
	if not exist "%BASH_EXE%" (%dk_call% dk_findProgram BASH_EXE "bash.exe" "%GIT%")
	%dk_call% dk_assertPath "%BASH_EXE%"
	
	endlocal & (
		set "BASH_EXE=%BASH_EXE%"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_BASH_EXE
	%dk_call% dk_echo "BASH_EXE = '%BASH_EXE%'"
%endfunction%
