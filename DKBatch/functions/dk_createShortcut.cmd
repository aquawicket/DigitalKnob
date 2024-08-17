@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_createShortcut(shortcut_path, target_path)
::#
::#
:dk_createShortcut
	call dk_debugFunc 2 3
	
	set "shortcut_path=%~1"
	set "target_path=%~2"
	if "%~3" equ "OVERWRITE" ( set "OVERWRITE=1" ) else ( set "OVERWRITE=0" )
	
	if exist "%shortcut_path%" if "%OVERWRITE%" neq "1" (
		%dk_call% dk_error "dk_createShortcut Cannot create shortcut. Destiantion exists and OVERWRITE is not set"
	) 
	if exist "%shortcut_path%" dk_warning "%shortcut_path% already exists" && goto:eof
	
	%dk_call% dk_powershell %NO_STD% && %dk_call% dk_powershell ^
        "$shortcut_path = '%shortcut_path%'; "^
        "$target_path = '%target_path%'; "^
		"$WshShell = New-Object -comObject WScript.Shell; "^
		"$Shortcut = $WshShell.CreateShortcut(${shortcut_path}); "^
		"$Shortcut.TargetPath = ${target_path}; "^
		"$Shortcut.Save();"
	
::	powershell /? %NO_STD% && powershell ^
::		"$shortcut_path = '%shortcut_path%'; "^
::      "$target_path = '%target_path%'; "^
::		"$WshShell = New-Object -comObject WScript.Shell; "^
::		"$Shortcut = $WshShell.CreateShortcut(${shortcut_path}); "^
::		"$Shortcut.TargetPath = ${target_path}; "^
::		"$Shortcut.Save();"
	
	if not exist %shortcut_path% dk_error "Failed to create shortcut:%shortcut_path%"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_createShortcut "C:\Users\Administrator\Desktop\digitalknob.lnk" "C:\Users\Administrator\digitalknob"
goto:eof
