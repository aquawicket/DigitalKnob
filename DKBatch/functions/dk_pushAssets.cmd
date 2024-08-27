@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_pushAssets()
::#
::#
:dk_pushAssets
 setlocal
	call dk_debugFunc 0
	
    echo not implemented,  TODO
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_pushAssets
goto:eof
