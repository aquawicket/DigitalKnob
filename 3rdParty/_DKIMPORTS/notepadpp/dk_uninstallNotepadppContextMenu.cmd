@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0

::####################################################################
::# dk_uninstallNotepadppContextMenu()
::#
:dk_uninstallNotepadppContextMenu
	call dk_debugFunc 0
	
	call dk_uninstallContextMenu "Edit with Notepad++"
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
    call dk_uninstallNotepadppContextMenu
goto:eof