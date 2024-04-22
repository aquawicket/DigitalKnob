::dk_include_guard()

::####################################################################
::# dk_cmake_notepadpp()
::#
::#
:dk_cmake_notepadpp () {
	call dk_verbose "dk_cmake_notepadpp(%*)"
	
	if "%DKIMPORTS_DIR%"==""  call dk_validate_branch
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/notepadpp/DKMAKE.cmake')" "NOTEPADPP_EXE"
	call dk_debug NOTEPADPP_EXE
    call dk_checkError
goto:eof