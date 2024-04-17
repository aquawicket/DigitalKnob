::dk_include_guard()

::####################################################################
::# dk_get_dkpaths()
::#
::#
:dk_get_dkpaths () {
	call dk_verbose "dk_get_dkpaths(%*)"
	
	
	
	set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
    call dk_make_directory "%DIGITALKNOB_DIR%"
    call dk_debug DIGITALKNOB_DIR






    set "DKTOOLS_DIR=%DIGITALKNOB_DIR%\DKTools"
    call dk_make_directory "%DKTOOLS_DIR%"
    call dk_debug DKTOOLS_DIR
        
    set "DKDOWNLOAD_DIR=%DIGITALKNOB_DIR%\download"
    call dk_make_directory "%DKDOWNLOAD_DIR%"
    call dk_debug DKDOWNLOAD_DIR
goto:eof