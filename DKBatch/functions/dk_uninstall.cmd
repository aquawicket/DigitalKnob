@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_uninstall(plugin)
::#
::#   this will search for a "plugin" to run in the following search path
::#  '3rdParty/_IMPORTS/'plugin'/DKUNINSTALL.cmd'
::#
:dk_uninstall
%setlocal%
	%dk_call% dk_debugFunc 1 99
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	
	set "dkUninstall=%DKIMPORTS_DIR%/%~1/DKUNINSTALL.cmd"	
	if not exist "%dkUninstall%" (
		call set "dkhttpUninstall=%%dkUninstall:%DIGITALKNOB_DIR%=%DKHTTP_DIGITALKNOB_DIR%%%"
		%dk_call% dk_download "!dkhttpUninstall!" "%dkUninstall%"
	)
	
	%dk_call% dk_allButFirstArgs %*
	endlocal & (
		::cd "%DKIMPORTS_DIR%/%~1"
		set "dk_uninstall=%DKIMPORTS_DIR%/%~1"
		%dk_call% "%dkUninstall%" %dk_allButFirstArgs%
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

