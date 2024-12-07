@echo off

if "%~1" neq "" (goto runDKHta)
:installDKHta
	::###### DKINIT ######
	if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
	if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
	
	::###### Install DKBash ######
	%dk_call% dk_echo "Installing DKHta . . ."
	set "MSHTA_EXE=%WINDIR%\SysWOW64\mshta.exe"
	set "DKHTA_FUNCTIONS_DIR=..\DKHta\functions"
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKHta"
	::ftype DKHta=%WINDIR%\SysWOW64\mshta.exe "%1" {1E460BD7-F1C3-4B2E-88BF-4E770A288AF5}%U{1E460BD7-F1C3-4B2E-88BF-4E770A288AF5} %*
	
	%dkcall% dk_validate CMD_EXE "%dk_call% dk_CMD_EXE"
	ftype DKHta=%CMD_EXE% /c call "%~f0" "%DKHTA_FUNCTIONS_DIR%" "%MSHTA_EXE%" "%%1" %*
	%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\DKHta\DefaultIcon" "" "REG_SZ" "%MSHTA_EXE%"
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.hta"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.hta
	assoc .hta=DKHta
	
	%dk_call% dk_success "DKHta install complete"
%endfunction%


:runDKHta
	set "DKHTA_FUNCTIONS_DIR=%~1"
	set "MSHTA_EXE=%~2"
	set "DKSCRIPT_PATH=%~3"
	start %MSHTA_EXE% %DKSCRIPT_PATH%
%endfunction%
