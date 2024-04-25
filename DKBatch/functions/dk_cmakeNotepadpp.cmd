::dk_includeGuard()

::####################################################################
::# dk_cmakeNotepadpp()
::#
::#
:dk_cmakeNotepadpp () {
	call dk_debugFunc
	
	if "%DKIMPORTS_DIR%"==""  call dk_validateBranch
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/notepadpp/DKMAKE.cmake')" "NOTEPADPP_EXE"
	call dk_debug NOTEPADPP_EXE
    call dk_checkError
goto:eof