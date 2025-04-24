@echo off
if "%~1" equ "" (goto :DKINSTALL)

:runDKHta

	:: TODO

%endfunction%




















:DKINSTALL
	if "%~1" neq "" (goto:eof)

	echo Installing DKHta . . .
	
	::###### DK.cmd ######
	if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/")
	if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

	::###### Install DKHta ######
	set "MSHTA_EXE=%WINDIR:\=/%/SysWOW64/mshta.exe"
	%dk_call% dk_assertPath MSHTA_EXE
	set "DKHTA_FUNCTIONS_DIR=../DKHta/functions"

	::ftype DKHta="%WINDIR:\=/%/SysWOW64/mshta.exe" "%1" {1E460BD7-F1C3-4B2E-88BF-4E770A288AF5}%U{1E460BD7-F1C3-4B2E-88BF-4E770A288AF5} %*
	::ftype DKHta=%ComSpec% /c call "%~f0" "%DKHTA_FUNCTIONS_DIR%" "%MSHTA_EXE%" "%%1" %*
	ftype DKHta=%MSHTA_EXE:/=\% "%%1" %*
	%dk_call% dk_registrySetKey "HKCR/DKHta/DefaultIcon" "" "REG_SZ" "%MSHTA_EXE%"
	assoc .hta=DKHta

	%dk_call% dk_success "DKHta install complete"
%endfunction%
