@echo off
::if defined dk_loadAll (goto:eof) else (set dk_loadAll=1)
call DK.cmd


::####################################################################
::# dk_loadAll()
::#
::#
:dk_loadAll() {
	:: if we are working from a local repository, all function files should be there. No need to loadAll
	if exist "%DKBATCH_FUNCTIONS_DIR_%..\..\.git" goto:eof
	
	:: download _functionList_ and load each function in the list
	if not exist "%DKBATCH_FUNCTIONS_DIR_%_functionList_" powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/_functionList_', '%DKBATCH_FUNCTIONS_DIR_%_functionList_')"

	for /F "usebackq delims=" %%a in ("%DKBATCH_FUNCTIONS_DIR_%_functionList_") do (
		call dk_load %%a
    )
goto:eof




:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	call dk_loadAll