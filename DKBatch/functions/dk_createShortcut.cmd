@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_createShortcut(shortcut_path, target_path)
::#
::#
:dk_createShortcut
	call dk_debugFunc 2 3
	
	setlocal
	set "shortcut_path=%~1"
	set "target_path=%~2"
	set "OVERWRITE=%~3"
	
	if exist "%shortcut_path%" %dk_call% dk_warning "%shortcut_path% already exists" && goto:eof
	
::	if exist "%shortcut_path%" (
::		if defined OVERWRITE (
::			%dk_call% dk_delete "%shortcut_path%"
::		) else (
::			%dk_call% dk_error "dk_createShortcut Cannot create shortcut. Destiantion exists and no OVERWRITE specified"
::		)
::	)
	
	%dk_call% dk_powershell ^
        "$shortcut_path = '%shortcut_path%'; "^
        "$target_path = '%target_path%'; "^
		"$WshShell = New-Object -comObject WScript.Shell; "^
		"$Shortcut = $WshShell.CreateShortcut(${shortcut_path}); "^
		"$Shortcut.TargetPath = ${target_path}; "^
		"$Shortcut.Save();"
	
	if not exist %shortcut_path% %dk_call% dk_error "Failed to create shortcut:%shortcut_path%"
	endlocal
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_createShortcut "C:\Users\Administrator\Desktop\digitalknob.lnk" "C:\Users\Administrator\digitalknob"
goto:eof
