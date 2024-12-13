@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_uninstallPowershellFileAssociations()
::#
:dk_uninstallPowershellFileAssociations
	call dk_debugFunc 0
	
	%dk_call% dk_uninstallFileAssoc .ps1
	%dk_call% dk_uninstallFileAssoc .psm1
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_uninstallPowershellFileAssociations
%endfunction%
