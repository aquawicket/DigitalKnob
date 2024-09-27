@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_uninstallGitFileAssociations()
::#
:dk_uninstallGitFileAssociations
	call dk_debugFunc 0
	
	%dk_call% dk_uninstallFileAssoc .sh
	%dk_call% dk_uninstallFileAssoc .bash
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
    call dk_uninstallGitFileAssociations
%endfunction%
