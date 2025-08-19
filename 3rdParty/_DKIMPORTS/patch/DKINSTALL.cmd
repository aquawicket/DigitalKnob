@echo off&::###### DK.cmd #########################################################################################################################
if NOT exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL
::#
:DKINSTALL
%setlocal%
	%dk_call% dk_debugFunc 0 

	if exist "%PATCH_EXE%" (%return%)
	
	::###### GIT patch.exe ######
	if NOT exist "%PATCH_EXE%" (
		%dk_call% dk_validate GIT "%dk_call% dk_depend git"
		set "PATCH_EXE=!GIT!/usr/bin/patch.exe"
	)	
	
	%dk_call% dk_assertPath PATCH_EXE
	
	::### return ###
	endlocal & (
		set "PATCH_EXE=%PATCH_EXE%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0 

	%dk_call% DKINSTALL
	%dk_call% dk_echo "PATCH_EXE = %PATCH_EXE%"
%endfunction%
