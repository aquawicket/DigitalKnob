@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_imgToIco(<imgFile>, <icoFile>)
::#
::#
:dk_imgToIco
setlocal
	%dk_call% dk_debugFunc 2 3
 
    set "imgFile=%~1"
	set "imgFile=%imgFile:/=\%"
    set "icoFile=%~2"
	set "icoFile=%icoFile:/=\%"
    set "OVERWRITE=%~3"
    
    if not defined OVERWRITE if exist "%icoFile%" (%dk_call% dk_warning "%icoFile% already exists" && %return%)
	if exist "%icoFile%" (%dk_call% dk_delete "%icoFile%")

	%dk_call% dk_callDKPowershell dk_imgToIco "%imgFile% %icoFile%"
    
    if not exist %icoFile% (%dk_call% dk_fatal "Failed to create shortcut:%icoFile%")
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	set "imgFile=C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKCore/icons/icon.png"
	set "icoFile=C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKCore/icons/icon.ico"
	%dk_call% dk_imgToIco "%imgFile%" "%icoFile%"
%endfunction%
