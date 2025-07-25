@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_depend(plugin)
::#
::#   this will search for a "plugin" to run in the following search path
::#  '3rdParty/_IMPORTS/'plugin'/DKINSTALL.cmd'
::#
:dk_depend
%setlocal%
	%dk_call% dk_debugFunc 1 99
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_allButFirstArgs %*
	
	endlocal & (
		%dk_call% "%DKIMPORTS_DIR%/%~1/DKINSTALL.cmd" %dk_allButFirstArgs%
	)
%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_depend bash GIT
	echo BASH_EXE = %BASH_EXE%
	
	%dk_call% dk_depend bash MSYS2
	echo BASH_EXE = %BASH_EXE%
%endfunction%

