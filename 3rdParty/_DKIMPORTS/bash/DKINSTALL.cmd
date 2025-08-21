@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


set "bash_DEFAULT=GIT" &:: GIT, MSYS2, WSL
::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
%setlocal%
	%dk_call% dk_debugFunc 1
	
	if EXIST "%BASH_EXE%" (
		if "%bash_ENV%" equ "%~1" (
			%return%
		)
	)
	
	set "bash_ENV=%~1"
	if "%bash_ENV%" equ "" (set "bash_ENV=%bash_DEFAULT%")
	
	rem ###### GIT ######
	if /i "%bash_ENV%" equ "GIT" (
		%dk_call% dk_validate GIT "%dk_call% dk_depend git"
		set "GIT_BASH_EXE=!GIT!/bin/bash.exe"
		set "GIT_BASH_ICON=!GIT!/git-bash.exe"
		set "BASH_EXE=!GIT_BASH_EXE!"
		set "BASH_ICON=!GIT_BASH_ICON!"
	)
		
	rem ###### MSYS2 ######
	if "%bash_ENV%" equ "MSYS2" (
		%dk_call% dk_validate MSYS2 "%dk_call% dk_depend msys2"
		set "MSYS2_BASH_EXE=!MSYS2!/usr/bin/bash.exe"
		set "MSYS2_BASH_ICON=!MSYS2!/msys2.exe"
		set "BASH_EXE=!MSYS2_BASH_EXE!"
		set "BASH_ICON=!MSYS2_BASH_ICON!"
	)
	
	rem ###### WSL ######
	if "%bash_ENV%" equ "WSL" (
		%dk_call% dk_validate WSL_EXE "%dk_call% dk_depend wsl"
		%dk_call% dk_assertPath WSL_EXE
		set "WSL_BASH_EXE=C:/Windows/System32/bash.exe"
		set "WSL_BASH_ICON=!WSL_EXE!"
		set "BASH_EXE=!WSL_BASH_EXE!"
		set "BASH_ICON=!WSL_BASH_ICON!"
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
		set "WSL_BASH_EXE=%WSL_BASH_EXE%"
		set "WSL_BASH_ICON=%WSL_BASH_ICON%"
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
