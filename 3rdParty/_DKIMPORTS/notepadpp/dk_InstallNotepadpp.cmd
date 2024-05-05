@echo off
call ../../../DKBatch/functions/DK.cmd
call dk_includeGuard

::####################################################################
::# dk_InstallNotepadpp()
::#
::#
:dk_InstallNotepadpp () {
	call dk_debugFunc
	
	call dk_validate DKIMPORTS_DIR dk_validateBranch
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/notepadpp/DKMAKE.cmake')" "NOTEPADPP_EXE"
	call dk_printVar NOTEPADPP_EXE
    call dk_checkError

    call dk_exit
goto:eof