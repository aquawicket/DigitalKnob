<# : chooser.bat
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_selectFile(rtn_var)
::#
:dk_selectFile
 setlocal
	call dk_debugFunc 1
	
	%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_powershell"
	for /f "delims=" %%I in ('powershell -noprofile "iex (${%~f0} | out-string)"') do (
	rem for /f "delims=" %%I in ('%POWERSHELL_EXE% -noprofile "iex (${%~f0} | out-string)"') do (
		endlocal & set %1=%%~I
	)
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_selectFile myFile
	%dk_call% dk_echo "myFile = %myFile%"
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