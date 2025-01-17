@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::###############################################################################
::# dk_firewallAllow(name executable)
::#
::#	  @name		 	- The name of the firewall rule
::#   @executable	- The path to the executable to allow
::#
:dk_firewallAllow
setlocal
	%dk_call% dk_debugFunc 2
	set "_file_=%~2"
	set "_file_=%_file_:/=\%
	%dk_call% dk_assertPath "%_file_%"
	
	%dk_call% dk_registryContains "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" "%_file_%" && (
		%dk_call% dk_warning "registry already contains a firewall rule for %_file_%"
		exit /b 0
	)
	
	netsh advfirewall firewall add rule name="%~1" dir=in action=allow program="%_file_%" enable=yes profile=any
	netsh advfirewall firewall add rule name="%~1" dir=out action=allow program="%_file_%" enable=yes profile=any
	
	rem Windows Firewall Control
	set "WFCUI_EXE=C:\Program Files\Malwarebytes\Windows Firewall Control\wfcUI.exe"
	if exist "%WFCUI_EXE%" 	call "%WFCUI_EXE%" -allow %2
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_firewallAllow "CMD" "C:/Windows/System32/cmd.exe"
%endfunction%
