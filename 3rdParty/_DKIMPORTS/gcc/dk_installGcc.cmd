@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installGcc()
::#
:dk_installGcc
	call dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR    "%dk_call% dk_DKBRANCH_DIR"
    %dk_call% dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/gcc/DKMAKE.cmake')" "GCC_EXE;GXX_EXE"
	%dk_call% dk_printVar GCC_EXE
	%dk_call% dk_printVar GXX_EXE
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
    call dk_installGcc
%endfunction%
