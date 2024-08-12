<# : chooser.bat
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_selectFile(rtn_var)
::#
:dk_selectFile
	call dk_debugFunc 1
	
	setlocal
	for /f "delims=" %%I in ('powershell -noprofile "iex (${%~f0} | out-string)"') do (
		endlocal & set %1=%%~I
	)
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_selectFile myFile
	call dk_echo "myFile = %myFile%"
goto:eof






: end begin PowerShell hybrid chimera #>
Add-Type -AssemblyName System.Windows.Forms
$f = new-object Windows.Forms.OpenFileDialog
$f.InitialDirectory = pwd
#$f.Filter = "Text Files (*.txt)|*.txt|All Files (*.*)|*.*"
$f.ShowHelp = $true
$f.Multiselect = $true
[void]$f.ShowDialog()
if ($f.Multiselect) { $f.FileNames } else { $f.FileName }