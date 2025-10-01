@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKPWD (set "DKPWD=%CD:\=/%")
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_chdir(path)
::#
::#		change working directory
::#
:dk_chdir
%setlocal%
	%dk_call% dk_debugFunc 1

	::###### input ######
	set "dk_chdir=%~1"
	set "dk_chdir=%dk_chdir:\=/%"
	
	
	if NOT EXIST "%dk_chdir%" (
		%dk_call% dk_error "dk_chdir(%*): path:%dk_chdir% does NOT EXIST"
		%return%
	)
	if /i "%DKPWD%" equ "%dk_chdir%" (
		%dk_call% dk_notice "dk_chdir(%*): DKPWD is already set to %dk_chdir%"
		%return%
	)
	cd "%dk_chdir:/=\%"
	
	
	::###### output ######
	endlocal & (
		set "DKOLDPWD=%DKPWD%"
		set "DKPWD=%dk_chdir%"
		set "dk_chdir=%dk_chdir%"
		rem if "%~2" neq "" (set "%~2=%dk_chdir%") else (echo %dk_chdir%)
	)
%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_echo
	%dk_call% dk_echo "OLD Current Directory = %DKOLDPWD%"
	%dk_call% dk_echo "Current Directory = %DKPWD%"
	
	%dk_call% dk_echo
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_chdir "%DKBRANCH_DIR%"
	%dk_call% dk_echo "OLD Current Directory = %DKOLDPWD%"
	%dk_call% dk_echo "Current Directory = %DKPWD%"
	
	%dk_call% dk_echo
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_chdir "%DKTOOLS_DIR%"
	%dk_call% dk_echo "OLD Current Directory = %DKOLDPWD%"
	%dk_call% dk_echo "Current Directory = %DKPWD%"
	
%endfunction%
