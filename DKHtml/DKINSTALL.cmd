@echo off
if "%~1" equ "" (goto :DKINSTALL)

:runDKHtml

	:: TODO

%endfunction%




















:DKINSTALL
	if "%~1" neq "" (goto :eof)
	
	echo Installing DKHtml . . .
	
	::###### DK.cmd ######
	if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/")
	if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
	
	::###### Install DKHtml ######
	set "BROWSER_EXE=C:/Program Files/BraveSoftware/Brave-Browser/Application/brave.exe"
	%dk_call% dk_assertPath BROWSER_EXE
	set "DKHTML_FUNCTIONS_DIR=../DKHtml/functions"
	ftype DKHtml=%BROWSER_EXE% "%%1" %*
	%dk_call% dk_registrySetKey "HKCR/DKHtml/DefaultIcon" "" "REG_SZ" "%BROWSER_EXE%"
	assoc .html=DKHtml

	%dk_call% dk_success "DKHtml install complete"
%endfunction%
