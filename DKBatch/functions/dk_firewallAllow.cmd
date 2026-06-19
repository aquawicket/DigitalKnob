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


rem ###############################################################################
rem # dk_firewallAllow(executable)
rem # dk_firewallAllow(name executable)
rem #
rem #	  @name:optinal	- The name of the firewall rule
rem #   @executable	- The path to the executable to allow
rem #
:dk_firewallAllow
rem if NOT defined dk_firewallAllow_DEBUG 		(set "dk_firewallAllow_DEBUG=1")
if NOT defined dk_firewallAllow_WARNINGS 	(set "dk_firewallAllow_WARNINGS=1")
%setlocal%

	if "%~2" neq "" (  
		set "_name_=%~1"
		set "_file_=%~2"
	) else (
		set "_file_=%~1"
		rem set "_file_=!_file_:#40=(!"
		rem set "_file_=!_file_:#41=)!"
		%dk_call% dk_basename !_file_! _name_
		%dk_call% dk_removeExtension !_name_! _name_
	)
	%dk_call% dk_assertVar _file_
	%dk_call% dk_assertVar _name_
	
	if "%dk_firewallAllow_DEBUG%" equ "1" (
		%dk_call% dk_echo "%bg_blue% %white% dk_firewallAllow %_name_% %_file_% %clr%"
	)

	%dk_call% dk_registryContains "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" "%_file_:/=\%" && (
		if "%dk_firewallAllow_WARNINGS%" equ "1" (
			%dk_call% dk_notice "registry already contains a firewall rule for '%_file_:/=\%'"
		)
		%return%
	)

	%dk_call% dk_notice "Adding firewall allow rule for %_name_% %_file_:/=\% . . ."
	
	%dk_call% dk_validate netsh.exe %dk_call% dk_findFile netsh.exe
	if EXIST "%netsh.exe%" (
		%dk_call% netsh.exe advfirewall firewall add rule name="%_name_%" dir=in action=allow program="%_file_:/=\%" enable=yes profile=any >nul
		%dk_call% netsh.exe advfirewall firewall add rule name="%_name_%" dir=out action=allow program="%_file_:/=\%" enable=yes profile=any >nul
	)

	rem ###### Windows Firewall Control ######
	if NOT EXIST "%wfc_exe%" 	(set "wfc_exe=%ProgramFiles:\=/%/Malwarebytes/Windows Firewall Control/wfc.exe")
	if NOT EXIST "%wfcUI_exe%" 	(set "wfcUI_exe=%ProgramFiles:\=/%/Malwarebytes/Windows Firewall Control/wfcUI.exe")
	if EXIST "%wfc_exe%"		(set "WFC_APP=%wfc_exe%")
	if EXIST "%wfcUI_exe%"		(set "WFC_APP=%wfcUI_exe%")

	"%WFC_APP:/=\%" -allow "%_file_:/=\%" || (echo errorlevel = !errorlevel! & %clearerror%)
	rem ######################################

%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% dk_validate sftp_exe %dk_call% dk_depend OpenSSH
	echo ssh_exe = %ssh_exe%
	%dk_call% dk_firewallAllow "%ssh_exe%"
%endfunction%
