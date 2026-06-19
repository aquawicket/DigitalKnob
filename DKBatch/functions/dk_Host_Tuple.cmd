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
rem # dk_Host_Tuple()
rem #
rem #
:dk_Host_Tuple
%setlocal%
 		
	rem ###### SET ######
	if "%~1" neq "" (
		set "Host_Tuple=%~1"
	
	rem ###### GET ######	
	) else (
		if NOT defined Host_Os		(%dk_call% dk_Host_Os)
		if NOT defined Host_Arch	(%dk_call% dk_Host_Arch)
		set "Host_Tuple=!Host_Os!_!Host_Arch!"
	)
	
	rem ###### FINALIZE ######
	endlocal & (
		set "Host_Os=%Host_Os%"
		set "Host_Arch=%Host_Arch%"
		set "Host_Tuple=%Host_Tuple%"
		set "%Host_Tuple%_Host=1"
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    rem ###### GET ######
    %dk_call% dk_Host_Tuple
	%dk_call% dk_echo "Host_Tuple = %Host_Tuple%"
	%dk_call% dk_echo "%Host_Tuple%_Host =  !%Host_Tuple%_Host!"
	
	rem ###### SET ######
	%dk_call% dk_Host_Tuple "Linux_I686"
	%dk_call% dk_echo "Host_Tuple = %Host_Tuple%"
	%dk_call% dk_echo "%Host_Tuple%_Host =  !%Host_Tuple%_Host!"
%endfunction%