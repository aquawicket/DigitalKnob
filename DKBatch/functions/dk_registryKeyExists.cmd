@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::#################################################################################
:: dk_registryKeyExists() <reg_path>
::
:dk_registryKeyExists
	call dk_debugFunc
	if %__ARGC__% lss 1 call dk_error "%__FUNCTION__%(): not enough arguments"

	"%SystemRoot%\System32\reg.exe" query "%~1" >nul 2>&1
	
	if %ERRORLEVEL% equ 0 (
		if defined "%~2" (endlocal & call dk_set %2 true)
        (call )
		goto:eof
	)
	
    if defined "%~2" (endlocal & call dk_set %2 false)
	(call)
goto:eof





::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_registryKeyExists "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt" && call dk_info "key exists" || call dk_info "key does NOT exist"
	call dk_registryKeyExists "HKEY_CURRENT_USER\SOFTWARE\NonExistentKey" && call dk_info "key exists" || call dk_info "key does NOT exist"
goto:eof