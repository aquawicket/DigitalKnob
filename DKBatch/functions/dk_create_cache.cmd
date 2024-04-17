::dk_include_guard()

::################################################################################
::# dk_create_cache()
::#
::#
:dk_create_cache () {
	call dk_verbose "dk_create_cache(%*)"
	
    echo creating cache...
    ::call dk_debug APP
    ::call dk_debug TARGET_OS
    ::call dk_debug TYPE
    ::call dk_debug LEVEL
        
    :: https://stackoverflow.com/a/5143293/688352
    echo %APP%>"%DKBRANCH_DIR%\cache"
    echo %TARGET_OS%>>"%DKBRANCH_DIR%\cache"
    echo %TYPE%>>"%DKBRANCH_DIR%\cache"
    ::echo %LEVEL%>>"%DKBRANCH_DIR%\cache"
goto:eof