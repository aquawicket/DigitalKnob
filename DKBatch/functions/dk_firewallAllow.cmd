@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################

::if NOT defined dk_firewallAllow_DEBUG 	(set "dk_firewallAllow_DEBUG=1")
if NOT defined dk_firewallAllow_WARNINGS 	(set "dk_firewallAllow_WARNINGS=1")
::###############################################################################
::# dk_firewallAllow(name executable)
::#
::#	  @name		 	- The name of the firewall rule
::#   @executable	- The path to the executable to allow
::#
:dk_firewallAllow
%setlocal%
	%dk_call% dk_debugFunc 1 2

	if "%~2" neq "" (  
		set "_name_=%~1"
		set "_file_=%~2"
	) else (
		set "_file_=%~1"
		set "_file_=!_file_:#40=(!"
		set "_file_=!_file_:#41=)!"
		%dk_call% dk_basename !_file_! _file_
		%dk_call% dk_removeExtension !_file_! _name_
	)
	
	if "%dk_firewallAllow_DEBUG%" equ "1" (
		%dk_call% dk_echo "%bg_blue% %white% dk_firewallAllow %_name_% %_file_% %clr%"
	)

	%dk_call% dk_registryContains "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" "%_file_:/=\%" && (
		if "%dk_firewallAllow_WARNINGS%" equ "1" (
			%dk_call% dk_notice "registry already contains a firewall rule for '%_file_%'"
		)
		%return%
	)

	%dk_call% dk_notice "Adding firewall allow rule for %_file_% . . ."
	
	%dk_call% dk_findProgram NETSH_EXE netsh.exe "%windir%/System32" NO_ERROR
	if EXIST "%NETSH_EXE%" (
		%NETSH_EXE% advfirewall firewall add rule name="%_name_%" dir=in action=allow program="%_file_:/=\%" enable=yes profile=any >nul
		%NETSH_EXE% advfirewall firewall add rule name="%_name_%" dir=out action=allow program="%_file_:/=\%" enable=yes profile=any >nul
	)
	
	::###### Windows Firewall Control ######
	if NOT EXIST "%WFC_EXE%" 	(set "WFC_EXE=%ProgramFiles:\=/%/Malwarebytes/Windows Firewall Control/wfc.exe")
	if NOT EXIST "%WFCUI_EXE%" 	(set "WFCUI_EXE=%ProgramFiles:\=/%/Malwarebytes/Windows Firewall Control/wfcUI.exe")
	if EXIST "%WFC_EXE%"		(set "WFC_APP=%WFC_EXE%")
	if EXIST "%WFCUI_EXE%"		(set "WFC_APP=%WFCUI_EXE%")
	"%WFC_APP:/=\%" -allow "%_file_:/=\%"
	::######################################
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_firewallAllow "C:\Users\Administrator\DigitalKnob\DKTools\git-portable-2.46.2-64-bit\mingw64\libexec\git-core\git-remote-https.exe"
%endfunction%
