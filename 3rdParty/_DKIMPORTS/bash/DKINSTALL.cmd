@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
%setlocal%
	%dk_call% dk_debugFunc 0
	
	if exist "%BASH_EXE%" (%return%)
	
	::###### GIT bash.exe ######
	if not exist "%BASH_EXE%" (
		%dk_call% dk_validate GIT "%dk_call% dk_depend git"
		set "GIT_BASH_EXE=!GIT!/bin/bash.exe"
		set "BASH_EXE=!GIT_BASH_EXE!"
	)
	
	::###### MSYS2 bash.exe ######
	if not exist "%BASH_EXE%" (
		%dk_call% dk_validate MSYS2 "%dk_call% dk_depend msys2"
		set "MSYS2_BASH_EXE=!MSYS2!/usr/bin/bash.exe"
		set "BASH_EXE=!MSYS2_BASH_EXE!"
	)
	
	%dk_call% dk_assertPath BASH_EXE
	
	::### return ###
	endlocal & (
		set "BASH_EXE=%BASH_EXE%"
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
	%dk_call% dk_echo "BASH_EXE = %BASH_EXE%"
%endfunction%
