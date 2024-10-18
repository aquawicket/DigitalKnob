@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installClang()
::#
:dk_installClang
	call dk_debugFunc 0

	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKBRANCH_DIR"
    %dk_call% dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/clang/DKMAKE.cmake')" "CLANG_EXE;CLANGXX_EXE"
	%dk_call% dk_printVar CLANG_EXE
	%dk_call% dk_printVar CLANGXX_EXE
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_installClang
%endfunction%
