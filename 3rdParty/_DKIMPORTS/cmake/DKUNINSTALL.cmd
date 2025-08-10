@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKUNINSTALL()
::#
:DKUNINSTALL
%setlocal%
	%dk_call% dk_debugFunc 0
	
	::######### kill cmake.exe process #########
	%dk_call% dk_killProcess cmake.exe

	::######### kill cmake-gui.exe process #########
	%dk_call% dk_killProcess cmake-gui.exe
	
	%dk_call% dk_getFileParams			"%~dp0/dkconfig.txt"
	%dk_call% dk_validate Host_Tuple	"%dk_call% dk_Host_Tuple"
	set "cmake_Import=!CMake_%Host_Tuple%_Import!"
	%dk_call% dk_assertVar				cmake_Import
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables %cmake_Import% INSTALL_ROOT %DKTOOLS_DIR%
	%dk_call% dk_assertVar CMAKE
	
	if not exist "%CMAKE%" (
		%dk_call% dk_notice "cmake is not installed"
		%return%
	)
	
	%dk_call% dk_notice "UnInstalling CMake . . ."
	%dk_call% dk_delete "%CMAKE%"

	if not exist "%CMAKE%" (%dk_call% dk_success "cmake uninstall complete") else (%dk_call% dk_error "cmake uninstall failed")
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKUNINSTALL
	
	%dk_call% dk_pause
%endfunction%