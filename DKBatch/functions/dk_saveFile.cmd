<# : chooser.bat
<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::################################################################################
::# dk_saveFile(rtn_var)
::#
:dk_saveFile
<<<<<<< HEAD
    call dk_debugFunc 1
 setlocal
 
    %dk_call% dk_validate POWERSHELL_EXE "call dk_POWERSHELL_EXE"
=======
setlocal
	%dk_call% dk_debugFunc 1
    %dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_POWERSHELL_EXE"
>>>>>>> Development
    for /f "delims=" %%I in ('%POWERSHELL_EXE% -noprofile "iex (${%~f0} | out-string)"') do (
        endlocal & set %1=%%~I
    )
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
=======
setlocal
	%dk_call% dk_debugFunc 0

>>>>>>> Development
    %dk_call% dk_saveFile myFile
    %dk_call% dk_echo "myFile = %myFile%"
%endfunction%






<<<<<<< HEAD
: end begin PowerShell hybrid chimera #>
=======
: end begin PowerShell hybrid #>
>>>>>>> Development
Add-Type -AssemblyName System.Windows.Forms
$f = new-object Windows.Forms.SaveFileDialog
$f.InitialDirectory = pwd
#$f.Filter = "Text Files (*.txt)|*.txt|All Files (*.*)|*.*"
$f.ShowHelp = $true
$f.Multiselect = $true
[void]$f.ShowDialog()
<<<<<<< HEAD
if ($f.Multiselect) { $f.FileNames } else { $f.FileName }
=======
if ($f.Multiselect) { $f.FileNames } else { $f.FileName }
>>>>>>> Development
