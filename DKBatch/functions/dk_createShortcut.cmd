@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_createShortcut(src_path, shortcut_path)
::#
::#
:dk_createShortcut
%setlocal%
	%dk_call% dk_debugFunc 2 3

	set "src_path=%~1"
    set "shortcut_path=%~2"
	set "shortcut_path=%shortcut_path:.lnk=%.lnk"     &:: Add .lnk extension if missing
    set "OVERWRITE=%~3"
	
    if NOT defined OVERWRITE (
		if EXIST "%shortcut_path%" (%dk_call% dk_notice "%shortcut_path% already exists" && %return%)
	)
	if EXIST "%shortcut_path%" (%dk_call% dk_delete "%shortcut_path%")

	:: Method 1: direct powershell
	::%dk_call% dk_validate powershell_exe "%dk_call% dk_depend powershell"
	::%powershell_exe% -Command "$shortcut_path = '%shortcut_path%'; $src_path = '%src_path%'; $WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut(${shortcut_path}); $Shortcut.TargetPath = ${src_path}; $Shortcut.Save();"
	
	:: Method 2: direct dk_evalPowershell
	::%dk_call% dk_evalPowershell "$shortcut_path = '%shortcut_path%'; $src_path = '%src_path%'; $WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut(${shortcut_path}); $Shortcut.TargetPath = ${src_path}; $Shortcut.Save();"
	
	:: Method 3: direct dk_evalPowershell (multi-line)
	::	%dk_call% dk_evalPowershell ^
	::	$shortcut_path = '%shortcut_path%'; ^
	::	$src_path = '%src_path%'; ^
	::	$WshShell = New-Object -comObject WScript.Shell; ^
	::	$Shortcut = $WshShell.CreateShortcut(${shortcut_path});
	::	$Shortcut.TargetPath = ${src_path}; ^
	::	$Shortcut.Save();

	:: Method 3: call powershell function

	%dk_call% dk_callDKPowershell dk_createShortcut %*

	if NOT EXIST %shortcut_path% (%dk_call% dk_fatal "Failed to create shortcut:%shortcut_path%")
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    %dk_call% dk_createShortcut "%USERPROFILE:\=/%/DigitalKnob" "%USERPROFILE:\=/%/Desktop/DigitalKnob.lnk"
%endfunction%
