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
rem %setlocal%
	
	echo.
	echo ### Uninstalling wsl ###
	rem %dk_call% dk_findFile wsl.exe
	rem %wsl.exe% --uninstall
	
	rem ### Uninstall Windows-Subsystem-Linux-Update
	%dk_call% dk_validate reg.exe %dk_call% dk_findFile reg.exe
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	%dk_call% dk_validate find.exe %dk_call% dk_findFile find.exe
	%reg.exe% query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | %findstr.exe:/=\% /I /C:"{36EF257E-21D5-44F7-8451-07923A8C465E}" 1>nul && (
		%dk_call% msiexec.exe /X{36EF257E-21D5-44F7-8451-07923A8C465E}
	)
	
	rem ### Uninstall VirtualMachinePlatform
	%dk_call% dism.exe /online /Get-FeatureInfo /featurename:VirtualMachinePlatform | %find.exe:/=\% "Enabled" && (
		echo.
		echo disabling VirtualMachinePlatform . . .
		%dk_call% dism.exe /online /disable-feature /featurename:VirtualMachinePlatform /norestart
	)
	
	rem ### Uninstall Microsoft-Hyper-V
	%dk_call% dism.exe /online /Get-FeatureInfo /featurename:Microsoft-Hyper-V | %find.exe:/=\% "Enabled" && (
		echo.
		echo disabling Microsoft-Hyper-V . . .
		%dk_call% dism.exe /online /disable-feature /featurename:Microsoft-Hyper-V /norestart
	)
	
	rem ### Uninstall Microsoft-Windows-Subsystem-Linux
	%dk_call% dism.exe /online /Get-FeatureInfo /featurename:Microsoft-Windows-Subsystem-Linux | %find.exe:/=\% "Enabled" && (
		echo.
		echo disabling Microsoft-Windows-Subsystem-Linux . . .
		%dk_call% dism.exe /online /disable-feature /featurename:Microsoft-Windows-Subsystem-Linux /norestart
	)
	
	rem ### FIXME - is this needed?
	echo ### Uninstalling Windows Subsystem for Linux ###
	%dk_call% msiexec.exe /uninstall {AAAA4669-FCEF-4B2A-8355-1E0FA411A269} /quiet
	
	rem ### restart
	shutdown /r /t 3
%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% DKUNINSTALL
%endfunction%

