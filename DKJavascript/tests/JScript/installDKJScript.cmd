@echo off

if "%~1" neq "" (goto runDKJavascript)
:installDKJavascript
	@echo off&rem ###### DK.cmd #########################################################################################################################
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	if not defined DKINIT_cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %* && exit /b %errorlevel%)
	rem #################################################################################################################################################

	
	::###### Install DKJavascript ######
	%dk_call% dk_echo "Installing DKJavascript . . ."
	set "cscript.exe=cscript.exe"
	set "wscript_exe=wscript.exe"
	%dk_call% dk_validate DKJAVASCRIPT_FUNCTIONS_DIR %dk_call% dk_DKBRANCH_DIR
	
	%dk_call% dk_registryDeleteKey "HKCR/DKJavascript"
	ftype DKJavascript=%ComSpec% /c call "%~f0" "%cscript.exe%" "%wscript_exe%" "%DKJAVASCRIPT_FUNCTIONS_DIR%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR/DKJavascript/DefaultIcon" "" "REG_SZ" "%cscript.exe%"
	
	%dk_call% dk_registryDeleteKey "HKCR/.js"
	%dk_call% dk_registryDeleteKey "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.js"
	assoc .js=DKJavascript
	
	%dk_call% dk_success "DKJavascript install complete"
%endfunction%


:runDKJavascript
	set "cscript.exe=%~1"
	set "wscript_exe=%~2"
	set "DKJAVASCRIPT_FUNCTIONS_DIR=%~3
	set "DKSCRIPT_PATH=%~4"
	set "cmd.exe=%ComSpec%"
	
    %cmd.exe% /c %cscript.exe% //d //nologo //e:javascript "%DKJAVASCRIPT_FUNCTIONS_DIR%/main_file_local.js" "%DKSCRIPT_PATH%"
	::%ComSpec% /c %wscript_exe% //d //nologo //e:javascript "%DKSCRIPT_PATH%"
	pause
%endfunction%
