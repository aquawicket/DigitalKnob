@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installMake()
::#
:dk_installMake
	call dk_debugFunc 0
	
	
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/make/DKMAKE.cmake')" "MAKE_PROGRAM"
	call dk_printVar MAKE_PROGRAM
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_installMake
%endfunction%
