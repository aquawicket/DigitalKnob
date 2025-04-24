@echo off
<<<<<<< HEAD
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../functions/")
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
>>>>>>> Development

::####################################################################
::# dk_uninstallGitContextMenu()
::#
::#
:dk_uninstallGitContextMenu
<<<<<<< HEAD
    call dk_debugFunc 0
=======
::setlocal
    %dk_call% dk_debugFunc 0
>>>>>>> Development
	
	%dk_call% dk_uninstallContextMenu "GIT ADD"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
	call dk_debugFunc 0
=======
setlocal
	%dk_call% dk_debugFunc 0
>>>>>>> Development
	
    call dk_uninstallGitContextMenu
%endfunction%
