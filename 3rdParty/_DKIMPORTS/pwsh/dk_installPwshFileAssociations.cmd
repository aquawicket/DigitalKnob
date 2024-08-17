@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_installPwshFileAssociations()
::#
:dk_installPwshFileAssociations
	call dk_debugFunc 0
	
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate PWSH_EXE "call %DKIMPORTS_DIR%\pwsh\dk_installPwsh"
	call dk_installFileAssoc .ps1 %PWSH_EXE%
	call dk_installFileAssoc .psm1 %PWSH_EXE%
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_installPwshFileAssociations
goto:eof
