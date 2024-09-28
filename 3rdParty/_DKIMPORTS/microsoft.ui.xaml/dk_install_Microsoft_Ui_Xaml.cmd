@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_install_Microsoft_Ui_Xaml()
::#
:dk_install_Microsoft_Ui_Xaml
	call dk_debugFunc 0
:: setlocal	
	
	%dk_call% dk_validate DKIMPORTS_DIR    "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_validate NUGET_EXE        "call %DKIMPORTS_DIR%\nuget\dk_installNuget.cmd"
	
	%NUGET_EXE% install Microsoft.UI.Xaml
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
 setlocal
 
	call dk_install_Microsoft_Ui_Xaml
%endfunction%
