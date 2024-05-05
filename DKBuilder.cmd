@echo off
::echo %~0(%*)


::###### DK_SETUP ######
::[ ! -e DKBash ] && mkdir DKBash
::[ ! -e DKBash/functions ] && mkdir DKBash/functions
::[ ! -e DKBash/functions/DK.sh ] && wget -P DKBash/functions https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBash/functions/DK.sh


::###### DK_INIT ######
call "DKBatch/functions/DK.cmd"


::###### Global variables ######
call dk_printVar DKSCRIPT_PATH
call dk_printVar DKBATCH_DIR


::###### Load Main Program ######
if "%*" NEQ "" call %* 
call dk_buildMain %*