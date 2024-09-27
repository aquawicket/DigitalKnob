@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installPowershellFileAssociations()
::#
:dk_installPowershellFileAssociations
	call dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	::%dk_call% dk_validate POWERSHELL_EXE "call %DKIMPORTS_DIR%\powershell\dk_installPowershell"
	%dk_call% dk_validate POWERSHELL_EXE "call dk_POWERSHELL_EXE"
	%dk_call% dk_installFileAssoc .ps1 %POWERSHELL_EXE%
	%dk_call% dk_installFileAssoc .psm1 %POWERSHELL_EXE%
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_installPowershellFileAssociations
%endfunction%
