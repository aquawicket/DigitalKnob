@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd


::##################################################################################
::# dk_fileB64Encode(inputFile)
::# dk_fileB64Encode(inputFile, outputFile)
::#
::#    Encode input to base-64 output
::#    https://github.com/base64code/examples
::#
:dk_fileB64Encode
	call dk_debugFunc
	if %__ARGC__% lss 1 call dk_error "%__FUNCTION__%:%__ARGV__%: not enough arguments")
	if %__ARGC__% gtr 2 call dk_error "%__FUNCTION__%:%__ARGV__%: too many arguments")
	
	set "inputFile=%~1"
	set "outputFile=%inputFile%.b64"
	if %__ARGC__% equ 2 set "outputFile=%~2"
	
	if not exist "%inputFile%" call dk_error "%inputFile% not found"
	if exist "%outputFile%" call dk_error "%outputFile% already exists and cannot be overwritten"
	
	certutil -encode -f "%inputFile%" "%outputFile%.tmp" 1>nul
	type "%outputFile%.tmp"|find /v "CERTIFICATE-----">"%outputFile%"
	del "%outputFile%.tmp"
goto:eof





::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_validate DKBRANCH_DIR "call dk_validateBranch"
	set "input=%DKBRANCH_DIR%\DKBuilder.cmd"
	::set "output=%DKBRANCH_DIR%\DKBuilder.cmd.b64"
	
	call dk_fileB64Encode "%input%"
	::call dk_fileB64Encode "%input%" "test.b64"
goto:eof
