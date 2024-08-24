@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_buildMain()
::#
::#
:dk_buildMain
 ::setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_assert DKSCRIPT_PATH
	%dk_call% dk_assert DKSCRIPT_DIR
	%dk_call% dk_assert DKSCRIPT_NAME

	%dk_call% dk_getHostTriple
	%dk_call% dk_getDKPaths
    %dk_call% dk_installGit
    %dk_call% dk_validateBranch
    
	if "%DKSCRIPT_DIR%" neq "%DKBRANCH_DIR%" (
		%dk_call% dk_warning "Not running from the DKBRANCH_DIR directory. Any changes will not be saved by git!"
		%dk_call% dk_warning "DKSCRIPT_DIR = %DKSCRIPT_DIR%"
		%dk_call% dk_warning "DKBRANCH_DIR = %DKBRANCH_DIR%"
	)
    
    :while_loop   
		%dk_call% dk_echo "APP=%APP% - TARGET_OS=%TARGET_OS% - TYPE=%TYPE%"
		
		if "%UPDATE%"==""     %dk_call% dk_pickUpdate & goto:while_loop
		if "%APP%"==""        %dk_call% dk_pickApp    & goto:while_loop
		if "%TARGET_OS%"==""  %dk_call% dk_pickOs     & goto:while_loop
		if "%TYPE%"==""       %dk_call% dk_pickType   & goto:while_loop

		%dk_call% dk_createCache
		%dk_call% dk_generate
		%dk_call% dk_buildApp

		%dk_call% dk_unset UPDATE
		%dk_call% dk_unset APP
		%dk_call% dk_unset TARGET_OS
		%dk_call% dk_unset TYPE
	goto while_loop
 ::endlocal
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_buildMain
 endlocal
goto:eof
