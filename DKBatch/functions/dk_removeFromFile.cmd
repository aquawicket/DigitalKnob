@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"


::##################################################################################
::# dk_removeFromFile(string file)
::#
::#
:dk_removeFromFile
	call dk_debugFunc 2

	sed -i -e "/$1/d" $2
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_removeFromFile
goto:eof