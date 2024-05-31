@echo off
call DK

::####################################################################
::# dk_validateBranch()
::#
::#
:dk_validateBranch () {
    call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
    :: https://stackoverflow.com/a/33662275
    :: If the current folder matches the current branch set DKBRANCH, default to Development
    for %%I in (.) do set FOLDER=%%~nxI
    set DKBRANCH=Development
    
	if not defined DIGITALKNOB_DIR call dk_getDKPaths
	if exist .git (
        "%GIT_EXE%" branch | find "* %FOLDER%" > NUL & if ERRORLEVEL 0 (
            set DKBRANCH=%FOLDER%
        )
    )
    call dk_printVar DKBRANCH
	
    set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\%DKBRANCH%"
	call dk_printVar DKBRANCH_DIR
	
	set "DKCMAKE_DIR=%DKBRANCH_DIR%\DKCMake"
	call dk_printVar DKCMAKE_DIR
	
	set "DK3RDPARTY_DIR=%DKBRANCH_DIR%\3rdParty"
	call dk_printVar DK3RDPARTY_DIR
	
	set "DKIMPORTS_DIR=%DK3RDPARTY_DIR%\_DKIMPORTS"
	call dk_printVar DKIMPORTS_DIR
	
    set "DKAPPS_DIR=%DKBRANCH_DIR%\DKApps"
    call dk_printVar DKAPPS_DIR
	
    set "DKPLUGINS_DIR=%DKBRANCH_DIR%\DKPlugins"
    call dk_printVar DKPLUGINS_DIR
    
	set "DKBASH_DIR=%DKBRANCH_DIR%\DKBash"
    call dk_printVar DKBASH_DIR
	
	set "DKBATCH_DIR=%DKBRANCH_DIR%\DKBatch"
    call dk_printVar DKBATCH_DIR
	
	set "DKPOWERSHELL_DIR=%DKBRANCH_DIR%\DKPowershell"
    call dk_printVar DKPOWERSHELL_DIR
	
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
