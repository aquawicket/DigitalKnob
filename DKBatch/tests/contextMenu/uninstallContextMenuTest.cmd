@echo off
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../functions/")
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DKINIT_cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %* && exit /b %errorlevel%)

rem ####################################################################
::# dk_uninstallGitContextMenu()
::#
::#
:dk_uninstallGitContextMenu
::setlocal
	
	%dk_call% dk_uninstallContextMenu "GIT ADD"
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	
    call dk_uninstallGitContextMenu
%endfunction%
