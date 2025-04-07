@echo off
if "%~1" equ "" (goto:dk_install)

:runDKJScript
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


























:dk_install
	if "%~1" neq "" (goto:eof)

	echo Installing DKJScript . . .
	
	::###### DK_CMD ######
	if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r %USERPROFILE% DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
	if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

	::###### Install DKJScript ######
	set "CSCRIPT_EXE=cscript.exe"
	set "WSCRIPT_EXE=wscript.exe"
	%dk_call% dk_validate DKJAVASCRIPT_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"

	ftype DKJScript=%COMSPEC% /V:ON /K call "%~f0" "%CSCRIPT_EXE%" "%WSCRIPT_EXE%" "%DKJAVASCRIPT_FUNCTIONS_DIR%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR\DKJScript\DefaultIcon" "" "REG_SZ" "%CSCRIPT_EXE%"
	assoc .js=DKJScript
	
	%dk_call% dk_success "DKJScript install complete"
%endfunction%