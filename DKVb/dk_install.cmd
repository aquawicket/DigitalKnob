@echo off
if "%*" == "" (goto dk_install)

:runDKVb
	set "DKVB_FUNCTIONS_DIR=%~1"
	set "CSCRIPT_EXE=%~2"
	set "DKSCRIPT_PATH=%~3"
	set "CMD_EXE=%COMSPEC%"
	%CMD_EXE% /V:ON /K %CSCRIPT_EXE% //E:vbscript //H:CScript %DKSCRIPT_PATH%
%endfunction%






























:dk_install
	::###### DKINIT ######
	if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
	if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
	
	::###### Install DKVb ######
	%dk_call% dk_echo "Installing DKVb . . ."
	%dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.vbs
	set "DKVB_FUNCTIONS_DIR=..\DKVb\functions"
	::set "WSCRIPT_EXE=%SystemRoot%\System32\WScript.exe"
	set "CSCRIPT_EXE=%SystemRoot%\System32\CScript.exe"
	
	
	%dk_call% dk_registryDeleteKey "HKCR\DKVb"
	ftype DKVb=%COMSPEC% /c call "%~f0" "%DKVB_FUNCTIONS_DIR%" "%CSCRIPT_EXE%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR\DKVb\DefaultIcon" "" "REG_SZ" "%CSCRIPT_EXE%"
	
	%dk_call% dk_registryDeleteKey "HKCR\.vbs"
	%dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.vbs"
	assoc .vbs=DKVb
	
	%dk_call% dk_success "DKVb install complete"
%endfunction%