@echo off
call ..\..\..\DKBatch\functions\DK.cmd

::####################################################################
::# dk_installPowershellFileAssociations()
::#
:dk_installPowershellFileAssociations
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate POWERSHELL_EXE "call %DKIMPORTS_DIR%\powershell\dk_installPowershell"
	call dk_installFileAssoc .ps1 %POWERSHELL_EXE%
	call dk_installFileAssoc .psm1 %POWERSHELL_EXE%
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_installPowershellFileAssociations
goto:eof
