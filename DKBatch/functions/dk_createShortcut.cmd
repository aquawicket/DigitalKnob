@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ####################################################################
rem # dk_createShortcut(src_path, shortcut_path)
rem #
rem #
:dk_createShortcut
%setlocal%

	set "src_path=%~1"
	set "src_path=%src_path:\=/%"
    set "shortcut_path=%~2"
	set "shortcut_path=%shortcut_path:.url=%.lnk"     &rem Add .lnk extension if missing
	set "shortcut_path=%shortcut_path:.lnk=%.lnk"     &rem Add .lnk extension if missing
	set "shortcut_path=%shortcut_path:\=/%"
    set "OVERWRITE=%~3"
	
    if NOT defined OVERWRITE (
		if EXIST "%shortcut_path%" (%dk_call% dk_notice "%shortcut_path% already exists" && %return%)
	)
	if EXIST "%shortcut_path%" (%dk_call% dk_delete "%shortcut_path%")

	%dk_call% dk_debug "shortcut_path = %shortcut_path%"
	%dk_call% dk_debug "src_path = %src_path%"

	rem Method 1: direct powershell
	rem %dk_call% dk_validate powershell.exe %dk_call% dk_depend powershell.exe
	rem %dk_call% powershell.exe -Command "$shortcut_path = '%shortcut_path%'; $src_path = '%src_path%'; $WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut(${shortcut_path}); $Shortcut.TargetPath = ${src_path}; $Shortcut.Save();"
	
	rem Method 2: direct dk_evalPowershell
	rem %dk_call% dk_evalPowershell "$shortcut_path = '%shortcut_path%'; $src_path = '%src_path%'; $WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut(${shortcut_path}); $Shortcut.TargetPath = ${src_path}; $Shortcut.Save();"
	
	rem Method 3: direct dk_evalPowershell (multi-line)
	rem	%dk_call% dk_evalPowershell ^
	rem	$shortcut_path = '%shortcut_path%'; ^
	rem	$src_path = '%src_path%'; ^
	rem	$WshShell = New-Object -comObject WScript.Shell; ^
	rem	$Shortcut = $WshShell.CreateShortcut(${shortcut_path});
	rem	$Shortcut.TargetPath = ${src_path}; ^
	rem	$Shortcut.Save();

	rem Method 3: call dk_powershell function
	rem %dk_call% dk_callDKPowershell dk_createShortcut %*
	
	rem Method 4: mshta javascript	
	%dk_call% dk_validate mshta.exe	%dk_call% dk_findFile mshta.exe "%SystemRoot%"
	if NOT EXIST "%mshta.exe%" (
		%dk_call% dk_notice "mshta.exe:'%mshta.exe%' NOT FOUND"	
		cmd /c exit /b 1
		%endfunction%
	) 
	

	"%mshta.exe:/=\%" ^"javascript:^
		var WshShell = new ActiveXObject('WScript.Shell');^
		var shortcut = WshShell.CreateShortcut('%shortcut_path%');^
		shortcut.TargetPath = '%src_path:/=\\%';^
		shortcut.Save();^
		close();^
	^"
	
	set dk_createShortcut=%errorlevel%
	
	if NOT EXIST %shortcut_path% (%dk_call% dk_error "Failed to create shortcut:%shortcut_path%")

%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_createShortcut "%USERPROFILE:\=/%/Digital Knob" "%USERPROFILE:\=/%/Desktop/DigitalKnob2.lnk"
%endfunction%
