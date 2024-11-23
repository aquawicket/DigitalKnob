@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
::if not defined dk_DKBRANCH_DIR (set "dk_DKBRANCH_DIR=1") else (goto:eof)

::###############################################################################
::# dk_DKIMPORTS_DIR()
::#
::#
:dk_DKIMPORTS_DIR
	call dk_debugFunc 0
	
	%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
	%dk_call% dk_set DKIMPORTS_DIR "%DK3RDPARTY_DIR%\_DKIMPORTS"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_DKIMPORTS_DIR
	%dk_call% dk_printVar DKIMPORTS_DIR
%endfunction%
