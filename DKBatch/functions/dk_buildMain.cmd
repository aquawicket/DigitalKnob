@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

call dk_source dk_assert
call dk_source dk_build
call dk_source dk_createCache
call dk_source dk_createShortcut
call dk_source dk_debugFunc
call dk_source dk_defined
call dk_source dk_error
call dk_source dk_generate
call dk_source dk_getDKPaths
call dk_source dk_getHostTriple
call dk_source dk_info
call dk_source dk_installGit
call dk_source dk_pickApp
call dk_source dk_pickOs
call dk_source dk_pickType
call dk_source dk_pickUpdate
call dk_source dk_printVar
call dk_source dk_unset
call dk_source dk_validateBranch
call dk_source dk_warning
::####################################################################
::# dk_buildMain()
::#
::#
:dk_buildMain
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"

	call dk_assert DKSCRIPT_PATH
	call dk_assert DKSCRIPT_DIR
	call dk_assert DKSCRIPT_NAME

	call dk_getHostTriple
	call dk_getDKPaths
	
    call dk_installGit
    call dk_validateBranch
    
	if "%DKSCRIPT_DIR%" neq "%DKBRANCH_DIR%" (
		call dk_warning "Not running from the DKBRANCH_DIR directory. Any changes will not be saved by git!"
		call dk_warning "DKSCRIPT_DIR = %DKSCRIPT_DIR%"
		call dk_warning "DKBRANCH_DIR = %DKBRANCH_DIR%"
	)
    
    :while_loop             
		if "%UPDATE%"==""     call dk_pickUpdate & goto:while_loop
		if "%APP%"==""        call dk_pickApp    & goto:while_loop
		if "%TARGET_OS%"==""  call dk_pickOs     & goto:while_loop
		if "%TYPE%"==""       call dk_pickType   & goto:while_loop

		call dk_createCache
		call dk_generate
		call dk_build

		call dk_unset UPDATE
		call dk_unset APP
		call dk_unset TARGET_OS
		call dk_unset TYPE
	goto while_loop
	endlocal
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_buildMain
goto:eof
