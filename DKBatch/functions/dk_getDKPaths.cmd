@echo off
call DK

::####################################################################
::# dk_getDKPaths()
::#
::#
:dk_getDKPaths () {
	call dk_debugFunc
		
	set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
    call dk_makeDirectory "%DIGITALKNOB_DIR%"
    call dk_printVar DIGITALKNOB_DIR


    set "DKTOOLS_DIR=%DIGITALKNOB_DIR%\DKTools"
    call dk_makeDirectory "%DKTOOLS_DIR%"
    call dk_printVar DKTOOLS_DIR
        
    set "DKDOWNLOAD_DIR=%DIGITALKNOB_DIR%\download"
    call dk_makeDirectory "%DKDOWNLOAD_DIR%"
    call dk_printVar DKDOWNLOAD_DIR
goto:eof