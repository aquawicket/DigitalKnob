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
	
	%dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	set "_file_=%DKIMPORTS_DIR%/%~1/DKINSTALL.cmd"
	
	%dk_call% dk_assertVar DIGITALKNOB_DIR
	%dk_call% dk_assertVar DKHTTP_DIGITALKNOB_DIR
	if not exist "%_file_%" (
		set "dkhttp_file=!_file_:%DIGITALKNOB_DIR%=%DKHTTP_DIGITALKNOB_DIR%!
		%dk_call% dk_download "!dkhttp_file!" "%_file_%"
	)
	
	%dk_call% dk_allButFirstArgs %*
	endlocal & (
		cd "%DKIMPORTS_DIR%/%~1"
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

