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


rem #################################################################################
rem # dk_registryContains(reg_path, find)
rem #
rem #
:dk_registryContains
%setlocal%

	set "_reg_path_=%~1"
	set "_find_=%~2"
	set "_find_=%_find_:"=%"

	%dk_call% dk_validate reg.exe %dk_call% dk_findFile reg.exe
	
	set "dk_registryContains=1"
	for /f "usebackq delims=" %%a in (`%reg.exe:/=\% query "%_reg_path_:/=\%"`) do (
		set "line=%%a"
		if "x!line:%_find_:/=\%=!x" neq "x!line:/=\!x" (
			set "dk_registryContains=0"
		)
	)
	
	:return
	endlocal & (
		set "dk_registryContains=%dk_registryContains%"
		if "%~2" neq "" (
			set "%~2=%dk_registryContains%"
		) else (
			echo %dk_registryContains%
		)
	)
    exit /b %dk_registryContains%
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	set "key=HKLM/SYSTEM/ControlSet001/Services/SharedAccess/Parameters/FirewallPolicy/FirewallRules"
	set "exe=%USERPROFILE:\=/%/Digital Knob/DKTools/OpenSSH-win64/ssh.exe"
  
    %dk_call% dk_registryContains "%key%" "%exe%" && (
		%dk_call% dk_echo "Regestry: .../FirewallRules contains %exe%"
	) || (
		%dk_call% dk_echo "Regestry: .../FirewallRules does NOT contain %exe%"
	)
%endfunction%
