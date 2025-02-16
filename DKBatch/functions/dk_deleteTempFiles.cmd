@echo off
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# dk_deleteTempFiles()
::#
::#
:dk_deleteTempFiles
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_info "Deleting .tmp files . . ."
   
	%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
    %dk_call% dk_cd "%DK3RDPARTY_DIR%"
	for /r %%Z in (*.tmp) do @if %%~xZ==.tmp del "%%Z"
	for /r %%Z in (*.TMP) do @if %%~xZ==.TMP del "%%Z"
	
	%dk_call% dk_validate DKCPP_APPS_DIR     "%dk_call% dk_DKAPPS_DIR"
	%dk_call% dk_cd "%DKCPP_APPS_DIR%"
	for /r %%Z in (*.tmp) do @if %%~xZ==.tmp del "%%Z"
	for /r %%Z in (*.TMP) do @if %%~xZ==.TMP del "%%Z"
	
	%dk_call% dk_validate DKPLUGINS_DIR  "%dk_call% dk_DKPLUGINS_DIR"
	%dk_call% dk_cd "%DKPLUGINS_DIR%"
	for /r %%Z in (*.tmp) do @if %%~xZ==.tmp del "%%Z"
	for /r %%Z in (*.TMP) do @if %%~xZ==.TMP del "%%Z"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_deleteTempFiles
%endfunction%
