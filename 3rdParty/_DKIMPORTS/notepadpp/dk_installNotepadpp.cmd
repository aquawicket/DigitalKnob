@echo off
call ../../../DKBatch/functions/DK.cmd

::####################################################################
::# dk_installNotepadpp()
::#
:dk_installNotepadpp () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	
	
	
	:: install via CMake
	call dk_validate DKIMPORTS_DIR dk_validateBranch
	call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/notepadpp/DKMAKE.cmake')" "NOTEPADPP_EXE"
	call dk_printVar NOTEPADPP_EXE
	call dk_checkError
goto:eof