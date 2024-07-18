@echo off
call ..\..\..\DKBatch\functions\DK.cmd

::####################################################################
::# dk_uninstallNotepadppContextMenu()
::#
:dk_uninstallNotepadppContextMenu
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	call dk_uninstallContextMenu "Edit with Notepad++"
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
    call dk_uninstallNotepadppContextMenu
goto:eof