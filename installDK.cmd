@echo off

::###### DK_INIT ######
set "DKHTTP_DKBATCH_FUNCTIONS_DIR=https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBatch/functions"
if not exist "DKBatch\functions" mkdir DKBatch\functions
if not exist "DKBatch\functions\DK.cmd" powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/DK.cmd', 'DKBatch\functions\DK.cmd')"

call "DKBatch/functions/DK.cmd" %*

::###### Load Main Program ######
call dk_load dk_validate
call dk_load dk_validateBranch
call dk_load dk_validateGit
call dk_load dk_stringContains
call dk_load dk_getDKPaths
call dk_load dk_getHostTriple
call dk_load dk_getExtension
call dk_load dk_removeExtension
call dk_load dk_makeDirectory
call dk_load dk_replaceAll
call dk_load dk_convertToCIdentifier
call dk_load dk_toLower

::###### Run Program ######
call dk_validate DKBRANCH_DIR "call dk_validateBranch"
call dk_validate GIT_EXE "call dk_validateGit"
if NOT exist "%DKBRANCH_DIR%\.git" (
	"%GIT_EXE%" clone https://github.com/aquawicket/DigitalKnob.git "%DKBRANCH_DIR%"
	cd "%DKBRANCH_DIR%"
	"%GIT_EXE%" checkout "%DKBRANCH%"
	echo Digitalknob installation complete
	pause
	exit
) else (
	echo DigitalKnob is already installed at %DKBRANCH_DIR%
)