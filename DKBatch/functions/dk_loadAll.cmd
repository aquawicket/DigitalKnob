@echo off
::if defined dk_loadAll (goto:eof) else (set dk_loadAll=1)
call DK


::####################################################################
::# dk_loadAll()
::#
::#
:dk_loadAll() {
	:: download _functionList_ and load each function in the list
	if not exist "%DKBATCH_FUNCTIONS_DIR%\_functionList_" powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/_functionList_', '%DKBATCH_FUNCTIONS_DIR%\_functionList_')"

	for /F "usebackq delims=" %%a in ("%DKBATCH_FUNCTIONS_DIR%\_functionList_") do (
		call dk_load %%a
    )
goto:eof




:DKTEST ########################################################################

	call dk_loadAll