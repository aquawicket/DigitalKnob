@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_selectFolder(rtn_var)
::#
:dk_selectFolder
	call dk_debugFunc
	if %__ARGC__% neq 1 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	call dk_assertPath "%systemroot%\system32\mshta.exe"
	for /f "usebackq delims=" %%i in (
		`@"%systemroot%\system32\mshta.exe" "javascript:var objShellApp = new ActiveXObject('Shell.Application');var Folder = objShellApp.BrowseForFolder(0, 'Select Folder:',1, '::{20D04FE0-3AEA-1069-A2D8-08002B30309D}');try {new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).Write(Folder.Self.Path)};catch (e){};close();" ^
		1^|more`
	) do set "sFolderName=%%i"
	if not defined sFolderName (
		call dk_echo "no folder selected"
		goto:eof
	)
	
	call dk_set %1 %sFolderName%
goto:eof






::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_selectFolder myFolder
	call dk_echo "myFolder = %myFolder%"
goto:eof
