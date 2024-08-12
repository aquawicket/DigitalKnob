@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_validateBranch()
::#
::#
:dk_validateBranch
    call dk_debugFunc 0
	
    :: https://stackoverflow.com/a/33662275
    :: If the current folder matches the current branch set DKBRANCH. Otherwise, default to Development
	
	if not defined DIGITALKNOB_DIR call dk_setDIGITALKNOB_DIR
    for %%I in (.) do set "FOLDER=%%~nxI"			               &:: get the current folder

	set "DKBRANCH=Development"						               &:: set the default branch
	if not defined GIT_EXE call dk_installGit
	if exist "%CD%\.git" (
        "%GIT_EXE%" branch | find "* %FOLDER%" > NUL & if ERRORLEVEL 0 (
			set "DKBRANCH=%FOLDER%"
        )
    )
	

	set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\%DKBRANCH%"
		:: /3rdParty
		if not defined DK3RDPARTY_DIR set "DK3RDPARTY_DIR=%DKBRANCH_DIR%\3rdParty"
			if not defined DKIMPORTS_DIR set "DKIMPORTS_DIR=%DK3RDPARTY_DIR%\_DKIMPORTS"
		:: /DKApps
		if not defined DKAPPS_DIR set "DKAPPS_DIR=%DKBRANCH_DIR%\DKApps"
		:: /DKBash
		if not defined DKBASH_DIR set "DKBASH_DIR=%DKBRANCH_DIR%\DKBash"
			if not defined DKBASH_FUNCTIONS_DIR set "DKBASH_FUNCTIONS_DIR=%DKBASH_DIR%\functions"
		:: /DKBatch
		if not defined DKBATCH_DIR set "DKBATCH_DIR=%DKBRANCH_DIR%\DKBatch"
			if not defined DKBATCH_FUNCTIONS_DIR set "DKBATCH_FUNCTIONS_DIR=%DKBATCH_DIR%\functions"
			if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_DIR%\functions\"
		:: /DKCpp
		if not defined DKCPP_DIR set "DKCPP_DIR=%DKBRANCH_DIR%\DKCpp"
			if not defined DKCPP_FUNCTIONS_DIR set "DKCPP_FUNCTIONS_DIR=%DKCPP_DIR%\functions"
		:: /DKCMake
		if not defined DKCMAKE_DIR set "DKCMAKE_DIR=%DKBRANCH_DIR%\DKCMake"
			if not defined DKCMAKE_FUNCTIONS_DIR set "DKCMAKE_FUNCTIONS_DIR=%DKCMAKE_DIR%\functions"
		:: /DKCSharp
		if not defined DKCSHARP_DIR set "DKCSHARP_DIR=%DKCSHARP_DIR%\DKCSharp"
			if not defined DKCSHARP_FUNCTIONS_DIR set "DKCSHARP_FUNCTIONS_DIR=%DKCSHARP_DIR%\functions"
		:: /DKDocs
		if not defined DKDOCS_DIR set "DKDOCS_DIR=%DKBRANCH_DIR%\DKDocs"
		:: /DKHta
		if not defined DKHTA_DIR set "DKHTA_DIR=%DKHTA_DIR%\DKHta"
			if not defined DKHTA_FUNCTIONS_DIR set "DKHTA_FUNCTIONS_DIR=%DKHTA_DIR%\functions"
		:: /DKJava
		if not defined DKJAVA_DIR set "DKJAVA_DIR=%DKJAVA_DIR%\DKJava"
			if not defined DKJAVA_FUNCTIONS_DIR set "DKJAVA_FUNCTIONS_DIR=%DKJAVA_DIR%\functions"
		:: /DKJavascript
		if not defined DKJAVASCRIPT_DIR set "DKJAVASCRIPT_DIR=%DKBRANCH_DIR%\DKJavascript"
			if not defined DKJAVASCRIPT_FUNCTIONS_DIR set "DKJAVASCRIPT_FUNCTIONS_DIR=%DKJAVASCRIPT_DIR%\functions"
		:: /DKPhp
		if not defined DKPHP_DIR set "DKPHP_DIR=%DKBRANCH_DIR%\DKPhp"
			if not defined DKPHP_FUNCTIONS_DIR set "DKPHP_FUNCTIONS_DIR=%DKPHP_DIR%\functions"
		:: /DKPlugins
		if not defined DKPLUGINS_DIR set "DKPLUGINS_DIR=%DKBRANCH_DIR%\DKPlugins"
		:: /DKPowershell
		if not defined DKPOWERSHELL_DIR set "DKPOWERSHELL_DIR=%DKBRANCH_DIR%\DKPowershell"
			if not defined DKPOWERSHELL_FUNCTIONS_DIR set "DKPOWERSHELL_FUNCTIONS_DIR=%DKPOWERSHELL_DIR%\functions"
		:: /DKPython
		if not defined DKPYTHON_DIR set "DKPYTHON_DIR=%DKBRANCH_DIR%\DKPython"
			if not defined DKPYTHON_FUNCTIONS_DIR set "DKPYTHON_FUNCTIONS_DIR=%DKPYTHON_DIR%\functions"
		:: /DKVb
		if not defined DKVB_DIR set "DKVB_DIR=%DKBRANCH_DIR%\DKVb"
			if not defined DKVB_FUNCTIONS_DIR set "DKVB_FUNCTIONS_DIR=%DKVB_DIR%\functions"
goto:eof	
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
    ::call dk_checkError
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_validateBranch
goto:eof