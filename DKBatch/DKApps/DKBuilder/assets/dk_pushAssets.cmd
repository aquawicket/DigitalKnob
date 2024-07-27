@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_pushAssets()
::#
::#
:dk_pushAssets
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
    echo not implemented,  TODO
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_pushAssets
goto:eof
