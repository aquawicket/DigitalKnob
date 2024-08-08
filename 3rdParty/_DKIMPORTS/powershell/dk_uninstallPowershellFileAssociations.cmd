@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_uninstallPowershellFileAssociations()
::#
:dk_uninstallPowershellFileAssociations
	call dk_debugFunc 0
	
	call dk_uninstallFileAssoc .ps1
	call dk_uninstallFileAssoc .psm1
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_uninstallPowershellFileAssociations
goto:eof
