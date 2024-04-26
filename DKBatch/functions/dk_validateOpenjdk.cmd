call dk_includeGuard

::####################################################################
::# dk_validateOpenjdk()
::#
::#
:dk_validateOpenjdk () {
	call dk_debugFunc
	
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/openjdk/DKMAKE.cmake')" "OPENJDK"
	call dk_debug OPENJDK
    call dk_checkError
goto:eof