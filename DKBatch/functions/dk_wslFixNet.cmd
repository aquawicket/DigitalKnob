@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################



::##################################################################################
::# dk_wslFixNet(message)
::#
::#    https://github.com/microsoft/WSL/issues/5420#issuecomment-646479747
::#
:dk_wslFixNet
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate WSL_EXE "%dk_call% dk_depend wsl"

	%dk_call% dk_validate DKBASH_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
	if NOT EXIST "%DKBASH_FUNCTIONS_DIR%" 		set "DKBASH_FUNCTIONS_DIR=%CD%\DKBash\functions"
	if NOT EXIST "%DKBASH_FUNCTIONS_DIR_%"      set "%DKBASH_FUNCTIONS_DIR%\"
	if NOT EXIST "%DKBASH_FUNCTIONS_DIR%"		mkdir "%DKBASH_FUNCTIONS_DIR%"
	if NOT defined DKHTTP_DKBASH_DIR            set "DKHTTP_DKBASH_DIR=%DKHTTP_DKBRANCH_DIR%/DKBash"
	if NOT defined DKHTTP_DKBASH_FUNCTIONS_DIR  set "DKHTTP_DKBASH_FUNCTIONS_DIR=%DKHTTP_DKBASH_DIR%/functions"
	if NOT EXIST "%DKBASH_FUNCTIONS_DIR%\DK.sh" %dk_call% dk_download "%DKHTTP_DKBASH_FUNCTIONS_DIR%/DK.sh" "%DKBASH_FUNCTIONS_DIR%/DK.sh"
	
	::%dk_call% dk_callDKBash dk_wslFixNet
	set DKBASH_COMMAND="%WSL_EXE% sh -c '. %DKBASH_FUNCTIONS_DIR%/dk_wslFixNet.sh ^&^& dk_wslFixNet'"
	%DKBASH_COMMAND%

%endfunction%








::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_wslFixNet
%endfunction%
