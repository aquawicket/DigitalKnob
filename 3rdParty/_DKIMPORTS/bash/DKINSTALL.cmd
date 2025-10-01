@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


set "bash_Default=git" &:: git, msys2, wsl
::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
%setlocal%
	%dk_call% dk_debugFunc 1
	
	if exist "%bash_exe%" (
		if /i "%bash_env%" equ "%~1" (
			%return%
		)
	)
	
	set "bash_env=%~1"
	if "%bash_env%" equ "" (set "bash_env=%bash_Default%")
	
	rem ###### git ######
	if /i "%bash_env%" equ "git" (
		%dk_call% dk_validate git "%dk_call% dk_depend git"
		set "git_bash_exe=!git!/bin/bash.exe"
		set "git_bash_icon=!git!/git-bash.exe"
		set "bash_exe=!git_bash_exe!"
		set "bash_icon=!git_bash_icon!"
	)
		
	rem ###### msys2 ######
	if /i "%bash_env%" equ "msys2" (
		%dk_call% dk_validate msys2 "%dk_call% dk_depend msys2"
		set "msys2_bash_exe=!msys2!/usr/bin/bash.exe"
		set "msys2_bash_icon=!msys2!/msys2.exe"
		set "bash_exe=!msys2_bash_exe!"
		set "bash_icon=!msys2_bash_icon!"
	)
	
	rem ###### WSL ######
	if /i "%bash_env%" equ "wsl" (
		%dk_call% dk_validate wsl_exe "%dk_call% dk_depend wsl_exe"
		set "wsl_bash_exe=%windir:\=/%/System32/bash.exe"
		set "wsl_bash_icon=!wsl_exe!"
		set "bash_exe=!wsl_bash_exe!"
		set "bash_icon=!wsl_bash_icon!"
	)

	%dk_call% dk_assertPath bash_exe
	%dk_call% dk_assertPath bash_icon
	
	::### return ###
	endlocal & (
		set "bash_env=%bash_env%"
		set "git_bash_exe=%git_bash_exe%"
		set "git_bash_icon=%git_bash_icon%"
		set "msys2_bash_exe=%msys2_bash_exe%"
		set "msys2_bash_icon=%msys2_bash_icon%"
		set "wsl_bash_exe=%wsl_bash_exe%"
		set "wsl_bash_icon=%wsl_bash_icon%"
		set "bash_exe=%bash_exe%"
		set "bash_icon=%bash_icon%"
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
	%dk_call% dk_debug "bash_exe = %bash_exe%"
%endfunction%
