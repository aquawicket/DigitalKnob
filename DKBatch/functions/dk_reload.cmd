<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::####################################################################
::# dk_reload()
::#
::#
:dk_reload
<<<<<<< HEAD
 setlocal
    call dk_debugFunc 0
    
    if not exist "%DKSCRIPT_PATH%" %dk_call% dk_error "DKSCRIPT_PATH:%DKSCRIPT_PATH% does not exist" && %return%
=======
setlocal
    %dk_call% dk_debugFunc 0
    
    if not exist "%DKSCRIPT_PATH%" (
		%dk_call% dk_error "DKSCRIPT_PATH:%DKSCRIPT_PATH% does not exist"
		%return%
	)
>>>>>>> Development
    
    %dk_call% dk_clearScreen
    %dk_call% dk_info "reloading %DKSCRIPT_PATH%. . ."
    
    ::###### METHOD 1 ######
<<<<<<< HEAD
	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKHOME_DIR"
    %dk_call% dk_fileWrite "%DKCACHE_DIR%\reload" "%DKSCRIPT_PATH%"
=======
	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
    %dk_call% dk_fileWrite "%DKCACHE_DIR%/reload" "%DKSCRIPT_PATH%"
>>>>>>> Development
	%dk_call% dk_exit 0
        
    ::###### METHOD 2 ######
    ::start "" "%DKSCRIPT_PATH%" & dk_exit & dk_exit & dk_exit
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
    %dk_call% dk_pause "Press any key to test dk_reload"
    %dk_call% dk_reload
%endfunction%
