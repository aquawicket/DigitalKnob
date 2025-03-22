@echo off
if not defined DKBATCH_FUNCTIONS_DIR_  (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/DKBatch/functions/")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)


::############################################################################
::# dk_install()
::#
:dk_install
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"

	echo ############ Install DK languages ############
	call %DKBRANCH_DIR%/DKBash/dk_install.cmd
	call %DKBRANCH_DIR%/DKBatch/dk_install.cmd
	::call %DKBRANCH_DIR%/DKC/dk_install.cmd
	call %DKBRANCH_DIR%/DKCMake/dk_install.cmd
	::call %DKBRANCH_DIR%/DKCpp/dk_install.cmd
	call %DKBRANCH_DIR%/DKCSharp/dk_install.cmd
	call %DKBRANCH_DIR%/DKHta/dk_install.cmd
	call %DKBRANCH_DIR%/DKHtml/dk_install.cmd
	call %DKBRANCH_DIR%/DKJava/dk_install.cmd
	call %DKBRANCH_DIR%/DKJavascript/dk_install.cmd
	call %DKBRANCH_DIR%/DKPhp/dk_install.cmd
	call %DKBRANCH_DIR%/DKPowershell/dk_install.cmd
	call %DKBRANCH_DIR%/DKPython/dk_install.cmd
	call %DKBRANCH_DIR%/DKVb/dk_install.cmd

	echo ############ Install 3rdParty #############
	
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	call :dk_install
%endfunction%