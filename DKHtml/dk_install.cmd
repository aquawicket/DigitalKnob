@echo off
if "%~1" equ "" (goto :dk_install)

:runDKHtml

	:: TODO

%endfunction%




















:dk_install
	if "%~1" neq "" (goto :eof)
	
	set "BROWSER_EXE=C:/Program Files/BraveSoftware/Brave-Browser/Application/brave.exe"
	%dk_call% dk_assertPath BROWSER_EXE
	
	::###### DK_CMD ######
	if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../DKBatch/functions/")
	%dk_call% dk_assertPath DKBATCH_FUNCTIONS_DIR_
	if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)
	
	::###### Install DKHtml ######
	%dk_call% dk_echo "Installing DKHtml . . ."
	set "DKHTML_FUNCTIONS_DIR=../DKHtml/functions"
	ftype DKHtml=%BROWSER_EXE% "%%1" %*
	%dk_call% dk_registrySetKey "HKCR/DKHtml/DefaultIcon" "" "REG_SZ" "%BROWSER_EXE%"
	assoc .html=DKHtml

	%dk_call% dk_success "DKHtml install complete"
%endfunction%
