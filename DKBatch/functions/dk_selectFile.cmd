<# : dk_selectFile.cmd
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
rem # dk_selectFile()
rem #
:dk_selectFile
%setlocal%
	
	rem ### Try powershell
	%dk_call% dk_validate powershell.exe %dk_call% dk_findFile powershell.exe
	if exist "%powershell.exe%" (
		for /f "delims=" %%G in ('%powershell.exe:/=\% -noprofile "iex (${%~f0} | out-string)"') do (
			set "dk_selectFile=%%~G"
			goto:return
		)
	)
	
	rem ### Try mshta.exe
	%dk_call% dk_validate mshta.exe %dk_call% dk_findFile mshta.exe
	if NOT EXIST "%mshta.exe%" (goto:return)
	set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);close();resizeTo(0,0);</script>"
	for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do (
		set "dk_selectFile=%%p"
		goto:return
	)
	
	:return
	endlocal & (
		set "dk_selectFile=%dk_selectFile:\=/%"
	)
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_selectFile
    %dk_call% dk_debug "dk_selectFile = '%dk_selectFile%'"
	
    %dk_call% dk_selectFile & set "myFile=!dk_selectFile!"
    %dk_call% dk_debug "myFile = '%myFile%'"
%endfunction%






: end begin PowerShell hybrid chimera #>
Add-Type -AssemblyName System.Windows.Forms
$f = new-object Windows.Forms.OpenFileDialog
$f.InitialDirectory = pwd
#$f.Filter = "Text Files (*.txt)|*.txt|All Files (*.*)|*.*"
$f.ShowHelp = $true
$f.Multiselect = $true
[void]$f.ShowDialog()
if ($f.Multiselect) { $f.FileNames } else { $f.FileName }