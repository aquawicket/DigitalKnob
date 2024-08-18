@echo off

if "%~1" neq "" (goto:runDKJScript)
:installDKJScript
	::###### DKINIT ######
	if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"
	
	::###### Install DKJScript ######
	call dk_echo "Installing DKJScript . . ."
	set "CSCRIPT_EXE=cscript.exe"
	set "WSCRIPT_EXE=wscript.exe"
	
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKJScript"
	ftype DKJScript=cmd /c call "%~f0" "%CSCRIPT_EXE%" "%WSCRIPT_EXE%" "%DKJAVASCRIPT_FUNCTIONS_DIR%" "%%1" %*
	call dk_registrySetKey "HKEY_CLASSES_ROOT\DKJScript\DefaultIcon" "" "REG_SZ" "%CSCRIPT_EXE%"
	
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\.js"
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.js"
	assoc .js=DKJScript
	
	call dk_echo "DKJScript install complete"
	call dk_pause
goto:eof


:runDKJScript
	set "CSCRIPT_EXE=%~1"
	set "WSCRIPT_EXE=%~2"
	set "DKJAVASCRIPT_FUNCTIONS_DIR=%~3
	set "DKJAVASCRIPT_FILE=%~4"
	::for %%Z in ("%DKJAVASCRIPT_FILE%") do set "DKJAVASCRIPT_FILE=%%~nxZ"
	
	
    cmd /c %CSCRIPT_EXE% //nologo //e:javascript "%DKJAVASCRIPT_FILE%"
	pause
goto:eof
