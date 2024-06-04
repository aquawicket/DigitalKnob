@echo off
call "../../../DKBatch/functions/DK.cmd"

call :dk_install_Microsoft_Ui_Xaml
goto:eof

::####################################################################
::# dk_install_Microsoft_Ui_Xaml()
::#
:dk_install_Microsoft_Ui_Xaml () {
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_validate DKTOOLS_DIR dk_getDKPaths
	call dk_validate NUGET_EXE "../nuget/dk_installNuget.cmd"
	
	%NUGET_EXE% install Microsoft.UI.Xaml
goto:eof


