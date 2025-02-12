@echo off
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::#################################################################################
:: dk_registryKeyExists(reg_path) 
::
:dk_registryKeyExists
setlocal
    %dk_call% dk_debugFunc 1 2

    "%SystemRoot%\System32\reg.exe" query "%~1" >nul 2>&1
    
    if %ERRORLEVEL% equ 0 (
        if "%~2" neq "" (endlocal & set "%2=true")
        exit /b 0
    )
    
    if "%~2" neq "" (endlocal & set "%2=false")
    exit /b 1
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_registryKeyExists "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt" 	&& %dk_call% dk_info "key exists" || %dk_call% dk_info "key does NOT exist"
    %dk_call% dk_registryKeyExists "HKCU\SOFTWARE\NonExistentKey" 											&& %dk_call% dk_info "key exists" || %dk_call% dk_info "key does NOT exist"
	%dk_call% dk_registryKeyExists "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\QEMU" 			&& %dk_call% dk_info "qemu is installed" || %dk_call% dk_info "qemu is NOT installed"
%endfunction%
