<# : chooser.bat
<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_selectFile(rtn_var)
::#
:dk_selectFile
    call dk_debugFunc 1
 setlocal
  
	%dk_call% dk_validate POWERSHELL_EXE "call dk_POWERSHELL_EXE"
    for /f "delims=" %%I in ('%POWERSHELL_EXE% -noprofile "iex (${%~f0} | out-string)"') do (
        endlocal & set %1=%%~I
    )
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_selectFile(<rtn_var>:optional)
::#
:dk_selectFile
setlocal
	%dk_call% dk_debugFunc 1
	
	%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_POWERSHELL_EXE"
    for /f "delims=" %%I in ('%POWERSHELL_EXE% -noprofile "iex (${%~f0} | out-string)"') do (
		set "dk_selectFile=%%~I"
    )
	endlocal & (
		set "dk_selectFile=%dk_selectFile:\=/%"
		if not "%~1" equ "" (set "%~1=%dk_selectFile:\=/%")
	)
>>>>>>> Development
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_selectFile myFile
    %dk_call% dk_echo "myFile = %myFile%"
=======
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_selectFile mySelection
    %dk_call% dk_echo "dk_selectFile = '%dk_selectFile%'"
	%dk_call% dk_echo "mySelection = '%mySelection%'"
>>>>>>> Development
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