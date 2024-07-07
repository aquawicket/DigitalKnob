@echo off

:installDKHtml
	if not "%*" == "" (goto:runDKHtml)
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
	
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.html"
	ftype dkhtml=cmd /c call "%~f0" "%NODEJS_EXE%" "%DKJAVASCRIPT_FUNCTIONS_DIR%" "%%1" %*
	assoc .html=dkhtml
	call dk_registrySetKey "HKEY_CLASSES_ROOT\dkhtml\DefaultIcon" "" "REG_SZ" "%NODEJS%\node.exe"
goto:eof


:runDKHtml
	set "NODEJS_EXE=%~1"
	echo NODEJS_EXE = %NODEJS_EXE%
	
	set "DKJAVASCRIPT_FUNCTIONS_DIR=%~2
	echo DKJAVASCRIPT_FUNCTIONS_DIR = %DKJAVASCRIPT_FUNCTIONS_DIR%
	
	set "HTML_FILE=%~3"
	for %%Z in ("%HTML_FILE%") do set "HTML_FILE=%%~nxZ"
	echo HTML_FILE = %HTML_FILE%
	
	echo ############### Digitalknob ##################	
    start %NODEJS_EXE% %DKJAVASCRIPT_FUNCTIONS_DIR%\DKNodeServer.js
	explorer "http://127.0.0.1:8080/%HTML_FILE%"
goto:eof