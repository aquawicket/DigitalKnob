@echo off
call ..\..\..\DKBatch\functions\DK.cmd

::####################################################################
::# dk_uninstallPowershellFileAssociations()
::#
:dk_uninstallPowershellFileAssociations
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	call dk_uninstallFileAssoc .ps1
	call dk_uninstallFileAssoc .psm1
goto:eof





::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_uninstallPowershellFileAssociations
goto:eof
