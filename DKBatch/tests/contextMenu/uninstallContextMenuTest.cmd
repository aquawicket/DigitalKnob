@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_uninstallGitContextMenu()
::#
::#
:dk_uninstallGitContextMenu
    %dk_call% dk_debugFunc 0
	
	%dk_call% dk_uninstallContextMenu "GIT ADD"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	%dk_call% dk_debugFunc 0
	
    call dk_uninstallGitContextMenu
%endfunction%
