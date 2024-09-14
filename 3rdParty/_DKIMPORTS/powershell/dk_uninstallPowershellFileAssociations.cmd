@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_uninstallPowershellFileAssociations()
::#
:dk_uninstallPowershellFileAssociations
	call dk_debugFunc 0
	
	call dk_uninstallFileAssoc .ps1
	call dk_uninstallFileAssoc .psm1
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_uninstallPowershellFileAssociations
%endfunction%
