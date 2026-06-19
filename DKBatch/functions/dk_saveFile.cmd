<# : chooser.bat
@rem shebang
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


rem ################################################################################
rem # dk_saveFile(rtn_var)
rem #
:dk_saveFile
%setlocal%
	
	%dk_call% dk_validate powershell.exe %dk_call% dk_depend powershell.exe
    for /f "delims=" %%g in ('%powershell.exe% -noprofile "iex (${%~f0} | out-string)"') do (
        set "dk_saveFile=%%~g"
    )
	
	:return
	endlocal & (
		set "dk_saveFile=%dk_saveFile%"
		if "%~1" neq "" (
			set "%~1=%dk_saveFile%"
		) else (
			rem echo %dk_saveFile%
		)
	)
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_saveFile myFile
	%dk_call% dk_debug "dk_saveFile = '%dk_saveFile%'"
    %dk_call% dk_debug "myFile = '%myFile%'"
%endfunction%






: end begin PowerShell hybrid #>
Add-Type -AssemblyName System.Windows.Forms
$f = new-object Windows.Forms.SaveFileDialog
$f.InitialDirectory = pwd
#$f.Filter = "Text Files (*.txt)|*.txt|All Files (*.*)|*.*"
$f.ShowHelp = $true
$f.Multiselect = $true
[void]$f.ShowDialog()
if ($f.Multiselect) { $f.FileNames } else { $f.FileName }
