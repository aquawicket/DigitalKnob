::dk_include_guard()

::####################################################################
::# dk_validateMsys2()
::#
::#
:dk_validateMsys2 () {
	call dk_verbose "dk_validateMsys2(%*)"
	
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/msys2/DKMAKE.cmake')" "MSYS2;MSYS2_GENERATOR"
	call dk_debug MSYS2
	call dk_debug MSYS2_GENERATOR
    call dk_checkError
goto:eof