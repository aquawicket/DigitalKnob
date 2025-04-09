@echo off
if not defined DKBATCH_FUNCTIONS_DIR_  (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/DKBatch/functions/")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)


::############################################################################
::# DKINSTALL()
::#
:DKINSTALL
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"

	echo ############ Install DK languages ############
	call %DKBRANCH_DIR%/DKBash/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKBatch/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKC/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKCMake/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKCpp/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKCSharp/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKHta/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKHtml/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKJava/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKJavascript/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKPhp/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKPowershell/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKPython/DKINSTALL.cmd
	call %DKBRANCH_DIR%/DKVb/DKINSTALL.cmd

	echo ############ Install 3rdParty #############
	
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	call :DKINSTALL
%endfunction%