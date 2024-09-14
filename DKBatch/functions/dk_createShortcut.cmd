@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

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
    
    if not defined OVERWRITE if exist "%shortcut_path%" %dk_call% dk_warning "%shortcut_path% already exists" && %return%    
	if exist "%shortcut_path%" %dk_call% dk_delete "%shortcut_path%"

	:: Method 1: direct powershell
	::%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_setPOWERSHELL_EXE"
	::%POWERSHELL_EXE% -Command "$shortcut_path = '%shortcut_path%'; $target_path = '%target_path%'; $WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut(${shortcut_path}); $Shortcut.TargetPath = ${target_path}; $Shortcut.Save();"
	
	:: Method 2: direct dk_powershell
	::%dk_call% dk_powershell "$shortcut_path = '%shortcut_path%'; $target_path = '%target_path%'; $WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut(${shortcut_path}); $Shortcut.TargetPath = ${target_path}; $Shortcut.Save();"
	
	:: Method 3: direct dk_powershell (multi-line)
	::	%dk_call% dk_powershell ^
	::	$shortcut_path = '%shortcut_path%'; ^
	::	$target_path = '%target_path%'; ^
	::	$WshShell = New-Object -comObject WScript.Shell; ^
	::	$Shortcut = $WshShell.CreateShortcut(${shortcut_path});
	::	$Shortcut.TargetPath = ${target_path}; ^
	::	$Shortcut.Save();

	:: Method 3: call powershell function
	%dk_call% dk_callPowershell dk_createShortcut %*
    
    if not exist %shortcut_path% %dk_call% dk_fatal "Failed to create shortcut:%shortcut_path%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_createShortcut "C:\Users\Administrator\Desktop\digitalknob.lnk" "C:\Users\Administrator\digitalknob"
%endfunction%
