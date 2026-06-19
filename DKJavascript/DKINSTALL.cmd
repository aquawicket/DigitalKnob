rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
    setlocal enableDelayedExpansion
    if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
    if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
    if NOT EXIST "!DK.cmd!" (
        start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
    call "!DK.cmd:/=\!" "%%~0" %%*
    exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ############ DKJavascript ############
rem #
:DKINSTALL
%setlocal%
	if "%~1" neq ":DKINSTALL" (
        echo :DKINSTALL %*
		%dk_call% dk_fatal "DKJavascript/DKINSTALL.cmd does NOT take arguments"
		exit /b -1
	)

    ::###### Install DKJavascript ######
	echo Installing DKJavascript . . .
	
	rem ###### Install DKJavascript ######
	%dk_call% dk_validate cscript.exe				    %dk_call% dk_findFile cscript.exe
	rem %dk_call% dk_validate wscript.exe					%dk_call% dk_findFile wscript.exe
	%dk_call% dk_validate cygpath_exe					%dk_call% dk_depend cygpath_exe
	%dk_call% dk_validate DKJAVASCRIPT_FUNCTIONS_DIR	%dk_call% dk_DKBRANCH_DIR
	set "DK.js=%DKJAVASCRIPT_FUNCTIONS_DIR%/DK.js"
	set "ENGINE={16d51579-a30b-4c8b-a276-0ff4dc41e755}"
	
	rem "%SystemRoot%\System32\cscript.exe" //D //E:{16d51579-a30b-4c8b-a276-0ff4dc41e755} //X //NoLogo "X:/Users/Default/Digital Knob/Development/DKJavascript/functions/DK.js" "X:/Users/Default/Digital Knob/Development/DKJavascript/functions/dk_test.js"
	ftype DKJavascript="%ComSpec:/=\%" /V:ON /k FOR /F "usebackq delims=" %%%%a IN (`"%cygpath_exe:/=\%" -m '%%1'`^) DO "%cscript.exe:/=\%" //D //E:%ENGINE% //X //NoLogo "%DK.js:\=/%" "%%%%a" ^&^& echo RETURN:true:^^!errorlevel^^! ^|^| echo RETURN:false:^^!errorlevel^^!
	%dk_call% dk_registrySetKey "HKCR/DKJavascript/DefaultIcon" "" "REG_SZ" "%cscript.exe:/=\%"
	
	assoc .js=DKJavascript
	
	%dk_call% dk_success "DKJavascript install complete"
%endfunction%
