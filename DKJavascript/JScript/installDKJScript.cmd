@echo off

if "%~1" neq "" goto runDKJScript
:installDKJScript
	::###### DKINIT ######
	if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
	if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
	
	::###### Install DKJScript ######
	%dk_call% dk_echo "Installing DKJScript . . ."
	set "CSCRIPT_EXE=cscript.exe"
	set "WSCRIPT_EXE=wscript.exe"
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKJScript"
	ftype DKJScript=cmd /c call "%~f0" "%CSCRIPT_EXE%" "%WSCRIPT_EXE%" "%DKJAVASCRIPT_FUNCTIONS_DIR%" "%%1" %*
	%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\DKJScript\DefaultIcon" "" "REG_SZ" "%CSCRIPT_EXE%"
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.js"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.js"
	assoc .js=DKJScript
	
	%dk_call% dk_success "DKJScript install complete"
%endfunction%


:runDKJScript
	set "CSCRIPT_EXE=%~1"
	set "WSCRIPT_EXE=%~2"
	set "DKJAVASCRIPT_FUNCTIONS_DIR=%~3
	set "DKSCRIPT_PATH=%~4"	
	
    cmd /c %CSCRIPT_EXE% //d //nologo //e:javascript "%DKSCRIPT_PATH%"
	::cmd /c %WSCRIPT_EXE% //d //nologo //e:javascript "%DKSCRIPT_PATH%"
	pause
%endfunction%
