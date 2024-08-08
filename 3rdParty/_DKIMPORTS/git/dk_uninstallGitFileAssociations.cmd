@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_uninstallGitFileAssociations()
::#
:dk_uninstallGitFileAssociations
	call dk_debugFunc 0
	
	call dk_uninstallFileAssoc .sh
	call dk_uninstallFileAssoc .bash
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
    call dk_uninstallGitFileAssociations
goto:eof
