@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_deleteTempFiles()
::#
::#
:dk_deleteTempFiles
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_info "Deleting .tmp files . . ."
    %dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
    %dk_call% dk_cd "%DIGITALKNOB_DIR%"
	for /r %%Z in (*.tmp) do @if %%~xZ==.tmp del "%%Z"
	for /r %%Z in (*.TMP) do @if %%~xZ==.TMP del "%%Z"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_deleteTempFiles
%endfunction%
