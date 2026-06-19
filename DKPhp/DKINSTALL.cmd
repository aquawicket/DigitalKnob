@echo off

::if "%~1" equ "" (goto:DKINSTALL)

:::runDKPhp
::	set "DKPHP_FUNCTIONS_DIR=%~1"
::	set "php_exe=%~2"
::	set "DKSCRIPT_PATH=%~3"
::	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"
::
::	::###### run script ######'
::	"%ComSpec%" /V:ON /K call %php_exe% "%DKSCRIPT_PATH%"
::	::"%ComSpec%" /V:ON /K call "%php_exe%" -r "include('%DKSCRIPT_PATH:\=/%');DKTEST();"
::	::###### exit_code ######
::	if %ERRORLEVEL% neq 0 (
::		echo ERROR:%ERRORLEVEL%
::		pause
::	)
::%endfunction%




















:DKINSTALL
	if "%~1" neq "" (goto:eof)

	@echo off&rem ###### DK.cmd #########################################################################################################################
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/") 
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	if not defined DKINIT_cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %* && exit /b %errorlevel%)
	rem #################################################################################################################################################

	::###### Install DKPhp ######
	%dk_call% dk_echo "Installing DKPhp . . ."
	%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
	%dk_call% dk_validate php_exe %dk_call% dk_depend php-src
	%dk_call% dk_assertPath php_exe

	ftype DKPhp="%ComSpec%" /V:ON /K call %php_exe% "%%1" %*
	%dk_call% dk_registrySetKey "HKCR/DKPhp/DefaultIcon" "" "REG_SZ" "%php_exe%"
	assoc .php=DKPhp

	%dk_call% dk_success "DKPhp install complete"
%endfunction%