@echo off

if "%~1" neq "" (goto runDKJScript)
:installDKJScript
	::###### DK_CMD ######
	if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../../DKBatch/functions/")
	if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)
	
	::###### Install DKJScript ######
	%dk_call% dk_echo "Installing DKJScript . . ."
	set "CSCRIPT_EXE=cscript.exe"
	set "WSCRIPT_EXE=wscript.exe"
	%dk_call% dk_validate DKJAVASCRIPT_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
	
	%dk_call% dk_registryDeleteKey "HKCR\DKJScript"
	ftype DKJScript=%COMSPEC% /c call "%~f0" "%CSCRIPT_EXE%" "%WSCRIPT_EXE%" "%DKJAVASCRIPT_FUNCTIONS_DIR%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR\DKJScript\DefaultIcon" "" "REG_SZ" "%CSCRIPT_EXE%"
	
	%dk_call% dk_registryDeleteKey "HKCR\.js"
	%dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.js"
	assoc .js=DKJScript
	
	%dk_call% dk_success "DKJScript install complete"
%endfunction%


:runDKJScript
	set "CSCRIPT_EXE=%~1"
	set "WSCRIPT_EXE=%~2"
	set "DKJAVASCRIPT_FUNCTIONS_DIR=%~3
	set "DKSCRIPT_PATH=%~4"
	set "CMD_EXE=%COMSPEC%"
	
    %CMD_EXE% /c %CSCRIPT_EXE% //d //nologo //e:javascript "%DKJAVASCRIPT_FUNCTIONS_DIR%/main_file_local.js" "%DKSCRIPT_PATH%"
	::%COMSPEC% /c %WSCRIPT_EXE% //d //nologo //e:javascript "%DKSCRIPT_PATH%"
	pause
%endfunction%
