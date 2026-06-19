rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ####################################################################
rem # DKUNINSTALL()
rem #
:DKUNINSTALL
%setlocal%
	
	rem ######### kill cmake.exe process #########
	%dk_call% dk_killProcess cmake.exe

	rem ######### kill cmake-gui.exe process #########
	%dk_call% dk_killProcess cmake-gui.exe
	
	%dk_call% dk_fileVariables			"%~dp0/dkconfig.txt"
	%dk_call% dk_validate Host_Tuple	%dk_call% dk_Host_Tuple
	set "cmake_Import=!CMake_%Host_Tuple%_Import!"
	%dk_call% dk_assertVar				cmake_Import
	
	%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
	%dk_call% dk_importVariables %cmake_Import% INSTALL_ROOT %DKTOOLS_DIR%
	%dk_call% dk_assertVar cmake
	
	if NOT EXIST "%cmake%" (
		%dk_call% dk_notice "cmake is NOT installed"
		%return%
	)
	
	%dk_call% dk_notice "UnInstalling CMake . . ."
	%dk_call% dk_delete "%cmake%"

	if NOT EXIST "%cmake%" (%dk_call% dk_success "cmake uninstall complete") else (%dk_call% dk_error "cmake uninstall failed")
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% DKUNINSTALL
%endfunction%