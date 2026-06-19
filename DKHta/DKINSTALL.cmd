@echo off
if "%~1" equ "" (goto :DKINSTALL)

:runDKHta

	:: TODO

%endfunction%




















:DKINSTALL
	if "%~1" neq "" (goto:eof)

	echo Installing DKHta . . .
	
	@echo off&rem ###### DK.cmd #########################################################################################################################
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/") 
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	if not defined DKINIT_cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %* && exit /b %errorlevel%)
	rem #################################################################################################################################################

	::###### Install DKHta ######
	%dk_call% dk_validate mshta.exe %dk_call% dk_findFile mshta.exe
	%dk_call% dk_assertPath mshta.exe
	set "DKHTA_FUNCTIONS_DIR=../DKHta/functions"

	::ftype DKHta="%windir:\=/%/SysWOW64/mshta.exe" "%1" {1E460BD7-F1C3-4B2E-88BF-4E770A288AF5}%U{1E460BD7-F1C3-4B2E-88BF-4E770A288AF5} %*
	::ftype DKHta=%ComSpec% /c call "%~f0" "%DKHTA_FUNCTIONS_DIR%" "%mshta.exe%" "%%1" %*
	ftype DKHta=%mshta.exe:/=\% "%%1" %*
	%dk_call% dk_registrySetKey "HKCR/DKHta/DefaultIcon" "" "REG_SZ" "%mshta.exe%"
	assoc .hta=DKHta

	%dk_call% dk_success "DKHta install complete"
%endfunction%
