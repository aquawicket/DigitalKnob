@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
%setlocal%
	%dk_call% dk_debugFunc 1
	
	if "%~1" equ "" (%dk_call% dk_error "DKBash/DKINSTALL requires an argument" & pause & %return%)
	
	if exist "%BASH_EXE%" (
		if "%bash_ENV%" equ "%~1" (
			%return%
		)
	)
	
	set "bash_ENV=%~1"
	echo DKBash/DKINSTALL %bash_ENV%
	
	rem ###### GIT bash.exe ######
	if "%bash_ENV%" equ "GIT" (
		%dk_call% dk_validate GIT "%dk_call% dk_depend git"
		set "GIT_BASH_EXE=!GIT!/bin/bash.exe"
		set "GIT_BASH_ICON=!GIT!/git-bash.exe"
		set "BASH_EXE=!GIT_BASH_EXE!"
		set "BASH_ICON=!GIT_BASH_ICON!"
	)
		
	rem ###### MSYS2 bash.exe ######
	if "%bash_ENV%" equ "MSYS2" (
		echo %dk_call% dk_validate MSYS2 "%dk_call% dk_depend msys2"
		%dk_call% dk_validate MSYS2 "%dk_call% dk_depend msys2"
		set "MSYS2_BASH_EXE=!MSYS2!/usr/bin/bash.exe"
		set "MSYS2_BASH_ICON=!MSYS2!/msys2.exe"
		set "BASH_EXE=!MSYS2_BASH_EXE!"
		set "BASH_ICON=!MSYS2_BASH_ICON!"
	)

	
	%dk_call% dk_assertPath BASH_EXE
	%dk_call% dk_assertPath BASH_ICON
	
	::### return ###
	endlocal & (
		set "bash_ENV=%bash_ENV%"
		set "GIT_BASH_EXE=%GIT_BASH_EXE%"
		set "GIT_BASH_ICON=%GIT_BASH_ICON%"
		set "MSYS2_BASH_EXE=%MSYS2_BASH_EXE%"
		set "MSYS2_BASH_ICON=%MSYS2_BASH_ICON%"
		set "BASH_EXE=%BASH_EXE%"
		set "BASH_ICON=%BASH_ICON%"
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
	%dk_call% dk_echo "BASH_EXE = %BASH_EXE%"
%endfunction%
