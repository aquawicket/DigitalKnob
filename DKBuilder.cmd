@echo off
::echo %~0(%*)


::###### DK_INIT ######
if not exist "DKBatch\functions" mkdir DKBatch\functions
if not exist "DKBatch\functions\DK.cmd" powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBatch/functions/DK.cmd', 'DKBatch\functions\DK.cmd')"
call "DKBatch/functions/DK.cmd"


::###### Global variables ######
::call dk_printVar DKSCRIPT_PATH
::call dk_printVar DKBATCH_DIR


::###### Load Main Program ######
if "%*" NEQ "" call %*
call dk_load dk_buildMain
call dk_buildMain %*
