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
::# dk_deleteTempFiles()
::#
::#
:dk_deleteTempFiles
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_info "Deleting .tmp files . . ."
   
	%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DKBRANCH_DIR"
    %dk_call% dk_validate DKAPPS_DIR     "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_validate DKPLUGINS_DIR  "%dk_call% dk_DKBRANCH_DIR"
	
    %dk_call% dk_cd "%DK3RDPARTY_DIR%"
	for /r %%Z in (*.tmp) do @if %%~xZ==.tmp del "%%Z"
	for /r %%Z in (*.TMP) do @if %%~xZ==.TMP del "%%Z"
	
	%dk_call% dk_cd "%DKAPPS_DIR%"
	for /r %%Z in (*.tmp) do @if %%~xZ==.tmp del "%%Z"
	for /r %%Z in (*.TMP) do @if %%~xZ==.TMP del "%%Z"
	
	%dk_call% dk_cd "%DKPLUGINS_DIR%"
=======
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_info "Deleting .tmp files . . ."
   
	%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
    %dk_call% dk_chdir "%DK3RDPARTY_DIR%"
	for /r %%Z in (*.tmp) do @if %%~xZ==.tmp del "%%Z"
	for /r %%Z in (*.TMP) do @if %%~xZ==.TMP del "%%Z"
	
	%dk_call% dk_validate DKCPP_APPS_DIR     "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_chdir "%DKCPP_APPS_DIR%"
	for /r %%Z in (*.tmp) do @if %%~xZ==.tmp del "%%Z"
	for /r %%Z in (*.TMP) do @if %%~xZ==.TMP del "%%Z"
	
	%dk_call% dk_validate DKCPP_PLUGINS_DIR  "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_chdir "%DKCPP_PLUGINS_DIR%"
>>>>>>> Development
	for /r %%Z in (*.tmp) do @if %%~xZ==.tmp del "%%Z"
	for /r %%Z in (*.TMP) do @if %%~xZ==.TMP del "%%Z"
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
    %dk_call% dk_deleteTempFiles
%endfunction%
