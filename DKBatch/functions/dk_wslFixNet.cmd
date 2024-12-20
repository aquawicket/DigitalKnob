@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*



::##################################################################################
::# dk_wslFixNet(message)
::#
::#    https://github.com/microsoft/WSL/issues/5420#issuecomment-646479747
::#
:dk_wslFixNet
    call dk_debugFunc 0
 setlocal

	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_validate WSL_EXE "call %DKIMPORTS_DIR%\wsl\dk_installWsl.cmd"

	%dk_call% dk_validate DKBASH_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
	if not exist "%DKBASH_FUNCTIONS_DIR%" 		set "DKBASH_FUNCTIONS_DIR=%CD%\DKBash\functions"
	if not exist "%DKBASH_FUNCTIONS_DIR_%"      set "%DKBASH_FUNCTIONS_DIR%\"
	if not exist "%DKBASH_FUNCTIONS_DIR%"		mkdir "%DKBASH_FUNCTIONS_DIR%"
	if not defined DKHTTP_DKBASH_DIR            set "DKHTTP_DKBASH_DIR=%DKHTTP_DKBRANCH_DIR%/DKBash"
	if not defined DKHTTP_DKBASH_FUNCTIONS_DIR  set "DKHTTP_DKBASH_FUNCTIONS_DIR=%DKHTTP_DKBASH_DIR%/functions"
	if not exist %DKBASH_FUNCTIONS_DIR%\DK.sh %dk_call% dk_download "%DKHTTP_DKBASH_FUNCTIONS_DIR%/DK.sh" "%DKBASH_FUNCTIONS_DIR%/DK.sh"
	
	::%dk_call% dk_callDKBash dk_wslFixNet
	set DKBASH_COMMAND="%WSL_EXE% sh -c '. %DKBASH_FUNCTIONS_DIR%/dk_wslFixNet.sh ^&^& dk_wslFixNet'"
	%DKBASH_COMMAND%

%endfunction%








::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_wslFixNet
%endfunction%
