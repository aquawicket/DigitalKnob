@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::#########################################################################
::# dk_getGitBranchName(url rtn_var)
::#
::#	Return the name of the head branch from a git repository
::#
::#	@url	- The git url
::#	@rtn_var	- Returns the name of the head branch
::#
::#	https://stackoverflow.com/a/31919435
::#
:dk_getGitBranchName
	%dk_call% dk_debugFunc 1 2
	
	%dk_call% dk_depend git
			
	%dk_call% dk_exec %GIT_EXE% ls-remote %url% heads/*
	
	endlocal & (
		set "dk_getGitBranchName=%dk_exec%"
	)

%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_getGitBranchName
	%dk_call% dk_printVar dk_getGitBranchName
%endfunction%