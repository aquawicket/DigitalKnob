@echo off

if "%~1" neq "" (goto runDKVb)
:installDKVb
	::###### DKINIT ######
	if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
	if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
	
	::###### Install DKVb ######
	%dk_call% dk_echo "Installing DKVb . . ."
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.vbs
	set "DKVB_FUNCTIONS_DIR=..\DKVb\functions"
	::set "WSCRIPT_EXE=%SystemRoot%\System32\WScript.exe"
	set "CSCRIPT_EXE=%SystemRoot%\System32\CScript.exe"
	
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKVb"
	ftype DKVb=%COMSPEC% /c call "%~f0" "%DKVB_FUNCTIONS_DIR%" "%CSCRIPT_EXE%" "%%1" %*
	%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\DKVb\DefaultIcon" "" "REG_SZ" "%CSCRIPT_EXE%"
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.vbs"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.vbs"
	assoc .vbs=DKVb
	
	%dk_call% dk_success "DKVb install complete"
%endfunction%


:runDKVb
	set "DKVB_FUNCTIONS_DIR=%~1"
	set "CSCRIPT_EXE=%~2"
	set "DKSCRIPT_PATH=%~3"
	set "CMD_EXE=%COMSPEC%"
	%CMD_EXE% /V:ON /K %CSCRIPT_EXE% //E:vbscript //H:CScript %DKSCRIPT_PATH%
%endfunction%