@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_uninstallGitContextMenu()
::#
::#
:dk_uninstallGitContextMenu
    call dk_debugFunc 0
	
	call dk_uninstallContextMenu "GIT ADD"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
    call dk_uninstallGitContextMenu
%endfunction%
