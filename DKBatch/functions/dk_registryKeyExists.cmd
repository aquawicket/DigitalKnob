@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::#################################################################################
:: dk_registryKeyExists() <reg_path>
::
:dk_registryKeyExists
 setlocal
	call dk_debugFunc 1 2

	"%SystemRoot%\System32\reg.exe" query "%~1" >nul 2>&1
	
	if %ERRORLEVEL% equ 0 (
		if defined "%~2" (endlocal & set "%2=true")
        (call ) %NO_STD%
		goto:eof
	)
	
    if defined "%~2" (endlocal & set "%2=false")
	(call) %NO_STD%
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_registryKeyExists "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt" && %dk_call% dk_info "key exists" || %dk_call% dk_info "key does NOT exist"
	%dk_call% dk_registryKeyExists "HKEY_CURRENT_USER\SOFTWARE\NonExistentKey" && %dk_call% dk_info "key exists" || %dk_call% dk_info "key does NOT exist"
goto:eof
