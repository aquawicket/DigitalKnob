@echo off
call ..\..\..\DKBatch\functions\DK.cmd

::####################################################################
::# dk_installNotepadppContextMenu()
::#
:dk_installNotepadppContextMenu
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate NOTEPADPP_EXE "call %DKIMPORTS_DIR%\notepadpp\dk_installNotepadpp"
	call dk_installContextMenu "Edit with Notepad++" "%NOTEPADPP_EXE%" "\"%NOTEPADPP_EXE%\" \"%%%%%%%%1\""
goto:eof



::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
    call dk_installNotepadppContextMenu
goto:eof
