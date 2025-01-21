@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#####################################################################
::# dk_restartExplorer()
::#
::#
:dk_restartExplorer
setlocal
	%dk_call% dk_debugFunc 0

	::taskkill /im explorer.exe /f
	%dk_call% dk_killProcess explorer.exe
	start explorer.exe

%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_restartExplorer
%endfunction%
