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


rem #####################################################################
rem # dk_Host_Arch()
rem #
rem #	  Host_Arch = ARM32, ARM64, X86, X86_64
rem #
:dk_Host_Arch
%setlocal%

	rem ###### SET ######
	if "%~1" neq "" (
		set "Host_Arch=%~1"
	
	rem ###### GET ######	
	) else (
		if /i "%PROCESSOR_ARCHITECTURE%" equ "x86"   (set "Host_Arch=X86")
		if /i "%PROCESSOR_ARCHITECTURE%" equ "AMD64" (set "Host_Arch=X86_64")
		if /i "%PROCESSOR_ARCHITECTURE%" equ "IA64"  (set "Host_Arch=X86_64")
		if /i "%PROCESSOR_ARCHITECTURE%" equ "EM64T" (set "Host_Arch=X86_64")
		if /i "%PROCESSOR_ARCHITECTURE%" equ "ARM64" (set "Host_Arch=Arm64")
	)
	
	endlocal & (
		set "Host_Arch=%Host_Arch%"
		set "%Host_Arch%_Host=1"
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem ###### GET ######
    %dk_call% dk_Host_Arch
	%dk_call% dk_echo "Host_Arch = %Host_Arch%"
	%dk_call% dk_echo "%Host_Arch%_Host = !%Host_Arch%_Host!"
	
	rem ###### SET ######
	%dk_call% dk_Host_Arch "I686"
	%dk_call% dk_echo "Host_Arch = %Host_Arch%"
	%dk_call% dk_echo "%Host_Arch%_Host = !%Host_Arch%_Host!"
	
%endfunction%