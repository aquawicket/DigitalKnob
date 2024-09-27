@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_uninstallNotepadppContextMenu()
::#
:dk_uninstallNotepadppContextMenu
	call dk_debugFunc 0
	
	%dk_call% dk_uninstallContextMenu "Edit with Notepad++"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
    call dk_uninstallNotepadppContextMenu
%endfunction%