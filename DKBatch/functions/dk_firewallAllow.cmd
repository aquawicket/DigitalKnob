echo dk_firewall %*
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::###############################################################################
::# dk_firewallAllow(name executable)
::#
::#	  @name		 	- The name of the firewall rule
::#   @executable	- The path to the executable to allow
::#
:dk_firewallAllow
	call dk_debugFunc 2

	%dk_call% dk_registryContains "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" "%~2" && (
		%dk_call% dk_warning "registry already contains a firewall rule for %~2"
		%return%
	)
	
	netsh advfirewall firewall add rule name="%~1" dir=in action=allow program="%~2" enable=yes profile=any
	netsh advfirewall firewall add rule name="%~1" dir=out action=allow program="%~2" enable=yes profile=any
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_firewallAllow "CMD" "C:\Windows\System32\cmd.exe"
%endfunction%