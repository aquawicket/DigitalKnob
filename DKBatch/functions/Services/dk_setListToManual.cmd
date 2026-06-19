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


rem ############################################################################
rem # Services/dk_setListToManual(list_file)
rem #
rem #
:dk_setListToManual
%setlocal%
	
	set "list_file=%~1"
	
	rem loop through services_MyList.txt, set to manual(demand)
	rem https://superuser.com/a/607582/600216
	rem also via registry   HKLM\SYSTEM\CurrentControlSet\Services\
	rem All services can be set to manual by changing their start field to 3
	rem reg add HKLM\SYSTEM\CurrentControlSet\Services\AarSvc_31cf0 /t REG_DWORD /v Start /d 3 /f
	rem reg add HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service /t REG_DWORD /v Start /d 3 /f

	echo #### Windows Services ####
	for /f "tokens=*" %%a in ("%list_file%") do (
		echo %%a
		sc stop %%a
		sc config "%%a" start=demand
		reg add HKLM\SYSTEM\CurrentControlSet\Services\%%a /t REG_DWORD /v Start /d 3 /f
	)
%endfunction%


















rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% Services/dk_setListToManual "service_MyList.txt"
%endfunction%