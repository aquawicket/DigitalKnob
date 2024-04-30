@echo off
call ../../../DKBatch/functions/DK.cmd
call dk_includeGuard

::####################################################################
::# dk_InstallMsys2()
::#
::#
:dk_InstallMsys2 () {
	call dk_debugFunc
	
	if "%DKIMPORTS_DIR%"==""  call dk_validateBranch
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/msys2/DKMAKE.cmake')" "MSYS2" &::;MSYS2_GENERATOR"
	call dk_debug MSYS2
	::call dk_debug MSYS2_GENERATOR
goto:eof