::dk_include_guard()

::#################################################################################
:: dk_get_dkpaths()
::
::
:dk_get_dkpaths () {
	call dk_verbose "%0(%*)"
	
	set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
    call dk_make_directory "%DIGITALKNOB_DIR%"
    call dk_print_var DIGITALKNOB_DIR

    set "DKTOOLS_DIR=%DIGITALKNOB_DIR%\DKTools"
    call dk_make_directory "%DKTOOLS_DIR%"
    call dk_print_var DKTOOLS_DIR
        
    set "DKDOWNLOAD_DIR=%DIGITALKNOB_DIR%\download"
    call dk_make_directory "%DKDOWNLOAD_DIR%"
    call dk_print_var DKDOWNLOAD_DIR
	goto:eof
	
	:::::::::::::::::::::::::::::::::::::::::::::::::::::::
	:: TODO - 
goto:eof