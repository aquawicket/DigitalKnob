@echo off
::cls
echo %~0(%*)
if "%*" NEQ "" call %* 


::###### Settings ######
set ENABLE_dk_debugFunc=1
::set ENABLE_dk_verbose=0
::set TRACE_ON_VERBOSE=1
::set PAUSE_ON_VERBOSE=1
::set HALT_ON_VERBOSE=1
::set ENABLE_dk_debug=0
::set TRACE_ON_DEBUG=1
::set PAUSE_ON_DEBUG=1
::set HALT_ON_DEBUG=1
::set ENABLE_dk_warning=0
::set TRACE_ON_WARNING=1
::set PAUSE_ON_WARNING=1
::set HALT_ON_WARNING=1
::set ENABLE_dk_error=0
::set TRACE_ON_ERROR=0
::set PAUSE_ON_ERROR=0
::set HALT_ON_ERROR=1


::###### DK_INIT ######
call "DKBatch/functions/DK.cmd"


::###### Global variables ######
echo DKSCRIPT_PATH = %DKSCRIPT_PATH%
echo DKBATCH_DIR = %DKBATCH_DIR%


::###### Load Main Program ######
dk_buildMain %*