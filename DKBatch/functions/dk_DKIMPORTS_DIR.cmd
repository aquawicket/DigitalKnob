@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
::if not defined dk_DKBRANCH_DIR (set "dk_DKBRANCH_DIR=1") else (goto:eof)

::###############################################################################
::# dk_DKIMPORTS_DIR()
::#
::#
:dk_DKIMPORTS_DIR
	call dk_debugFunc 0 1
	
	::############ SET ############
	if "%~1" neq "" ( 
		set "DKIMPORTS_DIR=%~1"
		%return%
	)
	
	rem ############ GET ############
	%dk_call% dk_validatePath DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
	set "DKIMPORTS_DIR=%DK3RDPARTY_DIR%\_DKIMPORTS"

	%dk_call% dk_assertPath DKIMPORTS_DIR
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Getting DKIMPORTS_DIR . . ."
	%dk_call% dk_DKIMPORTS_DIR
	%dk_call% dk_printVar DKIMPORTS_DIR
	
	%dk_call% dk_echo
	%dk_call% dk_echo "Test Setting DKIMPORTS_DIR . . ."
	%dk_call% dk_DKIMPORTS_DIR "C:\DK\DKImports"
	%dk_call% dk_printVar DKIMPORTS_DIR 
%endfunction%