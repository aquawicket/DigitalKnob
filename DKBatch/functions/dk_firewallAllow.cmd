@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::###############################################################################
::# dk_firewallAllow(name executable)
::#
::#	  @name		 	- The name of the firewall rule
::#   @executable	- The path to the executable to allow
::#
:dk_firewallAllow
%setlocal%
	%dk_call% dk_debugFunc 2

	set "_name_=%~1"
	set _file_=%~2
	set _file_=%_file_:#40=(%
	set _file_=%_file_:#41=)%
	::echo %bg_blue% %white% dk_firewallAllow %_name_% %_file_% %clr%

	%dk_call% dk_registryContains "HKLM/SYSTEM/ControlSet001/Services/SharedAccess/Parameters/FirewallPolicy/FirewallRules" "%_file_:/=\%" && (
		%dk_call% dk_notice "registry already contains a firewall rule for '%_file_%'"
		exit /b 0
	) || (echo not found)

	%dk_call% dk_notice "Adding firewall allow rule for %_file_% . . ."
	
	%dk_call% dk_findProgram NETSH_EXE netsh.exe "%windir:\=/%/System32"
	%NETSH_EXE% advfirewall firewall add rule name="%_name_%" dir=in action=allow program="%_file_:/=\%" enable=yes profile=any >nul
	%NETSH_EXE% advfirewall firewall add rule name="%_name_%" dir=out action=allow program="%_file_:/=\%" enable=yes profile=any >nul
	
	::###### Windows Firewall Control ######
	if not exist "%WFC_EXE%" 	(set "WFC_EXE=%ProgramFiles:\=/%/Malwarebytes/Windows Firewall Control/wfc.exe")
	if not exist "%WFCUI_EXE%" 	(set "WFCUI_EXE=%ProgramFiles:\=/%/Malwarebytes/Windows Firewall Control/wfcUI.exe")
	if exist "%WFC_EXE%"		(set "WFC_APP=%WFC_EXE%")
	if exist "%WFCUI_EXE%"		(set "WFC_APP=%WFCUI_EXE%")
	"%WFC_APP:/=\%" -allow "%_file_:/=\%"
	::######################################
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_firewallAllow "Notepad" "C:/Windows/notepad.exe"
%endfunction%
