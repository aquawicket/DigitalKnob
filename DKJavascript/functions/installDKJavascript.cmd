@echo off

:install_cmake_fileAssociation
	if not "%*" == "" (goto:run_javascript_file)
	echo Associating .cmake files with DKJavascript . . .
	
	::###### DKINIT ######
	set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
	set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\Development"
	set "DKBATCH_FUNCTION_DIR=%DKBRANCH_DIR%\DKBatch\functions"
	set "DKBATCH_FUNCTION_DIR_=%DKBATCH_FUNCTION_DIR%\"
	call "%DKBATCH_FUNCTION_DIR_%DK.cmd"
	
	call dk_load dk_validate
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate NODEJS_EXE "call %DKIMPORTS_DIR%\nodejs\dk_installNodeJs"
	
	ftype dk_javascript=cmd /c call "%~f0" "%NODEJS_EXE%" "%DKJAVASCRIPT_FUNCTIONS_DIR%" "%%1" %*
	assoc .js=dk_javascript
	call dk_registrySetKey "HKEY_CLASSES_ROOT\dk_javascript\DefaultIcon" "" "REG_SZ" "%NODEJS%\node.exe"
goto:eof


:run_javascript_file
	set "NODEJS_EXE=%~1"
	echo NODEJS_EXE = %NODEJS_EXE%
	
	set "DKJAVASCRIPT_FUNCTIONS_DIR=%~2
	echo DKJAVASCRIPT_FUNCTIONS_DIR = %DKJAVASCRIPT_FUNCTIONS_DIR%
	
	set "JAVASCRIPT_FILE=%~3"
	for %%Z in ("%JAVASCRIPT_FILE%") do set "JAVASCRIPT_FILE=%%~nxZ"
	echo JAVASCRIPT_FILE = %JAVASCRIPT_FILE%
	
	echo ############### Digitalknob ##################	
echo start %NODEJS_EXE% %DKJAVASCRIPT_FUNCTIONS_DIR%\DKNodeServer.js
    start %NODEJS_EXE% %DKJAVASCRIPT_FUNCTIONS_DIR%\DKNodeServer.js
echo explorer "http://127.0.0.1:8080/%JAVASCRIPT_FILE%"
	explorer "http://127.0.0.1:8080/%JAVASCRIPT_FILE%"
goto:eof