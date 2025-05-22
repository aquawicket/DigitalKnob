@echo off
if "%~1" equ "" (goto:DKINSTALL)

:runDKVb
	set "CSCRIPT_EXE=%~1"
	set "WSCRIPT_EXE=%~2"
	set "DKVB_FUNCTIONS_DIR=%~3
	set "DKSCRIPT_PATH=%~4"
	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"
	set "ENGINE=vbscript"
	::set "ENGINE={16d51579-a30b-4c8b-a276-0ff4dc41e755}"
	
	::"%ComSpec%" /V:ON /K "%CSCRIPT_EXE%" //E:vbscript //H:CScript "%DKSCRIPT_PATH%"
	::"%ComSpec%" /c %CSCRIPT_EXE% //D //E:%ENGINE% //X //NoLogo "%DKVB_FUNCTIONS_DIR:\=/%/DK.vbs" "%DKSCRIPT_PATH:\=/%"
	"%ComSpec%" /c %CSCRIPT_EXE% //D //E:%ENGINE% //X //NoLogo "%DKSCRIPT_PATH:\=/%"
	
	::&& (echo: & echo exit_code:true %errorlevel%) || (echo: & echo exit_code:false %errorlevel%)
	::%ComSpec% /c %WSCRIPT_EXE% //d //nologo //e:javascript "%DKSCRIPT_PATH%"

%endfunction%


























:DKINSTALL
	if "%~1" neq "" (goto:eof)

	echo Installing DKVb . . .
	
	::###### DK.cmd ######
	if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/")
	if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
	
	::###### Install DKVb ######
	set "CSCRIPT_EXE=cscript.exe"
	set "WSCRIPT_EXE=wscript.exe"
	%dk_call% dk_validate DKVB_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"

	::ftype DKVb="%ComSpec%" /c call "%~f0" "%DKVB_FUNCTIONS_DIR%" "%CSCRIPT_EXE%" "%%1" %*
	ftype DKVb=%ComSpec% /V:ON /K call "%~f0" "%CSCRIPT_EXE%" "%WSCRIPT_EXE%" "%DKVB_FUNCTIONS_DIR%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR/DKVb/DefaultIcon" "" "REG_SZ" "%CSCRIPT_EXE%"
	assoc .vbs=DKVb
	
	ftype DKJavascript=%ComSpec% /V:ON /K call "%~f0" "%CSCRIPT_EXE%" "%WSCRIPT_EXE%" "%DKJAVASCRIPT_FUNCTIONS_DIR%" "%%1" %*


	%dk_call% dk_success "DKVb install complete"
%endfunction%