@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL
::#
:DKINSTALL
%setlocal%
	%dk_call% dk_debugFunc 0 

	if EXIST "%patch_exe%" (%return%)
	
	::###### GIT patch.exe ######
	if NOT EXIST "%patch_exe%" (
		%dk_call% dk_validate GIT "%dk_call% dk_depend git"
		set "patch_exe=!GIT!/usr/bin/patch.exe"
	)	
	
	%dk_call% dk_assertPath patch_exe
	
	::### return ###
	endlocal & (
		set "patch_exe=%patch_exe%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0 

	%dk_call% DKINSTALL
	%dk_call% dk_echo "patch_exe = %patch_exe%"
%endfunction%
