@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# dk_deleteTempFiles()
::#
::#
:dk_deleteTempFiles
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
	for /r %%Z in (*.tmp) do @if %%~xZ==.tmp del "%%Z"
	for /r %%Z in (*.TMP) do @if %%~xZ==.TMP del "%%Z"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_deleteTempFiles
%endfunction%
