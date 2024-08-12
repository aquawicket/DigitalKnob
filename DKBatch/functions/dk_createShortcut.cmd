@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_createShortcut(shortcut_path, target_path)
::#
::#
:dk_createShortcut
	call dk_debugFunc 2
	
	::powershell /? 1>nul || call dk_error "dk_createShortcut requires powershell"
	
	set "shortcut_path=%~1"
	set "target_path=%~2"
	
	if exist %shortcut_path% dk_warning "%shortcut_path% already exists" && goto:eof
	
	call dk_powershellEval ^
        "$shortcut_path = '%shortcut_path%'; "^
        "$target_path = '%target_path%'; "^
		"$WshShell = New-Object -comObject WScript.Shell; "^
		"$Shortcut = $WshShell.CreateShortcut(${shortcut_path}); "^
		"$Shortcut.TargetPath = ${target_path}; "^
		"$Shortcut.Save();"
	
	if not exist %shortcut_path% dk_error "Failed to create shortcut:%shortcut_path%"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_createShortcut "C:\Users\Administrator\Desktop\digitalknob.lnk" "C:\Users\Administrator\digitalknob"
goto:eof
