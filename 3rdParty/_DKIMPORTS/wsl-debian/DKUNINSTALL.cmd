@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKUNINSTALL()
::#
:DKUNINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	::%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	::%dk_call% dk_validate wsl_exe "%dk_call% dk_depend wsl_exe"
	
	%dk_call% dk_echo  
    %dk_call% dk_info "UnInstalling WSL-Debian Linux . . ."

	wsl --terminate Debian
	wsl --unregister Debian
	taskkill /f /im wslservice.exe
	
	%dk_call% dk_validate powershell_exe "%dk_call% dk_depend powershell_exe"
	%powershell_exe% -Command "Remove-AppxPackage -Package TheDebianProject.DebianGNULinux_1.12.2.0_x64__76v4gfsz19hv4"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKUNINSTALL
%endfunction%
