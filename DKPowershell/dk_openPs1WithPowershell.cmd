@echo off
call "../DKBatch/functions/DK.cmd"

::####################################################################
::# dk_openPs1WithPowershell.cmd()
::#
::#    reference: https://stackoverflow.com/a/20623597
::#
dk_openPs1WithPowershell.cmd() {
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	:::::: .ps1 dbl click to open scripts in powershell
	::HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\Shell\open\command "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -noLogo -ExecutionPolicy unrestricted -file "%1"
	call dk_registrySetKey "HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\Shell\open\command" "" "" "\"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe\" -noLogo -ExecutionPolicy unrestricted -file \"%%%%1\""

		

goto:eof



:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

call dk_openPs1WithPowershell.cmd
