@echo off
call ../../../DKBatch/functions/DK.cmd
call dk_includeGuard

::####################################################################
::# dk_InstallEmsdk()
::#
::#
:dk_InstallEmsdk () {
	call dk_debugFunc
	
    if "%DKIMPORTS_DIR%"=""   call dk_validateBranch
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/emsdk/DKMAKE.cmake')" "EMSDK;EMSDK_ENV;EMSDK_GENERATOR;EMSDK_TOOLCHAIN_FILE;EMSDK_C_COMPILER;EMSDK_CXX_COMPILER"
    call dk_printVar EMSDK
    call dk_printVar EMSDK_ENV
    call dk_printVar EMSDK_GENERATOR
    call dk_printVar EMSDK_TOOLCHAIN_FILE
    call dk_printVar EMSDK_C_COMPILER
    call dk_printVar EMSDK_CXX_COMPILER
    call dk_checkError
goto:eof