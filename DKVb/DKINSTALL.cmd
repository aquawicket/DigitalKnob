@echo off
if "%~1" equ "" (goto:DKINSTALL)

:runDKVb
	set "cscript_exe=%~1"
	set "wscript_exe=%~2"
	set "DKVB_FUNCTIONS_DIR=%~3
	set "DKSCRIPT_PATH=%~4"
	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"
	set "ENGINE=vbscript"
	::set "ENGINE={16d51579-a30b-4c8b-a276-0ff4dc41e755}"
	
	::"%ComSpec%" /V:ON /K "%cscript_exe%" //E:vbscript //H:CScript "%DKSCRIPT_PATH%"
	::"%ComSpec%" /c %cscript_exe% //D //E:%ENGINE% //X //NoLogo "%DKVB_FUNCTIONS_DIR:\=/%/DK.vbs" "%DKSCRIPT_PATH:\=/%"
	"%ComSpec%" /c %cscript_exe% //D //E:%ENGINE% //X //NoLogo "%DKSCRIPT_PATH:\=/%"
	
	::&& (echo( & echo exit_code:true %errorlevel%) || (echo( & echo exit_code:false %errorlevel%)
	::%ComSpec% /c %wscript_exe% //d //nologo //e:javascript "%DKSCRIPT_PATH%"

%endfunction%


























:DKINSTALL
	if "%~1" neq "" (goto:eof)

	echo Installing DKVb . . .
	
	@echo off&::###### DK.cmd #########################################################################################################################
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/") 
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
	::#################################################################################################################################################
	
	::###### Install DKVb ######
	%dk_call% dk_validate cscript_exe "%dk_call% cscript"
	%dk_call% dk_validate wscript_exe "%dk_call% wscript"
	%dk_call% dk_validate DKVB_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"

	::ftype DKVb="%ComSpec%" /c call "%~f0" "%DKVB_FUNCTIONS_DIR%" "%cscript_exe%" "%%1" %*
	ftype DKVb=%ComSpec% /V:ON /K call "%~f0" "%cscript_exe%" "%wscript_exe%" "%DKVB_FUNCTIONS_DIR%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR/DKVb/DefaultIcon" "" "REG_SZ" "%cscript_exe%"
	assoc .vbs=DKVb
	
	ftype DKJavascript=%ComSpec% /V:ON /K call "%~f0" "%cscript_exe%" "%wscript_exe%" "%DKJAVASCRIPT_FUNCTIONS_DIR%" "%%1" %*


	%dk_call% dk_success "DKVb install complete"
%endfunction%