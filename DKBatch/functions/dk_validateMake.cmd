::dk_includeGuard()

::####################################################################
::# dk_validateMake()
::#
::#
:dk_validateMake () {
	call dk_debugFunc
	
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/make/DKMAKE.cmake')" "MAKE_PROGRAM"
	call dk_debug MAKE_PROGRAM
    call dk_checkError
goto:eof