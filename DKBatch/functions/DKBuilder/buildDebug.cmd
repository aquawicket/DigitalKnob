@rem shebang
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
rem # buildDebug()
rem #
:buildDebug
%setlocal%

	if defined MSYSTEM (
		(set cmnd=%msys2%/usr/bin/env MSYSTEM=%MSYSTEM% /usr/bin/bash -lc "'%cmake.exe%' --build %CMAKE_Target_Path%/%Target_Tuple%/%Target_Type% --config %Target_Type% --verbose")
	)

	%dk_call% dk_assertVar Target_App_Dir
	if EXIST "%Target_App_Dir%/%Target_Tuple%/%Target_Type%/CMakeCache.txt" (
		(set cmnd="%cmake.exe%" --build %Target_App_Dir%/%Target_Tuple%/%Target_Type% --config %Target_Type% --verbose)
	)
	if EXIST "%Target_App_Dir%/%Target_Tuple%/CMakeCache.txt" (
		(set cmnd="%cmake.exe%" --build %Target_App_Dir%/%Target_Tuple% --config %Target_Type% --verbose)
	)

	if "%cmnd%" equ "" (%return%)

	%cmnd% && (
		%dk_call% dk_success "CMake Build Successful"
	) || (
		%dk_call% dk_error "CMake Build Failed"
	)
%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% buildDebug
%endfunction%
