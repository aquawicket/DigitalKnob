@echo off
if "%~1" equ "" (goto :dk_install)

:runDKHta

	:: TODO

%endfunction%




















:dk_install
	if "%~1" neq "" (goto:eof)

	::###### DK_CMD ######
	if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../DKBatch/functions/")
	if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)
	%dk_call% dk_assertPath DKBATCH_FUNCTIONS_DIR_

	::###### Install DKBash ######
	%dk_call% dk_echo "Installing DKHta . . ."
	set "MSHTA_EXE=%WINDIR:\=/%/SysWOW64/mshta.exe"
	%dk_call% dk_assertPath MSHTA_EXE
	set "DKHTA_FUNCTIONS_DIR=../DKHta/functions"

	::ftype DKHta="%WINDIR:\=/%/SysWOW64/mshta.exe" "%1" {1E460BD7-F1C3-4B2E-88BF-4E770A288AF5}%U{1E460BD7-F1C3-4B2E-88BF-4E770A288AF5} %*
	::ftype DKHta=%COMSPEC% /c call "%~f0" "%DKHTA_FUNCTIONS_DIR%" "%MSHTA_EXE%" "%%1" %*
	ftype DKHta=%MSHTA_EXE% "%%1" %*
	%dk_call% dk_registrySetKey "HKCR/DKHta/DefaultIcon" "" "REG_SZ" "%MSHTA_EXE%"
	assoc .hta=DKHta

	%dk_call% dk_success "DKHta install complete"
%endfunction%
