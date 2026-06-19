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


rem ##########################################
:DKINSTALL

%setlocal%
	if "%~1" neq ":DKINSTALL" (
        echo :DKINSTALL %*
		%dk_call% dk_fatal "DKVbs/DKINSTALL.cmd does NOT take arguments"
		exit /b -1
	)

    ::###### Install DKVbs ######
	echo Installing DKVbs . . .
	
	rem ###### Install DKVbs ######
	%dk_call% dk_validate cscript.exe           %dk_call% dk_findFile cscript.exe
	rem %dk_call% dk_validate wscript.exe		%dk_call% dk_findFile wscript.exe
	%dk_call% dk_validate cygpath_exe			%dk_call% dk_depend cygpath_exe
	%dk_call% dk_validate DKVbs_FUNCTIONS_DIR	%dk_call% dk_DKBRANCH_DIR
	set "DK.js=%DKVbs_FUNCTIONS_DIR%/DK.js"
	set "ENGINE=VBScript"
	
	ftype DKVbs=
	ftype DKVbs="%ComSpec:/=\%" /V:ON /k FOR /F "usebackq delims=" %%%%a IN (`"%cygpath_exe:/=\%" -m '%%1'`^) DO "%cscript.exe:/=\%" //D //E:%ENGINE% //X //NoLogo "%%%%a" ^&^& echo RETURN:true:^^!errorlevel^^! ^|^| echo RETURN:false:^^!errorlevel^^!
	%dk_call% dk_registrySetKey "HKCR/DKVbs/DefaultIcon" "" "REG_SZ" "%cscript.exe:/=\%"
	
	assoc .vbs=
	assoc .vbs=DKVbs
	
	%dk_call% dk_success "DKVbs install complete"
%endfunction%
