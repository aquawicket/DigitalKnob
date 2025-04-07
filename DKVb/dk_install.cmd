@echo off
if "%*" equ "" (goto dk_install)

:runDKVb
	set "DKVB_FUNCTIONS_DIR=%~1"
	set "CSCRIPT_EXE=%~2"
	set "DKSCRIPT_PATH=%~3"

	"%COMSPEC%" /V:ON /K "%CSCRIPT_EXE%" //E:vbscript //H:CScript "%DKSCRIPT_PATH%"
%endfunction%






























:dk_install
	if "%~1" neq "" (goto:eof)

	echo Installing DKVb . . .
	
	::###### DK_CMD ######
	if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r %USERPROFILE% DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
	if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)
	
	::###### Install DKVb ######
	%dk_call% dk_validate DKVB_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
	::set "WSCRIPT_EXE=%SystemRoot:\=/%/System32/WScript.exe"
	set "CSCRIPT_EXE=%SystemRoot:\=/%/System32/CScript.exe"

	%dk_call% dk_registryDeleteKey "HKCR/DKVb"
	ftype DKVb="%COMSPEC%" /c call "%~f0" "%DKVB_FUNCTIONS_DIR%" "%CSCRIPT_EXE%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR/DKVb/DefaultIcon" "" "REG_SZ" "%CSCRIPT_EXE%"
	assoc .vbs=DKVb

	%dk_call% dk_success "DKVb install complete"
%endfunction%