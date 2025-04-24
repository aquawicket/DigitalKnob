@echo off

if not "%~1"=="" (goto runDKJavascript)
:installDKJavascript
	::#################################################### DigitalKnob DKBatch ########################################################################
	if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
	::#################################################################################################################################################

	
	::###### Install DKJavascript ######
	%dk_call% dk_echo "Installing DKJavascript . . ."
	set "CSCRIPT_EXE=cscript.exe"
	set "WSCRIPT_EXE=wscript.exe"
	%dk_call% dk_validate DKJAVASCRIPT_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
	
	%dk_call% dk_registryDeleteKey "HKCR/DKJavascript"
	ftype DKJavascript=%ComSpec% /c call "%~f0" "%CSCRIPT_EXE%" "%WSCRIPT_EXE%" "%DKJAVASCRIPT_FUNCTIONS_DIR%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR/DKJavascript/DefaultIcon" "" "REG_SZ" "%CSCRIPT_EXE%"
	
	%dk_call% dk_registryDeleteKey "HKCR/.js"
	%dk_call% dk_registryDeleteKey "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.js"
	assoc .js=DKJavascript
	
	%dk_call% dk_success "DKJavascript install complete"
%endfunction%


:runDKJavascript
	set "CSCRIPT_EXE=%~1"
	set "WSCRIPT_EXE=%~2"
	set "DKJAVASCRIPT_FUNCTIONS_DIR=%~3
	set "DKSCRIPT_PATH=%~4"
	set "CMD_EXE=%ComSpec%"
	
    %CMD_EXE% /c %CSCRIPT_EXE% //d //nologo //e:javascript "%DKJAVASCRIPT_FUNCTIONS_DIR%/main_file_local.js" "%DKSCRIPT_PATH%"
	::%ComSpec% /c %WSCRIPT_EXE% //d //nologo //e:javascript "%DKSCRIPT_PATH%"
	pause
%endfunction%
