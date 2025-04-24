<# : chooser.bat
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_saveFile(rtn_var)
::#
:dk_saveFile
setlocal
	%dk_call% dk_debugFunc 1
    %dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_POWERSHELL_EXE"
    for /f "delims=" %%I in ('%POWERSHELL_EXE% -noprofile "iex (${%~f0} | out-string)"') do (
        endlocal & set %1=%%~I
    )
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_saveFile myFile
    %dk_call% dk_echo "myFile = %myFile%"
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
