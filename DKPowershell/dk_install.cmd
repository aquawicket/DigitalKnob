@echo off

if "%*" neq "" goto runDKPowershell
:dk_install
	::###### DKINIT ######
	if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
	if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
	
	::###### Install DKPowershell ######
	%dk_call% dk_echo "Installing DKPowershell . . ."
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	::%dk_call% dk_validate POWERSHELL_EXE "%dk_call% %DKIMPORTS_DIR%\powershell\dk_install.cmd"
	%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_POWERSHELL_EXE"
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKPowershell"
	
	ftype DKPowershell="%COMSPEC%" /c call "%~f0" "%DKPOWERSHELL_FUNCTIONS_DIR%" "%POWERSHELL_EXE%" "%%1" %*
	%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\DKPowershell\DefaultIcon" "" "REG_SZ" "%POWERSHELL_EXE%"
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.ps1"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ps1
	assoc .ps1=DKPowershell
	
	%dk_call% dk_success "DKPowershell install complete"
%endfunction%


:runDKPowershell
	set "DKPOWERSHELL_FUNCTIONS_DIR=%~1"
	set "POWERSHELL_EXE=%~2"
	set "DKSCRIPT_PATH=%~3"
	
	
	::###### run script ######
	%COMSPEC% /v:on /K call %POWERSHELL_EXE% -Command %DKSCRIPT_PATH%; exit $LASTEXITCODE && (echo returned TRUE) || (echo returned FALSE)
	
	::###### exit_code ######
	if %ERRORLEVEL% neq 0 echo ERROR:%ERRORLEVEL% && pause
	
	::###### reload ######
::	if not exist %~dp0\reload goto:eof
::	del %~dp0\reload
::	cls
::	goto runDKPowershell
%endfunction%
