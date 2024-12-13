@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installEmsdk()
::#
:dk_installEmsdk
	call dk_debugFunc 0
:: setlocal
	
	%dk_call% dk_validate DKIMPORTS_DIR    "%dk_call% dk_DKIMPORTS_DIR"
    %dk_call% dk_cmakeEval "dk_load(%DKIMPORTS_DIR%/emsdk/DKMAKE.cmake)" "EMSDK;EMSDK_ENV;EMSDK_GENERATOR;EMSDK_TOOLCHAIN_FILE;EMSDK_C_COMPILER;EMSDK_CXX_COMPILER"
    %dk_call% dk_printVar EMSDK
    %dk_call% dk_printVar EMSDK_ENV
    %dk_call% dk_printVar EMSDK_GENERATOR
    %dk_call% dk_printVar EMSDK_TOOLCHAIN_FILE
    %dk_call% dk_printVar EMSDK_C_COMPILER
    %dk_call% dk_printVar EMSDK_CXX_COMPILER
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
 setlocal
 
	%dk_call% dk_installEmsdk
%endfunction%
