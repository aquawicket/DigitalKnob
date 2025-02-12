@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\")
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_uninstallNotepadppContextMenu()
::#
:dk_uninstallNotepadppContextMenu
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_uninstallContextMenu "Edit with Notepad++"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	setlocal
	%dk_call% dk_debugFunc 0
	
    %dk_call% dk_uninstallNotepadppContextMenu
%endfunction%