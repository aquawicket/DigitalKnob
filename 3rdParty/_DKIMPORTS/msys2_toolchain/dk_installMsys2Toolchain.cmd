@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installMsys2Toolchain()
::#
:dk_installMsys2Toolchain
	call dk_debugFunc 0
	
	call dk_todo
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_installMsys2Toolchain
%endfunction%
