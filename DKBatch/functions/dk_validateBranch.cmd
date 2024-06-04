@echo off
call DK

::####################################################################
::# dk_validateBranch()
::#
::#
:dk_validateBranch () {
    call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
    :: https://stackoverflow.com/a/33662275
    :: If the current folder matches the current branch set DKBRANCH, default to Development
	call dk_printVar CD
    for %%I in (.) do set FOLDER=%%~nxI
	call dk_set DKBRANCH Development
	if exist .git (
        "%GIT_EXE%" branch | find "* %FOLDER%" > NUL & if ERRORLEVEL 0 (
			call dk_set DKBRANCH %FOLDER%
        )
    )
	
	call dk_validate DIGITALKNOB_DIR dk_getDKPaths

	call dk_set DKBRANCH_DIR %DIGITALKNOB_DIR%\%DKBRANCH%
		call dk_set DK3RDPARTY_DIR %DKBRANCH_DIR%\3rdParty
			call dk_set DKIMPORTS_DIR %DK3RDPARTY_DIR%\_DKIMPORTS
		call dk_set DKAPPS_DIR %DKBRANCH_DIR%\DKApps
		call dk_set DKBASH_DIR %DKBRANCH_DIR%\DKBash
			call dk_set DKBASH_FUNCTIONS_DIR %DKBASH_DIR%\functions
		call dk_set DKBATCH_DIR %DKBRANCH_DIR%\DKBatch
			call dk_set DKBATCH_FUNCTIONS_DIR %DKBATCH_DIR%\functions
		call dk_set DKCMAKE_DIR %DKBRANCH_DIR%\DKCMake
			call dk_set DKCMAKE_FUNCTIONS_DIR %DKCMAKE_DIR%\functions
		call dk_set DKDOCS_DIR %DKBRANCH_DIR%\DKDocs
		call dk_set DKPLUGINS_DIR %DKBRANCH_DIR%\DKPlugins
		call dk_set DKPOWERSHELL_DIR %DKBRANCH_DIR%\DKPowershell
			call dk_set DKPOWERSHELL_FUNCTIONS_DIR %DKPOWERSHELL_DIR%\functions
	
    :: make sure script is running from DKBRANCH_DIR
    ::if not %DKSCRIPT_DIR% == %DKBRANCH_DIR% (
    ::      if not exist %DKBRANCH_DIR%\%DKSCRIPT_NAME% (
    ::              call dk_copy %DKSCRIPT_DIR%\%DKSCRIPT_NAME% %DKBRANCH_DIR%\%DKSCRIPT_NAME%
    ::      )
    ::      echo .
    ::      echo "RELOADING SCRIPT TO -> %DKBRANCH_DIR%\%DKSCRIPT_NAME%"
    ::      pause
    ::      start "" "%DKBRANCH_DIR%\%DKSCRIPT_NAME%"
    ::      if exist %DKBRANCH_DIR%\%DKSCRIPT_NAME% (
    ::              del "%DKSCRIPT_DIR%\%DKSCRIPT_NAME%"
    ::      )
    ::      exit
    ::)
    call dk_checkError
goto:eof




:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	call dk_validateBranch
