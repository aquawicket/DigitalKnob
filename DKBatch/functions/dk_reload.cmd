@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_reload()
::#
::#
:dk_reload
setlocal
    %dk_call% dk_debugFunc 0
    
    if not exist "%DKSCRIPT_PATH%" (
		%dk_call% dk_error "DKSCRIPT_PATH:%DKSCRIPT_PATH% does not exist"
		%return%
	)
    
    %dk_call% dk_clearScreen
    %dk_call% dk_info "reloading %DKSCRIPT_PATH%. . ."
    
    ::###### METHOD 1 ######
	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
    %dk_call% dk_fileWrite "%DKCACHE_DIR%/reload" "%DKSCRIPT_PATH%"
	%dk_call% dk_exit 0
        
    ::###### METHOD 2 ######
    ::start "" "%DKSCRIPT_PATH%" & dk_exit & dk_exit & dk_exit
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_pause "Press any key to test dk_reload"
    %dk_call% dk_reload
%endfunction%
