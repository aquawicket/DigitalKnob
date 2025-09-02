@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/") 
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################

set "DKBash_ENV=GIT"
::set "DKBash_ENV=MSYS2"
::set "DKBash_ENV=WSL"
::set "DKBash_ENV=WSL2"


:DKINSTALL
%setlocal%
	if "%~1" neq "" (
		%dk_call% dk_fatal "DKBash/DKINSTALL.cmd does NOT take arguments"
		exit /b -1
	)

	::###### Install DKBash ######
	echo Installing DKBash . . .
	%dk_call% dk_validate CMD_EXE "%dk_call% dk_CMD_EXE"
	
	::########### (GIT) #############
	if /i "%DKBash_ENV%" equ "GIT" (%dk_call% dk_validate bash_exe "%dk_call% dk_depend bash GIT")
	if /i "%DKBash_ENV%" equ "GIT" (%dk_call% dk_assertPath bash_exe)
	if /i "%DKBash_ENV%" equ "GIT" (set bash_exe="%bash_exe%")
	if /i "%DKBash_ENV%" equ "GIT" (set "BASH_C_DIVE=/c")
	
	::########### (MSYS2) #############
	if /i "%DKBash_ENV%" equ "MSYS2" (%dk_call% dk_validate bash_exe "%dk_call% dk_depend bash MSYS2")
	if /i "%DKBash_ENV%" equ "MSYS2" (%dk_call% dk_assertPath bash_exe)
	if /i "%DKBash_ENV%" equ "MSYS2" (set bash_exe="%bash_exe%")
	if /i "%DKBash_ENV%" equ "MSYS2" (set "BASH_C_DIVE=/c")
	
	::############ (WSL) ############
	if /i "%DKBash_ENV%" equ "WSL" (%dk_call% dk_validate bash_exe "%dk_call% dk_depend bash WSL")
	if /i "%DKBash_ENV%" equ "WSL" (%dk_call% dk_assertPath bash_exe)
	if /i "%DKBash_ENV%" equ "WSL" (set bash_exe="%bash_exe%")
	if /i "%DKBash_ENV%" equ "WSL" (set "BASH_C_DIVE=/mnt/c")
	
	::############ (WSL2) ############
	if /i "%DKBash_ENV%" equ "WSL2" (%dk_call% dk_validate WSL_EXE "%dk_call% dk_depend wsl")
	if /i "%DKBash_ENV%" equ "WSL2" (%dk_call% dk_assertPath WSL_EXE)
	if /i "%DKBash_ENV%" equ "WSL2" (set "BASH_ICON=%WSL_EXE%")
	if /i "%DKBash_ENV%" equ "WSL2" (set bash_exe="%WSL_EXE%" bash)
	if /i "%DKBash_ENV%" equ "WSL2" (set "BASH_C_DIVE=/mnt/c")
	
	::### Add the DKBash command to the registry ###
	set "PATH=%PATH%"
	ftype DKBash="%CMD_EXE:/=\%" /V:ON /k set "f=%%1" ^&^& set "f=^!f:\=/^!" ^&^& set "f=^!f:C:=%BASH_C_DIVE%^!" ^&^& %bash_exe% "^!f^!"
	:: "C:\Users\Administrator\DigitalKnob\Development\3rdParty\msys2-base-x86_64-20241208\usr\bin\bash.exe" -c "/c/Users/Administrator/DigitalKnob/Development/DKBash/functions/dk_debug.sh"
	:: "C:\Users\Administrator\DigitalKnob\Development\3rdParty\msys2-base-x86_64-20241208\usr\bin\env.exe" MSYSTEM=MSYS /usr/bin/bash "/c/Users/Administrator/DigitalKnob/Development/DKBash/functions/dk_debug.sh"
	::### associate .sh with DKBash ###	
	assoc .sh=DKBash
	
	::########### ICON #############
	::%dk_call% dk_assertPath BASH_ICON
	%dk_call% dk_registrySetKey "HKCR\DKBash\DefaultIcon" "" "REG_SZ" "%BASH_ICON%"
	
	%dk_call% dk_success "DKBash install complete"
%endfunction%