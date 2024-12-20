<# : chooser.bat
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_saveFile(rtn_var)
::#
:dk_saveFile
    call dk_debugFunc 1
 setlocal
 
    %dk_call% dk_validate POWERSHELL_EXE "call dk_POWERSHELL_EXE"
    for /f "delims=" %%I in ('%POWERSHELL_EXE% -noprofile "iex (${%~f0} | out-string)"') do (
        endlocal & set %1=%%~I
    )
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_saveFile myFile
    %dk_call% dk_echo "myFile = %myFile%"
%endfunction%






: end begin PowerShell hybrid chimera #>
Add-Type -AssemblyName System.Windows.Forms
$f = new-object Windows.Forms.SaveFileDialog
$f.InitialDirectory = pwd
#$f.Filter = "Text Files (*.txt)|*.txt|All Files (*.*)|*.*"
$f.ShowHelp = $true
$f.Multiselect = $true
[void]$f.ShowDialog()
if ($f.Multiselect) { $f.FileNames } else { $f.FileName }