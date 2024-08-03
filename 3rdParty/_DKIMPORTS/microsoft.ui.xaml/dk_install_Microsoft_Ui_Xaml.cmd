@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_install_Microsoft_Ui_Xaml()
::#
:dk_install_Microsoft_Ui_Xaml
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate NUGET_EXE "call %DKIMPORTS_DIR%\nuget\dk_installNuget.cmd"
	
	%NUGET_EXE% install Microsoft.UI.Xaml
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_install_Microsoft_Ui_Xaml
goto:eof
