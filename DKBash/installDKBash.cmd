@echo off

if "%~1" neq "" (goto:runDKBash)
:installDKBash	
	::###### DKINIT ######
	if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
	if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
	
	::###### Install DKBash ######
	%dk_call% dk_echo "Installing DKBash . . ."
	%dk_call% dk_validate DKBASH_FUNCTIONS_DIR "%dk_call% dk_validateBranch"
	%dk_call% dk_validate GITBASH_EXE "%dk_call% dk_installGit"
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKBash"
	ftype DKBash=cmd /c call "%~f0" "%DKBASH_FUNCTIONS_DIR%" "%GITBASH_EXE%" "%%1" %*
	%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\DKBash\DefaultIcon" "" "REG_SZ" "%GITBASH_EXE%"
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.sh"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.sh
	assoc .sh=DKBash
	
	%dk_call% dk_success "DKBash install complete"
%endfunction%


:runDKBash
	set "DKBASH_FUNCTIONS_DIR=%~1"
	set "GITBASH_EXE=%~2"
	set "DKSCRIPT_PATH=%~3"
	
	::###### run script ######
	%GITBASH_EXE% %DKSCRIPT_PATH% && (echo returned TRUE) || (echo returned FALSE)
	
	::###### exit_code ######
	if %ERRORLEVEL% neq 0 echo ERROR:%ERRORLEVEL% && pause
	&:: FIXME:  bash only returns 0
	
	::###### reload ######
	if not exist %~dp0\reload goto:eof
	del %~dp0\reload
	cls
	goto:runDKBash
%endfunction%
