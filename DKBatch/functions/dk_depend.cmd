@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_depend(plugin)
::#
::#   Run the DKINSTALL.cmd file for the given 'plugin'
::#  '3rdParty/_IMPORTS/'plugin'/DKINSTALL.cmd'
::#
:dk_depend
%setlocal%
	%dk_call% dk_debugFunc 1 99
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	
	set "dkInstall=%DKIMPORTS_DIR%/%~1/DKINSTALL.cmd"	
	if not exist "%dkInstall%" (
		call set "dkhttpInstall=%%dkInstall:%DIGITALKNOB_DIR%=%DKHTTP_DIGITALKNOB_DIR%%%"
		%dk_call% dk_download "!dkhttpInstall!" "%dkInstall%"
	)
	
	%dk_call% dk_allButFirstArgs %*
	endlocal & (
		set "CURRENT_IMPORT=%DKIMPORTS_DIR%/%~1"
		%dk_call% "%dkInstall%" %dk_allButFirstArgs%
	)
%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_depend git
	echo GIT_EXE = %GIT_EXE%

::	%dk_call% dk_depend bash GIT
::	echo BASH_EXE = %BASH_EXE%
	
::	%dk_call% dk_depend bash MSYS2
::	echo BASH_EXE = %BASH_EXE%
%endfunction%

