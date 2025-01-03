@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_install()
::#
:dk_install
	%dk_call% dk_debugFunc 0
::setlocal	
	
	%dk_call% dk_validate DKIMPORTS_DIR    "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate NUGET_EXE        "%dk_call% %DKIMPORTS_DIR%\nuget\dk_install.cmd"
	%NUGET_EXE% install Microsoft.UI.Xaml
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	setlocal
	%dk_call% dk_debugFunc 0
 setlocal
 
	%dk_call% dk_install
%endfunction%
