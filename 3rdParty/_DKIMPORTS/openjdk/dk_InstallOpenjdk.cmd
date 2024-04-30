@echo off
call ../../../DKBatch/functions/DK.cmd
call dk_includeGuard

::####################################################################
::# dk_InstallOpenjdk()
::#
::#
:dk_InstallOpenjdk () {
	call dk_debugFunc
	
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/openjdk/DKMAKE.cmake')" "OPENJDK"
	call dk_debug OPENJDK
    call dk_checkError
goto:eof