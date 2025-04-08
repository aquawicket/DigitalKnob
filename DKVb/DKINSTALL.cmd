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
	
	::"%COMSPEC%" /V:ON /K "%CSCRIPT_EXE%" //E:vbscript //H:CScript "%DKSCRIPT_PATH%"
	::"%COMSPEC%" /c %CSCRIPT_EXE% //D //E:%ENGINE% //X //NoLogo "%DKVB_FUNCTIONS_DIR:\=/%/DK.vbs" "%DKSCRIPT_PATH:\=/%"
	"%COMSPEC%" /c %CSCRIPT_EXE% //D //E:%ENGINE% //X //NoLogo "%DKSCRIPT_PATH:\=/%" 
	
	::&& (echo: & echo exit_status:true %errorlevel%) || (echo: & echo exit_status:false %errorlevel%)
	::%COMSPEC% /c %WSCRIPT_EXE% //d //nologo //e:javascript "%DKSCRIPT_PATH%"

%endfunction%


























:DKINSTALL
	if "%~1" neq "" (goto:eof)

	echo Installing DKVb . . .
	
	::###### DK_CMD ######
	if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r %USERPROFILE% DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
	if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)
	
	::###### Install DKVb ######
	set "CSCRIPT_EXE=cscript.exe"
	set "WSCRIPT_EXE=wscript.exe"
	%dk_call% dk_validate DKVB_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"

	::ftype DKVb="%COMSPEC%" /c call "%~f0" "%DKVB_FUNCTIONS_DIR%" "%CSCRIPT_EXE%" "%%1" %*
	ftype DKVb=%COMSPEC% /V:ON /K call "%~f0" "%CSCRIPT_EXE%" "%WSCRIPT_EXE%" "%DKVB_FUNCTIONS_DIR%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR/DKVb/DefaultIcon" "" "REG_SZ" "%CSCRIPT_EXE%"
	assoc .vbs=DKVb
	
	ftype DKJavascript=%COMSPEC% /V:ON /K call "%~f0" "%CSCRIPT_EXE%" "%WSCRIPT_EXE%" "%DKJAVASCRIPT_FUNCTIONS_DIR%" "%%1" %*


	%dk_call% dk_success "DKVb install complete"
%endfunction%