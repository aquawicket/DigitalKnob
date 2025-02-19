@echo off
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::#################################################################################
:: dk_registryKeyExists(reg_path)
:: dk_registryKeyExists(reg_path, rtn_var)
::
:dk_registryKeyExists
setlocal
    %dk_call% dk_debugFunc 1 2

	set "_reg_path_=%~1"

	set "REG_EXE=%SYSTEMROOT:\=/%/System32/reg.exe"
	%dk_call% dk_assertPath REG_EXE
	
    "%REG_EXE:/=\%" query "%_reg_path_:/=\%" >nul 2>&1
    
    if %ERRORLEVEL% equ 0 (
		endlocal & (
			set "dk_registryKeyExists=true"
			if not "%~2"=="" (set "%~2=true")
			exit /b 0
		)
    )
    
	endlocal & (
		set "dk_registryKeyExists=false"
		if not "%~2"=="" (set "%~2=false")
		exit /b 1
	) 
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_registryKeyExists "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.txt" 	&& %dk_call% dk_info "key exists" || %dk_call% dk_info "key does NOT exist"
    %dk_call% dk_registryKeyExists "HKCU/SOFTWARE/NonExistentKey" 											&& %dk_call% dk_info "key exists" || %dk_call% dk_info "key does NOT exist"
	%dk_call% dk_registryKeyExists "HKLM/Software/Microsoft/Windows/CurrentVersion/Uninstall/QEMU" 			&& %dk_call% dk_info "qemu is installed" || %dk_call% dk_info "qemu is NOT installed"
%endfunction%
