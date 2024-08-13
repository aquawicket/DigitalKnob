@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_pullAssets()
::#
::#
:dk_pullAssets
	call dk_debugFunc 0
	
    echo not implemented,  TODO
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_pullAssets
goto:eof
