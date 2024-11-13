@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installCosmoCC()
::#
:dk_installCosmoCC
	call dk_debugFunc 0

	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKBRANCH_DIR"

    %dk_call% dk_cmakeEval "dk_load(%DKIMPORTS_DIR%/cosmocc/DKMAKE.cmake)" "COSMO_C_COMPILER;COSMO_CXX_COMPILER"
	%dk_call% dk_printVar COSMO_C_COMPILER
	%dk_call% dk_printVar COSMO_CXX_COMPILER
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_installCosmoCC
%endfunction%
