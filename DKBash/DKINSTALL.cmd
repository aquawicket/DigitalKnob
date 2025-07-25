@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/") 
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################

::set "DKBash_ENV=CMD"
set "DKBash_ENV=WSL"
::set "DKBash_ENV=WSL2"


:DKINSTALL
%setlocal%
	if "%~1" neq "" (
		%dk_call% dk_fatal "DKBash/DKINSTALL.cmd does not take arguments"
		exit /b -1
	)

	::###### Install DKBash ######
	echo Installing DKBash . . .
	%dk_call% dk_validate CMD_EXE "%dk_call% dk_CMD_EXE"
	
	::########### (CMD) #############
	if "%DKBash_ENV%" equ "CMD" (%dk_call% dk_validate BASH_EXE "%dk_call% dk_depend bash")
	if "%DKBash_ENV%" equ "CMD" (%dk_call% dk_assertPath BASH_EXE)
	if "%DKBash_ENV%" equ "CMD" (set BASH_EXE="%BASH_EXE%")
	if "%DKBash_ENV%" equ "CMD" (set "BASH_C_DIVE=/c")
	
	::############ (WSL) ############
	if "%DKBash_ENV%" equ "WSL" (%dk_call% dk_validate WSL_EXE "%dk_call% dk_depend wsl")
	if "%DKBash_ENV%" equ "CMD" (%dk_call% dk_assertPath WSL_EXE)
	if "%DKBash_ENV%" equ "WSL" (set "BASH_EXE=C:/Windows/System32/bash.exe")
	if "%DKBash_ENV%" equ "WSL" (%dk_call% dk_assertPath BASH_EXE)
	if "%DKBash_ENV%" equ "WSL" (set BASH_EXE="%BASH_EXE%")
	if "%DKBash_ENV%" equ "WSL" (set "BASH_C_DIVE=/mnt/c")
	
::	::############ (WSL2) ############
::	if "%DKBash_ENV%" equ "WSL2" (%dk_call% dk_validate dk_WSL_EXE "%dk_call% dk_WSL_EXE")
::	if "%DKBash_ENV%" equ "WSL2" (%dk_call% dk_assertPath WSL_EXE)
::	if "%DKBash_ENV%" equ "WSL2" (set BASH_EXE="%WSL_EXE%" bash)
::	if "%DKBash_ENV%" equ "WSL2" (set "BASH_C_DIVE=/mnt/c")
	
	ftype DKBash="%CMD_EXE:/=\%" /V:ON /k set "f=%%1" ^&^& set "f=^!f:\=/^!" ^&^& set "f=^!f:C:=%BASH_C_DIVE%^!" ^&^& %BASH_EXE% -c "^!f^!"

	
	
	assoc .sh=DKBash
	
	::########### ICON #############
	if "%DKBash_ENV%" equ "CMD" (%dk_call% dk_validate BASH_ICON "%dk_call% dk_depend bash")
	if "%DKBash_ENV%" equ "WSL" (%dk_call% dk_validate BASH_ICON "set BASH_ICON=%WSL_EXE%")
::	if "%DKBash_ENV%" equ "WSL2" (%dk_call% dk_validate BASH_ICON "set BASH_ICON=%WSL_EXE%")
	
	%dk_call% dk_assertPath BASH_ICON
	%dk_call% dk_registrySetKey "HKCR\DKBash\DefaultIcon" "" "REG_SZ" "%BASH_ICON%"
	
	
	%dk_call% dk_success "DKBash install complete"
%endfunction%