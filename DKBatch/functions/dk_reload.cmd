@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*

::####################################################################
::# dk_reload()
::#
::#
:dk_reload
 setlocal
    call dk_debugFunc 0
    
    if not exist "%DKSCRIPT_PATH%" %dk_call% dk_error "DKSCRIPT_PATH:%DKSCRIPT_PATH% does not exist" && goto:eof
    
    %dk_call% dk_clearScreen
    %dk_call% dk_info "reloading %DKSCRIPT_PATH%. . ."
    
    ::###### METHOD 1 ######
	%dk_call% dk_validate DKTEMP_DIR "%dk_call% dk_setDKTEMP_DIR"
    %dk_call% dk_fileWrite "%DKTEMP_DIR%\reload" "%DKSCRIPT_PATH%"
	%dk_call% dk_exit 0
        
    ::###### METHOD 2 ######
    ::start "" "%DKSCRIPT_PATH%" & dk_exit & dk_exit & dk_exit
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_pause "Press any key to test dk_reload"
    %dk_call% dk_reload
%endfunction%
