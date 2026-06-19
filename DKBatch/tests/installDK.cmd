@echo off

::###### install DK.cmd ######
set "DKHTTP_DKBATCH_FUNCTIONS_DIR=http://aquawicket.com/DigitalKnob/Development/DKBatch/functions"
if NOT EXIST "DKBatch/functions" mkdir DKBatch\functions
if NOT EXIST "DKBatch/functions/DK.cmd" %powershell.exe% -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/DK.cmd', 'DKBatch\functions\DK.cmd')"




::###### DK_INIT ######
call "DKBatch/functions/DK.cmd" %*

::###### Load Main Program ######
call dk_load dk_validate
call dk_load dk_depend
call dk_load dk_contains
call dk_load dk_DIGITALKNOB_DIR
call dk_load dk_Host_Tuple
call dk_load dk_getExtension
call dk_load dk_removeExtension
call dk_load dk_mkdir
call dk_load dk_replaceAll
::call dk_load dk_convertToCIdentifier
call dk_load dk_toLower
call dk_load dk_pause
call dk_load dk_exit

::###### Run Program ######
%dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
%dk_call% dk_validate git.exe %dk_call% dk_depend git
if NOT EXIST "%DKBRANCH_DIR%\.git" (
	"%git.exe%" clone %REPO_URL% "%DKBRANCH_DIR%"
	%dk_call% dk_chdir "%DKBRANCH_DIR%"
	"%git.exe%" -C %DKBRANCH_DIR% checkout "%DKBRANCH%"
	echo Digitalknob installation complete
) else (
	echo DigitalKnob is already installed at %DKBRANCH_DIR%
)

call dk_pause
call dk_exit
