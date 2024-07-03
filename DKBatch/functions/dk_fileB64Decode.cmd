@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd


::##################################################################################
::# dk_fileB64Decode(inputFile)
::# dk_fileB64Decode(inputFile, outputFile)
::#
::#    Decode base-64 input to output
::#    https://github.com/base64code/examples
::#
:dk_fileB64Decode () {
	call dk_debugFunc
	if %__ARGC__% lss 1 (call dk_error "%__FUNCTION__%(%__ARGC__%): not enough arguments")
	if %__ARGC__% gtr 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): too many arguments")
	
	set "inputFile=%~1"
	call dk_removeExtension %inputFile% outputFile
	call dk_printVar outputFile
	if "%~2" neq "" set "outputFile=%~2"
	call dk_printVar outputFile
	pause
	
	if not exist "%inputFile%" call dk_error "%inputFile% not found"
	if exist "%outputFile%" call dk_error "%outputFile% already exists and cannot be overwritten"
	
	certutil -decode "%inputFile%" "%outputFile%"
goto:eof





:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	call dk_debugFunc
	
	call dk_validate DKBRANCH_DIR "call dk_validateBranch"
	set "input=%DKBRANCH_DIR%\DKBuilder.cmd.b64"
	set "output=%DKBRANCH_DIR%\DKBuilder_decoded.cmd"
	call dk_fileB64Decode "%input%" "%output%"
	::call dk_fileB64Decode "%input%"
goto:eof