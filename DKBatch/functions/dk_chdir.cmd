@echo off&::###### DK.cmd #########################################################################################################################
if not defined PWD (set "PWD=%CD:\=/%")
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_chdir(path)
::#
::#		change working directory
::#
:dk_chdir
%setlocal%
	%dk_call% dk_debugFunc 1

	set "_path_=%~1"
	
	if not exist %_path_% (
		%dk_call% dk_warning "dk_chdir(%*): path:%_path_% does not exist"
		%return%
	)
	
	if "%PWD%" equ "%_path_%" (
		%dk_call% dk_error "dk_chdir(%*): PWD is already set to %_path_%"
		%return%
	)
	
	endlocal & (
		set "OLDPWD=%PWD%"
		set "PWD=%_path_%"
		cd "%PWD:/=\%"
	)
%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_echo
	%dk_call% dk_echo "OLD Current Directory = %OLDPWD%"
	%dk_call% dk_echo "Current Directory = %PWD%"
	
	%dk_call% dk_echo
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_chdir "%DKBRANCH_DIR%"
	%dk_call% dk_echo "OLD Current Directory = %OLDPWD%"
	%dk_call% dk_echo "Current Directory = %PWD%"
	
	%dk_call% dk_echo
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_chdir "%DKTOOLS_DIR%"
	%dk_call% dk_echo "OLD Current Directory = %OLDPWD%"
	%dk_call% dk_echo "Current Directory = %PWD%"
%endfunction%
