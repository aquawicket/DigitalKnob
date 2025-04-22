@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


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

	"%REG_EXE%" query "%_reg_path_:/=\%" >nul 2>&1

	if %ERRORLEVEL% equ 0 (
		set "dk_registryKeyExists=0"
	) else (
		set "dk_registryKeyExists=-1"
	)

	endlocal & (
		set "dk_registryKeyExists=%dk_registryKeyExists%"
		if not "%~2" equ "" (set "%~2=%dk_registryKeyExists%")
		exit /b %dk_registryKeyExists%
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
