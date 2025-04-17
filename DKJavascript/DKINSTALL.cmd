@echo off
if "%~1" equ "" (goto:DKINSTALL)

:runDKJavascript
	set "CSCRIPT_EXE=%~1"
	set "WSCRIPT_EXE=%~2"
	set "DKJAVASCRIPT_FUNCTIONS_DIR=%~3
	set "DKSCRIPT_PATH=%~4"
	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"
	set "ENGINE=javascript"
	::set "ENGINE={16d51579-a30b-4c8b-a276-0ff4dc41e755}"
	
	"%COMSPEC%" /c %CSCRIPT_EXE% //D //E:%ENGINE% //X //NoLogo "%DKJAVASCRIPT_FUNCTIONS_DIR:\=/%/DK.js" "%DKSCRIPT_PATH:\=/%" 
	
	::&& (echo: & echo exit_status:true %errorlevel%) || (echo: & echo exit_status:false %errorlevel%)
	::%COMSPEC% /c %WSCRIPT_EXE% //d //nologo //e:javascript "%DKSCRIPT_PATH%"

%endfunction%


























:DKINSTALL
	if "%~1" neq "" (goto:eof)

	echo Installing DKJavascript . . .
	
	::###### DK.cmd ######
	if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/")
	if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
	if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

	::###### Install DKJavascript ######
	set "CSCRIPT_EXE=cscript.exe"
	set "WSCRIPT_EXE=wscript.exe"
	%dk_call% dk_validate DKJAVASCRIPT_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"

	ftype DKJavascript=%COMSPEC% /V:ON /K call "%~f0" "%CSCRIPT_EXE%" "%WSCRIPT_EXE%" "%DKJAVASCRIPT_FUNCTIONS_DIR%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR\DKJavascript\DefaultIcon" "" "REG_SZ" "%CSCRIPT_EXE%"
	assoc .js=DKJavascript
	
	%dk_call% dk_success "DKJavascript install complete"
%endfunction%