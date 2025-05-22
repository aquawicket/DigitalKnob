@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_allButFirstArgs(args)
::#
::#
:dk_allButFirstArgs
%setlocal%
    %dk_call% dk_debugFunc 1 99

	set dk_allButFirstArgs=%*
	for /f "tokens=1*" %%a in ("!dk_allButFirstArgs!") do endlocal & (
		set dk_allButFirstArgs=%%b
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	
    call :DKTEST_func abc 123 def 456
	call :DKTEST_func "abc" "123" "def" "456"
	call :DKTEST_func	abc	123	def	456
%endfunction%

:DKTEST_func
%setlocal%
	%dk_call% dk_debugFunc 0 99
	
	echo:
	echo: before
	call :DKTEST_printArgs %*
	
	call :dk_allButFirstArgs %*
	
	echo: after
	call :DKTEST_printArgs %dk_allButFirstArgs%
%endfunction%
	
:DKTEST_printArgs
%setlocal%
	%dk_call% dk_debugFunc 0 99
	
	echo * = '%*'
	if "%~1" neq "" (echo 1 = '%1')
	if "%~2" neq "" (echo 2 = '%2')
	if "%~3" neq "" (echo 3 = '%3')
	if "%~4" neq "" (echo 4 = '%4')
	if "%~5" neq "" (echo 5 = '%5')
	if "%~6" neq "" (echo 6 = '%6')
	if "%~7" neq "" (echo 7 = '%7')
	if "%~8" neq "" (echo 8 = '%8')
	if "%~9" neq "" (echo 9 = '%9')
%endfunction%
