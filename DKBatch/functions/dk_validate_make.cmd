::dk_include_guard()

::####################################################################
::# dk_validate_make()
::#
::#
:dk_validate_make () {
	call dk_verbose "dk_validate_make(%*)"
	
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/make/DKMAKE.cmake')" "MAKE_PROGRAM"
	call dk_debug MAKE_PROGRAM
    call dk_checkError
goto:eof