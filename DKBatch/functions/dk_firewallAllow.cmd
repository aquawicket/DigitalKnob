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
	
	%dk_call% dk_assertPath "%~2"
	
	%dk_call% dk_registryContains "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" "%~2" && (
		%dk_call% dk_warning "registry already contains a firewall rule for %~2"
		exit /b 0
	)
	
	netsh advfirewall firewall add rule name="%~1" dir=in action=allow program="%~2" enable=yes profile=any
	netsh advfirewall firewall add rule name="%~1" dir=out action=allow program="%~2" enable=yes profile=any
	
	rem Windows Firewall Control
	set "WFCUI_EXE=C:\Program Files\Malwarebytes\Windows Firewall Control\wfcUI.exe"
	call "%WFCUI_EXE%" -allow %2
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_firewallAllow "CMD" "%COMSPEC%"
%endfunction%
