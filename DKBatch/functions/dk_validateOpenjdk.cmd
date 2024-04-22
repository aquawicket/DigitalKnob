::dk_include_guard()

::####################################################################
::# dk_validateOpenjdk()
::#
::#
:dk_validateOpenjdk () {
	call dk_verbose "dk_validateOpenjdk(%*)"
	
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/openjdk/DKMAKE.cmake')" "OPENJDK"
	call dk_debug OPENJDK
    call dk_checkError
goto:eof