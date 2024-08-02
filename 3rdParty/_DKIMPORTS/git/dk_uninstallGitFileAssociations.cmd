@echo off
call "..\..\..\DKBatch\functions\DK.cmd"

::####################################################################
::# dk_uninstallGitFileAssociations()
::#
:dk_uninstallGitFileAssociations
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	call dk_uninstallFileAssoc .sh
	call dk_uninstallFileAssoc .bash
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
    call dk_uninstallGitFileAssociations
goto:eof
