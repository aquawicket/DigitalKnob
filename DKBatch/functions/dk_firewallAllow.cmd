@echo off
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::###############################################################################
::# dk_firewallAllow(name executable)
::#
::#	  @name		 	- The name of the firewall rule
::#   @executable	- The path to the executable to allow
::#
:dk_firewallAllow
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 2
	set "_file_=%~2"
	set "_file_=%_file_:/=\%"
	%dk_call% dk_assertPath "%_file_%"
	
	%dk_call% dk_registryContains "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" "%_file_%" && (
		%dk_call% dk_notice "registry already contains a firewall rule for %_file_%" & exit /b 0
	)
	
	%dk_call% dk_notice "Adding firewall allow rule for %_file_% . . ."
	
	%dk_call% dk_findProgram NETSH_EXE netsh.exe "C:/Windows/System32"
	%NETSH_EXE% advfirewall firewall add rule name="%~1" dir=in action=allow program="%_file_%" enable=yes profile=any >nul
	%NETSH_EXE% advfirewall firewall add rule name="%~1" dir=out action=allow program="%_file_%" enable=yes profile=any >nul
	
	::###### Windows Firewall Control ######
	if not exist "%WFC_EXE%" 	(set "WFC_EXE=C:\Program Files\Malwarebytes\Windows Firewall Control\wfc.exe")
	if not exist "%WFCUI_EXE%" 	(set "WFCUI_EXE=C:\Program Files\Malwarebytes\Windows Firewall Control\wfcUI.exe")
	if exist "%WFC_EXE%"		(set "WFC_APP=%WFC_EXE%")
	if exist "%WFCUI_EXE%"		(set "WFC_APP=%WFCUI_EXE%")
::	if exist "%WFC_APP%"		(set cmnd="%WFC_APP%" -allow "%_file_%")
::	if not exist "%CMD_EXE%" (set "CMD_EXE=%COMSPEC%")
::	if not exist "%CMD_EXE%" (%dk_call% dk_error "CMD_EXE is invalid")
::	::echo cmnd ^> "%CMD_EXE%" /c "%cmnd%"
::	"%CMD_EXE%" /c "%cmnd%"
	"%WFC_APP%" -allow "%_file_%"
	::######################################
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_firewallAllow "Notepad" "C:/Windows/notepad.exe"
%endfunction%
