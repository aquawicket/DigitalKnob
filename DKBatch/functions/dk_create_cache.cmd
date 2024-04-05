::dk_include_guard()

::#################################################################################
:: dk_create_cache()
::
::
:dk_create_cache
	call dk_verbose "dk_create_cache(%*)"
	
    echo creating cache...
    ::call dk_print_var APP
    ::call dk_print_var TARGET_OS
    ::call dk_print_var TYPE
    ::call dk_print_var LEVEL
        
    :: https://stackoverflow.com/a/5143293/688352
    echo %APP%>"%DKBRANCH_DIR%\cache"
    echo %TARGET_OS%>>"%DKBRANCH_DIR%\cache"
    echo %TYPE%>>"%DKBRANCH_DIR%\cache"
    ::echo %LEVEL%>>"%DKBRANCH_DIR%\cache"
goto:eof