:: https://en.wikipedia.org/wiki/JScript

@echo off
if "%~1" equ "" (goto:DKINSTALL)

:runDKJavascript
	set "cscript_exe=%~1"
	set "wscript_exe=%~2"
	set "DKJAVASCRIPT_FUNCTIONS_DIR=%~3
	set "DKSCRIPT_PATH=%~4"
	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"
	::set "ENGINE=javascript"
	set "ENGINE={16d51579-a30b-4c8b-a276-0ff4dc41e755}"
	
	
	"%ComSpec%" /c %cscript_exe% //D //E:%ENGINE% //X //NoLogo "%DKJAVASCRIPT_FUNCTIONS_DIR:\=/%/DK.js" "%DKSCRIPT_PATH:\=/%" && goto:exittrue || goto:exitfalse
	echo ###### DKJavascript/DKINSTALL.cmd:14 - SHOULD NOT GET HERE ######
	goto:exitdone
	:exittrue
		set "exit_code=%errorlevel%"
		set "exitbool=true"
		goto:exitdone
	:exitfalse
		set "exit_code=%errorlevel%"
		set "exitbool=false"
	:exitdone
	echo exit_code = %exit_code%
	echo exitbool = %exitbool%

%endfunction%


























:DKINSTALL
	if "%~1" neq "" (goto:eof)

	echo Installing DKJavascript . . .
	
	@echo off&::###### DK.cmd #########################################################################################################################
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/") 
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
	::#################################################################################################################################################

	::###### Install DKJavascript ######
	%dk_call% dk_validate cmd_exe 		"%dk_call% cmd"
	%dk_call% dk_validate cscript_exe 	"%dk_call% cscript"
	%dk_call% dk_validate wscript_exe 	"%dk_call% wscript"
	%dk_call% dk_validate DKJAVASCRIPT_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"

	ftype DKJavascript=%cmd_exe% /V:ON /K call "%~f0" "%cscript_exe%" "%wscript_exe%" "%DKJAVASCRIPT_FUNCTIONS_DIR%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR\DKJavascript\DefaultIcon" "" "REG_SZ" "%cscript_exe%"
	assoc .js=DKJavascript
	
	%dk_call% dk_success "DKJavascript install complete"
%endfunction%